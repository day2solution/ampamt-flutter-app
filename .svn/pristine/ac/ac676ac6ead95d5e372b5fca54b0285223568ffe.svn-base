import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/model/CityModel.dart';
import 'package:ampamt/model/StateModel.dart';
import 'package:ampamt/model/business/BusinessAccountDetailsModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ServiceEnquiery extends StatefulWidget {
  final String title;
  final String imageName;

  ServiceEnquiery({this.title, this.imageName}) : super();

  @override
  _ServiceEnquieryState createState() => _ServiceEnquieryState(imageName: imageName,title: title);
}

class _ServiceEnquieryState extends State<ServiceEnquiery> {
  final String title;
  final String imageName;

  _ServiceEnquieryState({this.title, this.imageName}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  // static double screenHeight;

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    // screenHeight = _mediaQueryData.size.height;
    // final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title: Row(
          children: [
            Image.asset(
                'assets/images/dashboard/app/' + widget.imageName + '.png',
                width: 40,
                height: 40),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: screenWidth / 30),
              ),
            )
          ],
        ),
      ),
      body: MyCustomForm(imageName: imageName,title: title,),
    );
  }

  getButtonStyle() {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      primary: CompanyStyle.primaryColor,
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final String title;
  final String imageName;

  MyCustomForm({this.title, this.imageName}) : super();
  @override
  MyCustomFormState createState() {
    return MyCustomFormState(title: title);
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final String title;
  final String imageName;

  MyCustomFormState({this.title, this.imageName}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final contactNo = TextEditingController();
  final emailId = TextEditingController();
  final message = TextEditingController();

  // bool _showPassword = false;
  Map<String, dynamic> reqBody = new Map<String, String>();
  Future<List<StateModel>> stateModelFutureList;

  List<StateModel> stateModelList = [];
  List<BusinessAccountDetailsModel> businessAccountDetailModelList = [];
  Future<List<BusinessAccountDetailsModel>> futureBusinessAccountDetailModelList ;
  List<CityModel> cityModellList = [];
  bool isLoadingCity=false;
  bool isSPLoaded=false;
  String selectedStateCode;
  String selectedCityCode;
  // Future<SuccessModel> successModel;
  // bool isLoginProcessed = false;
  bool isStateLoaded=false;
  @override
  void initState() {
    print('calling api');
    super.initState();
    stateModelFutureList = getStateList(context);
    // futureBusinessAccountDetailModelList=searchServiceProvider(reqBody);
  }

  @override
  Widget build(BuildContext context) {
    // String selected;
    // Build a Form widget using the _formKey created above.
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    return Container(
      child: Column(

        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(

                    child: FutureBuilder(
                        future: stateModelFutureList,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return showLoading('Loading State List...');
                          } else if (snapshot.hasError) {
                            print('error at haserror');
                            return Text('Error');
                          } else {
                            return buildStateList(snapshot.data);
                          }
                        }),
                  ),
                  CompanyStyle.getInputElementGap(),
                  isStateLoaded?Container(

                    child: isLoadingCity?showLoading('Loading City List...'):buildCityList(cityModellList),
                  ):Text(""),
                  CompanyStyle.getInputElementGap(),
                  ElevatedButton(
                    style: CompanyStyle.getButtonStyle(),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Search',
                            style: TextStyle(
                              fontSize: screenHeight / 45,
                              letterSpacing: 2,
                            ),
                          ),
                          Icon(Icons.search),
                        ],
                      ),
                      width: double.infinity,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

                          reqBody={
                            'serviceStates':selectedStateCode,
                            'serviceCities':selectedCityCode,
                            'sector':title
                          };
                          debugPrint("here");
                          futureBusinessAccountDetailModelList=searchServiceProvider(reqBody);

                      }
                    },
                  ),
                  //CompanyStyle.getInputElementGap(),
                ],
              ),
            ),
          ),
          isSPLoaded?Expanded(
          child: Container(
            child: buildServiceProviderList(context),
          ),
        ):Text(""),

        ],
      ),
    );
  }
  static getInputFieldStyle(){
    return TextStyle(
        color: Colors.grey[350],
        fontSize: screenWidth/25
    );
  }
  Widget buildCityList(List<CityModel> stateModelList) {
    return  DropdownButtonFormField<CityModel>(
      itemHeight: 100,
      onSaved: (value) {
        debugPrint('values=$value');
      },
      validator: (value) => value == null ? 'Please select city' : null,
      style: TextStyle(

      ),
      dropdownColor: CompanyStyle.primaryColor,
      elevation: 9,
      // value: selected,
      items:
      stateModelList.map<DropdownMenuItem<CityModel>>((CityModel value) {
        return DropdownMenuItem<CityModel>(
          value: value,
          child: Text(value.cityName),
        );
      }).toList(),
      onChanged: (CityModel value) {

        debugPrint('cityCode=${value.cityCode}');
        debugPrint('cityName=${value.cityName}');
        setState(() => {
          selectedCityCode = value.cityCode,
          // isLoadingCity=true
        });

      },

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.apartment, color: Colors.white),
        labelText: "Select City*",
        labelStyle: getInputFieldStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0),),
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
      ),
    );
  }
  Widget showLoading(String msg) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor:
              AlwaysStoppedAnimation<Color>(CompanyStyle.primaryColor[900]),
            ),
            height: 1,
            width: screenWidth / 2,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            msg != null ? msg : 'Loading...',
            style: TextStyle(fontSize: screenWidth / 20),
          ),
        ],
      ),
    );
  }
  Widget buildStateList(List<StateModel> stateModelList) {
    return DropdownButtonFormField<StateModel>(
      itemHeight: 100,
      onSaved: (value) {
        debugPrint('values=$value');
      },
      validator: (value) => value == null ? 'Please select state' : null,
      style: TextStyle(
      ),
      dropdownColor: CompanyStyle.primaryColor,
      elevation: 9,
      items:
      stateModelList.map<DropdownMenuItem<StateModel>>((StateModel value) {
        return DropdownMenuItem<StateModel>(
          value: value,
          child: Text(value.stateName),
        );
      }).toList(),
      onChanged: (StateModel value) {
        debugPrint('StateModel=$value');
        debugPrint('stateCode=${value.stateCode}');
        debugPrint('stateName=${value.stateName}');
        setState(() => {
          selectedStateCode = value.stateCode,
          isLoadingCity=true
        });
        getCityList(context, value.stateCode);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.apartment, color: Colors.white),
        labelText: "Select State*",
        labelStyle: getInputFieldStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0),),
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
      ),
    );
  }
  Widget buildServiceProviderList(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(10),
      child:FutureBuilder(
          future: futureBusinessAccountDetailModelList,
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.data==null){
              return showLoading("loading Dtl");
            }else if(snapshot.hasError){
              print('error at haserror');
              return Text('Error');
            }
            else{
              return ListView.builder(
                  itemCount:snapshot.data.length ,
                  itemBuilder: (context,int index){
                    return buildServiceProvidertiles(snapshot.data[index]);
                  });

            }
          }
      ),
    );

  }

  Future<List<CityModel>> getCityList(
      BuildContext context, String stateCode) async {
    ApiProvider _provider = new ApiProvider();
    Map<String, dynamic> locationForm = new Map<String, String>();
    locationForm = {
      'stateCode': stateCode,
    };
    try {
      final response =
      await _provider.post("/location/get-city-list", locationForm);
      cityModellList =
          (response as List).map((data) => CityModel.fromJson(data)).toList();
      setState(() => {cityModellList = cityModellList,isLoadingCity=false});
      // items.addAll(DropdownMenuItem(ampamtTherapiesModelList));
    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
      // _scaffoldKey.currentState.ScaffoldMessenger.showSnackBar(snackBar);
    }
    return cityModellList;
  }
  Future<List<StateModel>> getStateList(BuildContext context) async {
    ApiProvider _provider = new ApiProvider();

    try {
      final response = await _provider.post("/location/get-state-list", {});
      stateModelList =
          (response as List).map((data) => StateModel.fromJson(data)).toList();
      setState(() {
        isStateLoaded=true;
      });
    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
    }
    return stateModelList;
  }

  Future<List<BusinessAccountDetailsModel>> searchServiceProvider(Map<String, dynamic> reqBody) async{
    debugPrint("Searching...");
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isSPLoaded=false;
    });
    showProgressIndicator("Searching");
    try {
      final response = await _provider.post("/account/search-service-providers", reqBody);
      businessAccountDetailModelList =
          (response as List).map((data) => BusinessAccountDetailsModel.fromJson(data)).toList();
      debugPrint('length found=${businessAccountDetailModelList.length}');
      dismissProgressIndicator();
      setState(() {
        isSPLoaded=true;
      });
    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
    }
    return businessAccountDetailModelList;
  }
  showProgressIndicator(String msg){
    EasyLoading.show(status: msg,);
  }
  showSuccessIndicator(String msg){
    EasyLoading.showSuccess(msg,duration: Duration(milliseconds: 700));
  }
  dismissProgressIndicator(){
    EasyLoading.dismiss(animation: true);
  }

  Widget buildServiceProvidertiles(BusinessAccountDetailsModel businessAccountDetailsModel) {
    return Container(
        padding:EdgeInsets.all(1),
        child:Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: CompanyStyle.primaryColor[1003].withOpacity(0.2),
                width: 2,
              )
          ),
          color: CompanyStyle.primaryColor,
          clipBehavior: Clip.antiAlias,

          child: Container(
            child: Column(
              children: [
                Container(
                  child: ListTile(
                    leading: Icon(Icons.business_outlined,size: 20),
                    title: Text((businessAccountDetailsModel.companyName!=null?businessAccountDetailsModel.companyName:"") + ' ' +
                        (businessAccountDetailsModel.companyTitle!=null?businessAccountDetailsModel.companyTitle:"") ),
                        ),
                ),
               Container(
                 padding:EdgeInsets.fromLTRB(10, 0, 10, 10),
                 child: Column(
                   children: [
                     Row(
                       children: <Widget>[

                         Icon(Icons.info,size: 20),
                         Text(CommonUtil.convertToTitleCaseReturnDash(businessAccountDetailsModel.ownerDetail) ),
                       ],
                     ),
                     SizedBox(height: 3,),
                     Row(
                       children: <Widget>[

                         Icon(Icons.person,size: 20),
                         Flexible(child:Text(businessAccountDetailsModel.companyOwnerName )),
                       ],
                     ),
                     SizedBox(height: 3,),
                     Row(
                       children: <Widget>[
                         Icon(Icons.email,size: 20,color: Colors.blue,),
                         Text(businessAccountDetailsModel.emailId!=null?businessAccountDetailsModel.emailId:"-" , style: TextStyle(color: Colors.blue),),
                       ],
                     ),
                     SizedBox(height: 3,),
                     Row(
                         children: <Widget>[
                           businessAccountDetailsModel.contactNo!=null?Expanded(
                               child: Row(
                                 children: <Widget>[

                                   Icon(Icons.call,size: 20,color: Colors.blue,),

                                   RichText(
                                     text:TextSpan(
                                       style: TextStyle(color: Colors.blue),
                                       text: businessAccountDetailsModel.contactNo,
                                       recognizer: TapGestureRecognizer()..onTap = () => {
                                         print('call to emergencyNo '+businessAccountDetailsModel.contactNo),
                                         _makePhoneCall(businessAccountDetailsModel.contactNo)
                                       },
                                     ),
                                   ),
                                 ],
                               )
                           ):Text(""),
                           businessAccountDetailsModel.otherContactNo!=null?Expanded(
                               child: Row(
                                 children: <Widget>[

                                   Icon(Icons.phone_android,size: 20,color:Colors.red),

                                   RichText(
                                     text:TextSpan(
                                       style: TextStyle(color: Colors.blue),
                                       text: businessAccountDetailsModel.otherContactNo,
                                       recognizer: TapGestureRecognizer()..onTap = () => {
                                         print('call to emergencyNo '+businessAccountDetailsModel.otherContactNo),
                                         _makePhoneCall(businessAccountDetailsModel.otherContactNo)
                                       },
                                     ),
                                   ),
                                 ],
                               )
                           ):Text(""),
                           businessAccountDetailsModel.whatsappNo!=null?Expanded(
                               child: Row(
                                 children: <Widget>[
                                   Icon(Icons.chat,size: 20,color:Colors.green),
                                   RichText(
                                     text:TextSpan(
                                       style: TextStyle(color: Colors.blue),
                                       text: businessAccountDetailsModel.whatsappNo,
                                       recognizer: TapGestureRecognizer()..onTap = () => {
                                         print('call to emergencyNo '+businessAccountDetailsModel.whatsappNo),
                                         _makePhoneCall(businessAccountDetailsModel.whatsappNo)
                                       },
                                     ),
                                   ),
                                 ],
                               )
                           ):Text(""),
                         ],
                       ),
                     SizedBox(height: 3,),
                     Row(
                       children: <Widget>[
                         Text("Pincode : "+businessAccountDetailsModel.zipCode ),
                       ],
                     ),
                     SizedBox(height: 3,),
                     Row(
                       children: <Widget>[
                         Text("State : "+CommonUtil.convertToTitleCaseReturnDash(businessAccountDetailsModel.state) ),
                       ],
                     ),
                     SizedBox(height: 3,),
                     Row(
                       children: <Widget>[
                         Text("Landmark : "+CommonUtil.convertToTitleCaseReturnDash(businessAccountDetailsModel.landmark) ),
                       ],
                     ),
                     SizedBox(height: 3,),
                     Row(
                       children: <Widget>[
                         Text("Address : "+ CommonUtil.convertToTitleCaseReturnDash(businessAccountDetailsModel.registOfficeAdd) ),
                       ],
                     ),
                   ],
                 ),
               ),

              ],
            ),
          ),
        )
    );
  }
  _makePhoneCall(String url) async {
    FlutterPhoneDirectCaller.callNumber(url);
  }
}
SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor) {
  return SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: txtColor),
      ),
      backgroundColor: bgcolor);
}

