import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/dashboard/admin/admin-action.dart';
import 'package:ampamt/dashboard/event/my-event.dart';
import 'package:ampamt/dashboard/event/upcomming-event.dart';
import 'package:ampamt/dashboard/profile/business-profile.dart';
import 'package:ampamt/dashboard/profile/doctor-profile.dart';
import 'package:ampamt/dashboard/service/service-enquiry.dart';
import 'package:ampamt/dashboard/service/user-services.dart';
import 'package:ampamt/main.dart';
import 'package:ampamt/model/AdvertisementModel.dart';
import 'package:ampamt/model/app-update-model.dart';
import 'package:ampamt/model/business/BusinessAccountDetailsModel.dart';
import 'package:ampamt/model/doctor/DoctorsAccountDetailsModel.dart';
import 'package:ampamt/other/app-update-screen.dart';
import 'package:ampamt/other/customer-support.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomePage extends StatefulWidget {
  UserHomePage({Key key, this.accountId,this.accountType}) : super(key: key);
  final String accountId;
  final String accountType;

  @override
  _UserHomePageState createState() => _UserHomePageState(accountId: accountId,accountType: accountType);
}

class _UserHomePageState extends State<UserHomePage> {
  _UserHomePageState({ this.accountId,this.accountType});
  final String accountId;
  final String accountType;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  bool isAdmin=false;
  // final List<String> images = [];
  Future<List<AdvertisementModel>>  advertisementFutureModellist;
  Future<List<DoctorsAccountDetailsModel>> doctorsAccountDetailsFutureList;
  Future<List<BusinessAccountDetailsModel>> businessAccountDetailsFutureList;

  DoctorsAccountDetailsModel doctorsAccountModel;
  BusinessAccountDetailsModel businessAccountModel;
  List<AdvertisementModel> advertisementModelList=[];
  List<DoctorsAccountDetailsModel> doctorsAccountDetailsModelList=[];
  List<BusinessAccountDetailsModel> businessAccountDetailsModel=[];
  Future<AppUpdateModel> futureAppUpdateModel;
String versionName="";
Future<String> futureVersionName;
  @override
  void initState() {
    super.initState();
    debugPrint('UserHomePage');
    debugPrint('accountId=$accountId');
    debugPrint('accountType=$accountType');
    futureAppUpdateModel=getAppUpdateDetails();

    advertisementFutureModellist= getAdvertisementsList(context);
    setState(() {

      if(accountType!=null){
        if(accountType==CommonConstant.ACCOUNT_DOCTOR){
          doctorsAccountDetailsFutureList=getLoggedDoctorAccount(context);
          doctorsAccountDetailsFutureList.then((value) => {
            doctorsAccountModel=value[0],
          debugPrint('doctorsAccountModel=$doctorsAccountModel'),
          });
        }
        if(accountType==CommonConstant.ACCOUNT_BUSINESS){
          businessAccountDetailsFutureList=getLoggedBusinessAccount(context);
          businessAccountDetailsFutureList.then((value) => {
            businessAccountModel=value[0],
          });
        }
      }

      futureVersionName=CommonUtil.getVersionCode();
      futureVersionName.then((value) =>
      versionName=value,
      );
    });

  }
  checkForUpdate(){
    futureAppUpdateModel.then((value) => {
      debugPrint('version from file='+value.version.toString()),
      compareVersion(value),
    });
  }
  compareVersion(AppUpdateModel updateModel){
    CommonUtil.getProjectCode().then((value) =>{
      if(updateModel.version>int.parse(value)){
        // showAppUpdateDialog(),
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AppUpdateScreen(appUpdateModel: updateModel,)))
      }else{
        showAppUpdateDialog(context),
      }
    });
  }
  void showAppUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: CompanyStyle.primaryColor,
          title: new Text("App Update!",style: TextStyle(color: Colors.red),),
          content: new Text('Your application is up to date'),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new ElevatedButton(

              style: CompanyStyle.getButtonStyle(),
              child: new Text("Close",),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<AppUpdateModel> getAppUpdateDetails() async{
    Map<String, dynamic> reqBody = new Map<String, String>();
    ApiProvider _provider = new ApiProvider();
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
void setLoggedDetail()async{
  final SharedPreferences prefs = await _prefs;
  prefs.setString("accountId", accountId);
  prefs.setString("accountType", accountType);
}
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: WillPopScope(
          onWillPop: _onBackWillPop,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(top: 1,bottom: 10),
                child:Container(
                  alignment: Alignment.center,

                  child: Card(
                    // margin: EdgeInsetsGeometry.lerp(EdgeInsets.only(top: 2), EdgeInsets.only(left: 10), 2),
                    color: CompanyStyle.primaryColor,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text('ALL INDIA ONLINE SERVICES',
                          style: TextStyle(fontSize: screenWidth / 25)),
                    ),
                  ),
                  color: CompanyStyle.primaryColor[200],
                ),
                width: screenWidth,
                color: CompanyStyle.primaryColor,
              ),
              Container(
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                alignment: Alignment.center,
                width: screenWidth,
                child: Row(
                    crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(onPressed: () { goToService('47','LEGAL SOLUTION GUIDANCE');},
                                child: Image.asset('assets/images/dashboard/app/47.png',width: screenHeight / 12, height: screenHeight / 12,)
                              ),

                              Text('LEGAL SOLUTION GUIDANCE',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(
                                onPressed: () {
                                    goToService('3','CHARTERED ACCOUNTANT & CS');
                              },
                            child:Image.asset(
                                'assets/images/dashboard/app/3.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('CHARTERED ACCOUNTANT & CS',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToService('33','GOVERNMENT LICENSES');},
                              child:Image.asset(
                                'assets/images/dashboard/app/33.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('GOVERNMENT LICENSES',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToService('50','ONLINE PROMOTION');},
                              child:Image.asset(
                                'assets/images/dashboard/app/50.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('ONLINE\r\nPROMOTION',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToService('52','CONTENT WRITING');},
                              child:Image.asset(
                                'assets/images/dashboard/app/52.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('CONTENT\r\nWRITING',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToService('49','DESIGNING & PACKAGING');},
                              child:Image.asset(
                                'assets/images/dashboard/app/49.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('DESIGNING & PACKAGING',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToService('53','LAB,TESTING & QUALITY CHECK');},
                              child:Image.asset(
                                'assets/images/dashboard/app/53.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('LAB,TESTING & QUALITY CHECK',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToService('54','SALES & MARKETING');},
                              child:Image.asset(
                                'assets/images/dashboard/app/54.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('SALES &\r\nMARKETING',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToService('51','PRINTER & PACKAGING');},
                              child:Image.asset(
                                'assets/images/dashboard/app/51.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('PRINTER &\r\nPACKAGING',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child:FutureBuilder(
                    future: advertisementFutureModellist,
                    builder: (context,AsyncSnapshot snapshot){

                      if(snapshot.connectionState==ConnectionState.waiting){
                        return showLoading();
                      }else if(snapshot.hasError){
                        debugPrint('error at haserror');
                        return Text('Error');
                      }
                      else{
                        setLoggedDetail();
                        if(snapshot.data!=null && snapshot.data.length>0){
                          return  buildCorouselSlider(snapshot.data);
                        }else{
                          return Text('');
                        }
                      }
                    }
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(top: 10,bottom: 10),
                child:Container(
                  alignment: Alignment.center,

                child: Card(
                  // margin: EdgeInsetsGeometry.lerp(EdgeInsets.only(top: 2), EdgeInsets.only(left: 10), 2),
                  color: CompanyStyle.primaryColor,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text('MANUAL LOCAL CITY SERVICES',
                        style: TextStyle(fontSize: screenWidth / 25)),
                  ),
                ),
                  color: CompanyStyle.primaryColor[200],
                ),
                width: screenWidth,
                color: CompanyStyle.primaryColor,
              ),

              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('1','AMPAMT');},
                              child:Image.asset(
                                'assets/images/dashboard/app/1.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('AMPAMT',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('99','AMCI');},
                              child:Image.asset(
                                'assets/images/dashboard/app/99.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('AMCI',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('34','BANK');},
                              child:Image.asset(
                                'assets/images/dashboard/app/34.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('BANK',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('44','B2B');},
                              child:Image.asset(
                                'assets/images/dashboard/app/44.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('B2B\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('45','B2C');},
                              child:Image.asset(
                                'assets/images/dashboard/app/45.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('B2C\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('30','BOOKS LAUNCH');},
                              child:Image.asset(
                                'assets/images/dashboard/app/30.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('BOOKS\r\nLAUNCH',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('2','LEGAL ADVISORS (LAWYERS)');},
                              child:Image.asset(
                                'assets/images/dashboard/app/2.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('LEGAL ADVISORS (LAWYERS)',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('3','CHARTERED ACCOUNTANT & CS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/3.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('CHARTERED ACCOUNTANT & CS',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('33','TRADE LICENCES');},
                              child:Image.asset(
                                'assets/images/dashboard/app/33.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('TRADE\r\nLICENCES',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('55','GOVERNMENT UPDATES');},
                              child:Image.asset(
                                'assets/images/dashboard/app/55.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('GOVERNMENT\r\nUPDATES',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('4','GOVT. SCHEMES / SUBSIDIES');},
                              child:Image.asset(
                                'assets/images/dashboard/app/4.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('GOVT. SCHEMES / SUBSIDIES',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('56','COURT ORDER');},
                              child:Image.asset(
                                'assets/images/dashboard/app/56.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('COURT\r\nORDER',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('31','GOVERNMENT APPROVED LABS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/31.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('GOVERNMENT APPROVED LABS',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('32','RESEARCH & DEVELOPMENT');},
                              child:Image.asset(
                                'assets/images/dashboard/app/32.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('RESEARCH & DEVELOPMENT',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('medicomp','MEDICAL COMPANIES');},
                              child:Image.asset(
                                'assets/images/dashboard/app/medicomp.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('MEDICAL\r\nCOMPANIES',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('24','INSTITUTE & UNIVERSITIES');},
                              child:Image.asset(
                                'assets/images/dashboard/app/24.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('INSTITUTE & UNIVERSITIES',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('27','FINANCE & INVESTMENT');},
                              child:Image.asset(
                                'assets/images/dashboard/app/27.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('FINANCE & INVESTMENT',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('23','COACHING & TRAINING');},
                              child:Image.asset(
                                'assets/images/dashboard/app/23.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('COACHING &\r\nTRAINING',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('17','ARCHITECTS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/17.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('ARCHITECTS\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('18','ENGINEERS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/18.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('ENGINEERS\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('payment-done','FINANCIAL PLANNER');},
                              child:Image.asset(
                                'assets/images/dashboard/app/payment-done.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('FINANCIAL\r\nPLANNER',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('26','MANFORCE CONSULTANT');},
                              child:Image.asset(
                                'assets/images/dashboard/app/26.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('MANFORCE CONSULTANT',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('11','MANUFACTURS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/11.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('MANUFACTURS\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('12','AGRICULTURE');},
                              child:Image.asset(
                                'assets/images/dashboard/app/12.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('AGRICULTURE\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('7','BRANDING & PACKAGING');},
                              child:Image.asset(
                                'assets/images/dashboard/app/7.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('BRANDING & PACKAGING',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('49','DESIGNING');},
                              child:Image.asset(
                                'assets/images/dashboard/app/49.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('DESIGNING\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('8','debugPrintING');},
                              child:Image.asset(
                                'assets/images/dashboard/app/8.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('debugPrintING\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('52','CONTENT WRITER');},
                              child:Image.asset(
                                'assets/images/dashboard/app/52.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('CONTENT\r\nWRITER',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('54','SALES & MARKETING');},
                              child:Image.asset(
                                'assets/images/dashboard/app/54.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('SALES &\r\nMARKETING',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('16','PRO');},
                              child:Image.asset(
                                'assets/images/dashboard/app/16.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('PRO\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('14','ENTREPRENUR');},
                              child:Image.asset(
                                'assets/images/dashboard/app/14.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('ENTREPRENUR\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('59','HUMAN RIGHTS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/59.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('HUMAN\r\nRIGHTS',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('60','ASTROLOGY');},
                              child:Image.asset(
                                'assets/images/dashboard/app/60.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('ASTROLOGY\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('20','WELLNESS CENTERS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/20.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('WELLNESS\r\nCENTERS',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('15','CLINIC');},
                              child:Image.asset(
                                'assets/images/dashboard/app/15.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('CLINIC\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('19','HOSPITALS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/19.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('HOSPITALS\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('12','EQUIPMENT SUPPLIERS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/21.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('EQUIPMENT\r\nSUPPLIERS',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('10','MACHINERIES');},
                              child:Image.asset(
                                'assets/images/dashboard/app/10.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('MACHINERIES\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('22','RAW MATERIAL SUPPLIERS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/22.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('RAW MATERIAL SUPPLIERS',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('6','SERVICE PROVIDER');},
                              child:Image.asset(
                                'assets/images/dashboard/app/6.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('SERVICE\r\nPROVIDER',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('insurance','INSURANCE');},
                              child:Image.asset(
                                'assets/images/dashboard/app/insurance.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('INSURANCE\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('13','DISTRIBUTOR');},
                              child:Image.asset(
                                'assets/images/dashboard/app/13.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('DISTRIBUTOR\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('42','EXIBITIONS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/42.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('EXIBITIONS\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('41','EVENTS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/41.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('EVENTS\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('57','SOCIAL PROMOTER');},
                              child:Image.asset(
                                'assets/images/dashboard/app/57.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('SOCIAL\r\nPROMOTER',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('61','HOTEL');},
                              child:Image.asset(
                                'assets/images/dashboard/app/61.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('HOTEL',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('62','RESTAURANT');},
                              child:Image.asset(
                                'assets/images/dashboard/app/62.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('RESTAURANT',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('35','TOURISM');},
                              child:Image.asset(
                                'assets/images/dashboard/app/35.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('TOURISM',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('38','TRANSPORT');},
                              child:Image.asset(
                                'assets/images/dashboard/app/38.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('TRANSPORT',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('64','GAUSHALA');},
                              child:Image.asset(
                                'assets/images/dashboard/app/64.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('GAUSHALA',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('39','REAL ESTATE');},
                              child:Image.asset(
                                'assets/images/dashboard/app/39.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('REAL ESTATE',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.only(left: 1,top: 1,bottom: 1,right: 1),
                width: screenWidth,
                child: Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(

                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            TextButton(onPressed: () { goToEnquiery('temple','TEMPLE');},
                              child:Image.asset(
                                'assets/images/dashboard/app/temple.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('TEMPLE\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(onPressed: () { goToEnquiery('doctor','PRACTITIONERS');},
                              child:Image.asset(
                                'assets/images/dashboard/app/doctor.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),

                              Text('PRACTITIONERS\r\n',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(onPressed: () { goToEnquiery('otherservices','OTHER SERVICES');},
                              child:Image.asset(
                                'assets/images/dashboard/app/otherservices.png',
                                width: screenHeight / 12,
                                height: screenHeight / 12,
                              )),
                              //
                              Text('OTHER\r\nSERVICES',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: getServicesTextStyle()),
                            ]),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
          // )
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(children: <Widget>[

                Image.asset(
                  'assets/images/icon.png',
                  width: 105,
                ),
                CompanyStyle.getGap10(),
                doctorsAccountDetailsFutureList!=null?Container(
                  child:FutureBuilder(
                      future: doctorsAccountDetailsFutureList,
                      builder: (context,AsyncSnapshot snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return Text('Welcome');
                        }else if(snapshot.hasError){
                          debugPrint('error at haserror');
                          return Text('Welcome');
                        }
                        else{
                          if(snapshot.data!=null && snapshot.data.length>0){
                            return buildDoctorWelcomeText(snapshot.data);
                          }else{
                            return Text('Welcome');
                          }

                        }
                      }
                  ),
                ):(businessAccountDetailsFutureList!=null?Container(
                  child:FutureBuilder(
                      future: businessAccountDetailsFutureList,
                      builder: (context,AsyncSnapshot snapshot){
                        if(snapshot.data==null){
                          return Text('Welcome');
                        }else if(snapshot.hasError){
                          debugPrint('error at haserror');
                          return Text('Welcome');
                        }
                        else{
                          return buildBusinessWelcomeText(snapshot.data);
                        }
                      }
                  ),
                ):Text("Welcome")),
              ]),
              decoration: BoxDecoration(color: CompanyStyle.primaryColor),
            ),
            // ListTile(
            //   leading: Icon(Icons.home),
            //   title: Text('Home', style: getDrawermenuTextStyle()),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title:
                  Text('Government Register', style: getDrawermenuTextStyle()),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.event_available),
              title: Text('My Event', style: getDrawermenuTextStyle()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyEvent(accountId: accountId,)));
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Upcoming Event', style: getDrawermenuTextStyle()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new UpcommingEvent()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile Account', style: getDrawermenuTextStyle()),
              onTap: () {
                  if(accountType==CommonConstant.ACCOUNT_DOCTOR){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>new DoctorProfile(accountId: accountId,doctorsAccDtlModel: doctorsAccountDetailsFutureList,)));
                  }
                  if(accountType==CommonConstant.ACCOUNT_BUSINESS){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>new BusinessProfile(accountId: accountId,businessAccDtlModel: businessAccountDetailsFutureList,)));

                  }
                },
            ),
            accountType==CommonConstant.ACCOUNT_DOCTOR?Container(
              child:FutureBuilder(
                  future: doctorsAccountDetailsFutureList,
                  builder: (context,AsyncSnapshot snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Text('');
                    }else if(snapshot.hasError){
                      debugPrint('error at haserror');
                      return Text('');
                    }
                    else{
                      setLoggedDetail();
                      if(snapshot.data!=null && snapshot.data.length>0){
                        return buildDoctorAdminMenu(snapshot.data);
                      }else{
                        return Text('');
                      }
                    }
                  }
              ),
            ):Container(
              child:FutureBuilder(
                  future: businessAccountDetailsFutureList,
                  builder: (context,AsyncSnapshot snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Text('');
                    }else if(snapshot.hasError){
                      debugPrint('error at haserror');
                      return Text('');
                    }
                    else{
                      setLoggedDetail();
                      if(snapshot.data!=null && snapshot.data.length>0){
                        return buildBusinessAdminMenu(snapshot.data);
                      }else{
                        return Text('');
                      }
                    }
                  }
              ),
            ),
            // isAdmin?ListTile(
            //   leading: Icon(Icons.admin_panel_settings),
            //   title: Text('Admin Panel', style: getDrawermenuTextStyle()),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>new AdminAction()));
            //   },
            // ):Text(''),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.support),
              title: Text('Customer Support', style: getDrawermenuTextStyle()),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new CustomerSupport()));
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share', style: getDrawermenuTextStyle()),
              onTap: () {
                Navigator.pop(context);
                shareAboutApp();
              },
            ),
            ListTile(
              leading: Icon(Icons.system_update),
              title: Text('Check For Update', style: getDrawermenuTextStyle()),
              onTap: () {
                Navigator.pop(context);
                checkForUpdate();
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout', style: getDrawermenuTextStyle()),
              onTap: () {
                logout();

              },
            ),
            Container(
              child:FutureBuilder(
                  future: futureVersionName,
                  builder: (context,AsyncSnapshot snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return Text('');
                    }else if(snapshot.hasError){
                      debugPrint('error at haserror');
                      return Text('');
                    }
                    else{
                      setLoggedDetail();
                      if(snapshot.data!=null && snapshot.data.length>0){
                        return buildVersionDetails(snapshot.data);
                      }else{
                        return Text('');
                      }
                    }
                  }
              ),
            ),
            // Container(
            //     alignment: Alignment.center,
            //     padding:EdgeInsets.only(left: screenWidth/4,),
            //     child: Align(
            //         alignment: FractionalOffset.bottomCenter,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             // Divider(),
            //             ListTile(
            //                 leading: Icon(Icons.android),
            //                 title: Text(versionName, style: TextStyle(fontSize: screenWidth/30)))
            //           ],
            //         )
            //     )
            // ),
          ],
        ),
      ),
    );
  }
  Widget showLoading(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(CompanyStyle.primaryColor[900]),
            ),
            height:1,
            width: screenWidth/5,
          ),
          // SizedBox(height: 10,),
          // Text('Loading Users...',style: TextStyle(fontSize: screenWidth/20),),
        ],
      ),
    );
  }
  buildCorouselSlider(List<AdvertisementModel> advertisementModelList){
    debugPrint(advertisementModelList.length.toString());
    debugPrint("count="+(advertisementModelList.length / 2).round().toString());
    return Container(
        height: screenWidth/5,
        child: CarouselSlider.builder(

          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 1.0,
            enlargeCenterPage: true,
            viewportFraction: 1,
            scrollDirection: Axis.vertical,
          ),
          itemCount: advertisementModelList.length,
          itemBuilder: (context, index, realIdx) {
            return Container(
              // child: Text(ddvertisementModelList[index].advId),
              //   child: Image.asset(images[index], fit: BoxFit.contain, width: screenWidth,)
              child: CommonUtil.getImageFromBase64FillSize(advertisementModelList[index].extras, context),
            );
          },
        )
    );
  }
  buildDoctorAdminMenu(List<DoctorsAccountDetailsModel> docAccount){
    isAdmin=false;
    if(!CommonUtil.isBlank(docAccount[0].adminFlag)){
      if(docAccount[0].adminFlag==CommonConstant.FLAG_Y){
        isAdmin=true;
      }else{
        isAdmin=false;
      }
    }

    return isAdmin?ListTile(
      leading: Icon(Icons.admin_panel_settings),
      title: Text('Admin Panel', style: getDrawermenuTextStyle()),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new AdminAction(businessAccModel: businessAccountModel,doctorsAccModel: doctorsAccountModel)));
      },
    ):Text('');
  }
  buildBusinessAdminMenu(List<BusinessAccountDetailsModel> businessAccount){
    isAdmin=false;
    if(!CommonUtil.isBlank(businessAccount[0].adminFlag)){
      if(businessAccount[0].adminFlag==CommonConstant.FLAG_Y){
        isAdmin=true;
      }else{
        isAdmin=false;
      }
    }

    return isAdmin?ListTile(
      leading: Icon(Icons.admin_panel_settings),
      title: Text('Admin Panel', style: getDrawermenuTextStyle()),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new AdminAction(businessAccModel: businessAccountModel,doctorsAccModel: doctorsAccountModel,)));
      },
    ):Text('');
  }
  buildDoctorWelcomeText(List<DoctorsAccountDetailsModel> doctorsAccountDetailsModellist){
    String firstName;
    String lastName;
    String nameTitle;
    debugPrint('isAdmin 2=$isAdmin');
    if(doctorsAccountDetailsModellist!=null && doctorsAccountDetailsModellist.length>0){
      if(doctorsAccountDetailsModellist[0].nameTitle!=null){
        nameTitle=CommonUtil.convertToTitleCase(doctorsAccountDetailsModellist[0].nameTitle);
      }
      if(doctorsAccountDetailsModellist[0].firstName!=null){
        firstName=CommonUtil.convertToTitleCase(doctorsAccountDetailsModellist[0].firstName);
      }
      if(doctorsAccountDetailsModellist[0].lastName!=null){
        lastName=CommonUtil.convertToTitleCase(doctorsAccountDetailsModellist[0].lastName);
      }

    }

    return Text("Welcome "+nameTitle+" "+firstName+" "+lastName,style: TextStyle(fontSize: screenWidth/30),);
  }
  buildBusinessWelcomeText(List<BusinessAccountDetailsModel> businessAccountDetailsModelList){
    debugPrint("businessAccountDetailsModelList=$businessAccountDetailsModelList");
    String companyTitle;
    String companyName;

    if(businessAccountDetailsModelList!=null && businessAccountDetailsModelList.length>0){
      debugPrint("here");
      if(businessAccountDetailsModelList[0].companyTitle!=null){
        companyTitle=CommonUtil.convertToTitleCase(businessAccountDetailsModelList[0].companyTitle);
        debugPrint(companyTitle);
      }

      if(businessAccountDetailsModelList[0].companyName!=null){
        companyName=CommonUtil.convertToTitleCase(businessAccountDetailsModelList[0].companyName);
        debugPrint(companyName);
      }

    }
    debugPrint(companyTitle);
    return Text("Welcome "+companyName+" "+companyTitle,style: TextStyle(fontSize: screenWidth/30),);
  }
  Future<List<AdvertisementModel>> getAdvertisementsList( BuildContext context) async{

    ApiProvider _provider = new ApiProvider();
    try {
      final response = await _provider.post("/advertisement/get-advertisement-list",{});
      advertisementModelList = (response as List).map((data) => AdvertisementModel.fromJson(data)).toList();
      // setLoggedDetail();

    } catch (e) {
      debugPrint('error at getAdvertisementsList page='+e.toString().toString());
      // final snackBar =normalSnackBar(e.toString().toString(), Colors.red,  Colors.white);
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    return advertisementModelList;
  }
  Future<List<DoctorsAccountDetailsModel>> getLoggedDoctorAccount( BuildContext context) async{
    Map<String, dynamic> reqBody = new Map<String, String>();
    reqBody={
      'id': accountId,
      'accountType': accountType

    };
    ApiProvider _provider = new ApiProvider();
    try {
      final response = await _provider.post("/account/get-doctor-detail",reqBody);
      doctorsAccountDetailsModelList = (response as List).map((data) => DoctorsAccountDetailsModel.fromJson(data)).toList();

    } catch (e) {
      debugPrint('error at getAdvertisementsList page='+e.toString().toString());
      // final snackBar =normalSnackBar(e.toString().toString(), Colors.red,  Colors.white);
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    return doctorsAccountDetailsModelList;
  }
  // Future<List<BusinessAccountDetailsModel>> getLoggedBusinessAccount( BuildContext context) async{
  //   ApiProvider _provider = new ApiProvider();
  //   try {
  //     final response = await _provider.post("/account/get-business-acc-detail",{});
  //     ddvertisementModelList = (response as List).map((data) => AdvertisementModel.fromJson(data)).toList();
  //
  //   } catch (e) {
  //     debugPrint('error at getAdvertisementsList page='+e.toString().toString());
  //     final snackBar =normalSnackBar(e.toString().toString(), Colors.red,  Colors.white);
  //     _scaffoldKey.currentState.showSnackBar(snackBar);
  //   }
  //   return ddvertisementModelList;
  // }
  SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor){
    return SnackBar(
        content: Text(msg,
          style: TextStyle(color:txtColor),
        ),
        backgroundColor: bgcolor
    );
  }
  getDrawermenuTextStyle() {
    return TextStyle(
      fontSize: 20,
    );
  }

  // Future<bool> _onWillPop() async {
  //   return (await showDialog(
  //         context: context,
  //         builder: (context) => new AlertDialog(
  //           backgroundColor: CompanyStyle.primaryColor,
  //           title: new Text('Are you sure?'),
  //           content: new Text('Do you want to exit an App'),
  //           actions: <Widget>[
  //             new TextButton(
  //               onPressed: () => Navigator.of(context).pop(false),
  //               child: new Text('No'),
  //             ),
  //             new TextButton(
  //               onPressed: () => Navigator.of(context).pop(true),
  //               child: new Text('Yes'),
  //             ),
  //           ],
  //         ),
  //       )) ??
  //       false;
  // }
  Future<bool> _onBackWillPop() async {

    return (await showModalBottomSheet(
        context: context,
        backgroundColor: CompanyStyle.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text('Are you sure you want to exit AMPAMT?',style: TextStyle(fontSize: screenWidth/22),),
              Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children:<Widget> [
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 150,
                                child:  ElevatedButton(

                                  style: CompanyStyle.getButtonStyle(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Yes',style: TextStyle(fontSize: screenWidth/22,color: Colors.red),),
                                    SizedBox(width: 10,),
                                        Icon(Icons.power_settings_new_sharp,color: Colors.red,),
                                    ],
                                    ),

                                  onPressed: () => SystemNavigator.pop(),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 150,
                                child:  ElevatedButton(
                                  style: CompanyStyle.getButtonStyle(),
                                  child: Text('No',style: TextStyle(fontSize: screenWidth/22,color: Colors.green)),
                                  onPressed: () => Navigator.of(context).pop(false),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ]
              ),
            ],
          );
        }));
  }
  // int getGridColumns() {
  //
  //   return (screenWidth / 100).round();
  // }

  getServicesTextStyle() {
    return TextStyle(
      fontSize: screenWidth / 35,
    );
  }

  getServicesTIGap() {
    return SizedBox(
      height: 5.0,
    );
  }
  goToService(String iconName,String title){
   if(doctorsAccountDetailsModelList.length>0){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>UserServices(title: title,imageName: iconName,doctorModel: doctorsAccountDetailsModelList[0],businessModel: null,)));
   }
   if(businessAccountDetailsModel.length>0){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>UserServices(title: title,imageName: iconName,doctorModel: null,businessModel: businessAccountDetailsModel[0],)));
   }

  }
  goToEnquiery(String iconName,String title){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceEnquiery(title: title,imageName: iconName,)));

  }
  shareAboutApp() async{
    String textToShare="AMPAMT will Create Platform, Awareness, Promote, Protect & All related Services for Alternate Medical Doctors, Pan India and Globally."
        "\r\n\r\nPlease add my UNIQUE ID $accountId as reference during signup and download our app from play store:";
    textToShare+="\r\n\r\n"+CommonConstant.APP_PLAY_STORE_LINK;
    textToShare+="\r\n\r\nor Visit https://ampamt.com";
    final RenderBox box = context.findRenderObject();
    await Share.share(textToShare,
        subject: 'AMPAMT',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Future<List<BusinessAccountDetailsModel>> getLoggedBusinessAccount(BuildContext context) async{
    Map<String, dynamic> reqBody = new Map<String, String>();
    reqBody={
      'id': accountId,
      'accountType': accountType

    };
    ApiProvider _provider = new ApiProvider();
    try {
      final response = await _provider.post("/account/get-business-acc-detail",reqBody);
      businessAccountDetailsModel = (response as List).map((data) => BusinessAccountDetailsModel.fromJson(data)).toList();

    } catch (e) {
      debugPrint('error at getAdvertisementsList page='+e.toString().toString());
      // final snackBar =normalSnackBar(e.toString().toString(), Colors.red,  Colors.white);
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    return businessAccountDetailsModel;
  }

  void logout() async{
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  MyWelcomePage(title: 'AMPAMT',)));
  }

  Widget buildVersionDetails(String version) {
    debugPrint('in buildVersionDetails version=$version');

    return Container(
        alignment: Alignment.center,
        padding:EdgeInsets.only(left: screenWidth/4,),
        child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Divider(),
                ListTile(
                    leading: Icon(Icons.android),
                    title: Text(version, style: TextStyle(fontSize: screenWidth/30)))
              ],
            )
        )
    );
  }
}
showSnackBar(BuildContext context, String msg, Color bgcolor, Color txtColor) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: txtColor),
      ),
      backgroundColor: bgcolor,
    ));
  });
}