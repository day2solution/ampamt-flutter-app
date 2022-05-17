import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/ChuckBloc.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/CustomAnimation.dart';
import 'package:ampamt/CustomResponseModel.dart';
import 'package:ampamt/config/environment.dart';
import 'package:ampamt/dashboard/user-dashboard.dart';
import 'package:ampamt/login/business-login.dart';
import 'package:ampamt/login/doctor-login.dart';
import 'package:ampamt/model/app-update-model.dart';
import 'package:ampamt/other/app-update-screen.dart';
import 'package:ampamt/registration/business-registration.dart';
import 'package:ampamt/registration/doctor-registration.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/material.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
double screenWidth;

// double screenHeight;
void main() {

  const bool isProduction = bool.fromEnvironment('dart.vm.product');

  if (isProduction) {
    const String environment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: Environment.PROD,
    );
    Environment().initConfig(environment);
    debugPrint = (String message, {int wrapWidth}) {};
  }else{
    const String environment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: Environment.DEV,
    );
    Environment().initConfig(environment);
  }
  debugPrint('isProduction=$isProduction');
  runApp(MyApp());

}
void configLoading(double screenWidth) {

  debugPrint("inside configLoading");
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = screenWidth/4
    ..maskType=EasyLoadingMaskType.custom
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = CompanyStyle.primaryColor[400]
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.white.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'AMPAMT',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor:CompanyStyle.primaryColor,

        primarySwatch: Colors.blue,
      ),
      home: MyWelcomePage(title: 'AMPAMT'),
      builder:  EasyLoading.init(),
    );
  }
  SuccessModel parseProducts( String responseBody) {

    Map<String, dynamic> data= json.decode(responseBody);

    debugPrint('response.rest='+data['count'].toString());
    debugPrint('response.rest='+data.toString());
    var model=SuccessModel.fromJson(data);
    return model;

  }

}

class MyWelcomePage extends StatefulWidget {
  MyWelcomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyWelcomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // AppUpdateInfo _updateInfo;
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey();
  static MediaQueryData _mediaQueryData;
  DateTime currentBackPressTime;
  int count=0;
  Future<AppUpdateModel> futureAppUpdateModel;
  // APIManager apiManager=new APIManager();
  final ChuckBloc _bloc= ChuckBloc();
  @override
  void initState() {
    CommonUtil.getVersionCode().then((value) =>{
      debugPrint('value=$value'),
    });
    debugPrint('calling api');
    super.initState();
    // checkForUpdate();
    _bloc.getuserCount();
    futureAppUpdateModel=getAppUpdateDetails();
    futureAppUpdateModel.then((value) => {
      debugPrint('version from file='+value.version.toString()),
      compareVersion(value),
    });
  }
  compareVersion(AppUpdateModel updateModel){
    debugPrint("opening update screen");
    CommonUtil.getProjectCode().then((value) =>{
      if(updateModel.version>int.parse(value)){
        // showAppUpdateDialog(),
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AppUpdateScreen(appUpdateModel: updateModel,)))
      }
    });
  }
  Future<bool> showAppUpdateDialog() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: CompanyStyle.primaryColor,
            title: const Text('Update available!'),
            content:const Text('App Update Available, Update now?'),
            actions: <Widget>[
              TextButton(
                onPressed: ()  {
                    Navigator.of(context).pop(false);
                  },
                child:const Text('Not Now'),
              ),
              TextButton(
                child:const Text('Update Now'),
                onPressed: () {
                  _launchInBrowser();
                },

              ),
            ],
          ),
        )) ??
        false;
  }

  Future<void> _launchInBrowser() async {
    String url = CommonConstant.APP_PLAY_STORE_LINK;
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        showSnackBar(
            context, 'Could not launch $url', Colors.red, Colors.white);
        throw 'Could not launch $url';
      }
    }
    catch (e) {
      debugPrint(e);
    }
  }
  Future<AppUpdateModel> getAppUpdateDetails() async{
    Map<String, dynamic> reqBody =  Map<String, String>();
    ApiProvider _provider = ApiProvider();
    AppUpdateModel appUpdateModel;
    try {
      final response = await _provider.postAppUpdateData("",reqBody);
      appUpdateModel=AppUpdateModel.fromJson(response['update']);
    } catch (e) {
      debugPrint('error at getAppUpdateDetails='+e.toString().toString());
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    return appUpdateModel;
  }
  void checkLoggedUser()async{
    final SharedPreferences prefs = await _prefs;
    final String accountId = prefs.getString('accountId');
    final String accountType = prefs.getString('accountType');
    debugPrint("accountId from storage=$accountId and accountType=$accountType");
    if(!CommonUtil.isBlank(accountId) && !CommonUtil.isBlank(accountType)){
      if(accountType==CommonConstant.ACCOUNT_DOCTOR){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => UserHomePage(accountId: accountId,accountType: CommonConstant.ACCOUNT_DOCTOR,)));
      }
      if(accountType==CommonConstant.ACCOUNT_BUSINESS){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => UserHomePage(accountId: accountId,accountType: CommonConstant.ACCOUNT_BUSINESS,)));
      }
    }else{
      debugPrint("in else");

      debugPrint("accountId not found");
      prefs.clear();

    }
  }
  @override
  Widget build(BuildContext context) {

    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    configLoading(screenWidth);
    // screenHeight = _mediaQueryData.size.height;

    List<bool> _selections=List.generate(3, (_) => false);
    checkLoggedUser();
    return  Scaffold(
      body:WillPopScope(
          child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Center(
              child: Container(

                child: Column(

                  children: <Widget>[
                    Image.asset('assets/images/icon.png',width: screenWidth/2),
                    CompanyStyle.getGap10(),
                    Text('Please Select Your Login/Signup',style: TextStyle(fontSize:screenWidth/25 ),),
                    CompanyStyle.getGap10(),
                    ToggleButtons(
                      children: <Widget>[
                        Image.asset('assets/images/home/doctor_login.png',width: screenWidth/9,height: screenWidth/9,),
                        Text("\tDOCTOR'S LOGIN\t",style: TextStyle(fontSize:screenWidth/25,letterSpacing: 1,wordSpacing: 6,fontWeight: FontWeight.bold,),),
                        Text("\tSIGNUP\t",style: TextStyle(fontSize:screenWidth/25,letterSpacing: 1,wordSpacing: 6,fontWeight: FontWeight.bold ),)
                      ],
                      isSelected:_selections,
                      onPressed: (int index) {

                        if(index==1){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorLogin()));
                        }
                        if(index==2){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorRegistration()));
                        }
                        debugPrint('index='+index.toString());
                      },
                      borderWidth: 1.5,
                      borderRadius: BorderRadius.circular(10),
                      borderColor: CompanyStyle.primaryColor[400],
                    ),
                    CompanyStyle.getGap15(),
                    ToggleButtons(
                      children: <Widget>[
                        Image.asset('assets/images/home/business_login.png',width: screenWidth/9,height: screenWidth/9),
                        Text("\tBUSINESS LOGIN\t",style: TextStyle(fontSize:screenWidth/25,letterSpacing: 1,wordSpacing: 6,fontWeight: FontWeight.bold),),
                        Text("\tSIGNUP\t",style: TextStyle(fontSize:screenWidth/25 ,letterSpacing: 1,wordSpacing: 6,fontWeight: FontWeight.bold),)
                      ],
                      isSelected:_selections,
                      onPressed: (int index) {
                        if(index==1){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessLogin()));
                        }
                        if(index==2){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessRegistration()));
                        }
                      },
                      borderWidth: 1.5,
                      borderRadius: BorderRadius.circular(10),
                      borderColor: CompanyStyle.primaryColor[400],
                    ),
                    CompanyStyle.getGap20(),
                    Text('Registered Member With Us',style: TextStyle(fontSize:screenWidth/25,letterSpacing: 1.5,wordSpacing: 6 ),),
                    CompanyStyle.getGap2(),
                    Container(
                      child:Center(
                        child: StreamBuilder<CustomResponseModel<SuccessModel>>(
                          stream: _bloc.chuckDataStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              switch (snapshot.data.status) {
                                case Status.LOADING:
                                  return Loading(loadingMessage: snapshot.data.message);
                                  break;
                                case Status.COMPLETED:
                                  return CompletedData(
                                      responseData: snapshot.data.data,
                                      onRetryPressed:()=>_bloc.getuserCount()
                                  );
                                  break;
                                case Status.ERROR:

                                  return Error(errorMessage:snapshot.data.message);
                                  break;
                              }
                            }
                            return Container();
                          },
                        ),
                      ),
                      color: CompanyStyle.primaryColor,
                      height: screenWidth/20,
                    ),
                    CompanyStyle.getGap20(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Image.asset('assets/images/home/msme.png',width: screenWidth/8,height: screenWidth/8,),
                        SizedBox(width: screenWidth/8,),
                        Image.asset('assets/images/home/100-secure.png',width: screenWidth/8,height: screenWidth/8,),
                        SizedBox(width: screenWidth/8,),
                        Image.asset('assets/images/home/iso.png',width: screenWidth/8,height: screenWidth/8,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
          onWillPop: onWillPop
      ),
    );
  }
  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     setState(() {
  //       _updateInfo = info;
  //       debugPrint('update info=$_updateInfo');
  //       _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable?(){
  //         InAppUpdate.performImmediateUpdate().catchError((e) => showSnack(e.toString()));
  //       } : null;
  //     });
  //   }).catchError((e) {
  //     showSnack(e.toString());
  //   });
  // }
  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again to exit app');
      return Future.value(false);
    }
    return Future.value(true);
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('errorMessage='+errorMessage);
    showSnackBar(context, errorMessage, Colors.red, Colors.white);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('NaN', textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth/40,
            ),
          ),
          // ElevatedButton(
          //   // color: Colors.white,
          //   child: Text('Retry', style: TextStyle(color: Colors.black)),
          //   onPressed: onRetryPressed,
          // )
        ],
      ),
    );
  }

}
class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth/10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LinearProgressIndicator(
            backgroundColor: Colors.white,
            minHeight: 1,
            valueColor: AlwaysStoppedAnimation<Color>(CompanyStyle.primaryColor[900]),
          ),
        ],
      ),
    );
  }
}
class CompletedData extends StatelessWidget {
  final SuccessModel responseData;
  final scaffoldKey = GlobalKey<ScaffoldState>();
   CompletedData({Key key, this.responseData,this.onRetryPressed}) : super(key: key);
  final Function onRetryPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            responseData.count.toString(),style: TextStyle(fontSize: screenWidth/25),
          ),
        ],
      ),
    );
  }

  }

  showSnackBar(BuildContext context,String msg,Color bgcolor,Color txtColor) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            msg,
            style: TextStyle(color: txtColor),
          ),
          backgroundColor: bgcolor,
        )
    );
  });

}
