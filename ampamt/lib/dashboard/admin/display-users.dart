import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/dashboard/admin/display/business-account-details.dart';
import 'package:ampamt/dashboard/admin/display/business-documents-details.dart';
import 'package:ampamt/dashboard/admin/display/doctor-account-details.dart';
import 'package:ampamt/dashboard/admin/display/doctor-documents-details.dart';
import 'package:ampamt/model/business/BusinessAccountDetailsModel.dart';
import 'package:ampamt/model/doctor/DoctorAccountStatusModel.dart';
import 'package:ampamt/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:ampamt/util/common-util.dart';

double screenWidth;
class DisplayUsers extends StatefulWidget  {
  @override
  _DisplayUsersState createState() => _DisplayUsersState();
}

class _DisplayUsersState extends State<DisplayUsers>  {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  // static double screenHeight;
  Future<List<DoctorAccountStatusModel>>  doctorAccountStatusModelList;
  Future<List<BusinessAccountDetailsModel>>  futureBusinessAccountDtlsModelList;
  List<DoctorAccountStatusModel> doctorAccountStatusModelList1=[];
  List<DoctorAccountStatusModel> filteredDoctorAccDtlList=[];
  List<BusinessAccountDetailsModel> businessAccountDetailsList=[];
  List<BusinessAccountDetailsModel> filteredBusinessAccDtlList=[];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldKeyBusiness = GlobalKey<ScaffoldState>();
  // static double screenHeight;
  var sd= SearchDelegate;
  bool searchingDoc=false;
  bool searchingBusi=false;
  bool isLoadingDoctorList = true;
  int totalDoctorList=0;
  int totalBusinessList=0;
  @override
  void initState() {
    debugPrint('getting doctors list');
    super.initState();
    doctorAccountStatusModelList= getDoctorList(context);
    futureBusinessAccountDtlsModelList=getBusinessUserList(context);
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    // screenHeight = _mediaQueryData.size.height;
    // getDoctorsList(context, {});
    return Scaffold(
      body:DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CompanyStyle.primaryColor,
            bottom: TabBar(

              indicatorColor: CompanyStyle.primaryColor,
              tabs: [
                Tab(
                  icon:Row(
                    children: [
                      Text('Doctor',style: TextStyle(fontSize: screenWidth/25)),
                      SizedBox(width: 10,),
                      InputChip(
                        tooltip: 'Total User Count',
                        disabledColor: Colors.white,
                        label: Text(totalDoctorList.toString(),style: TextStyle(fontSize: screenWidth/25,color: Colors.black)),
                      ),

                      //Icon(Icons.file_download, color: Colors.green)
                    ],
                  ),

                  // child: Icon(Icons.exit_to_app),
                ),
                Tab(icon:
                Row(
                  children: [
                    Text('Business',style: TextStyle(fontSize: screenWidth/25)),
                    SizedBox(width: 10,),
                    InputChip(
                      tooltip: 'Total User Count',
                      disabledColor: Colors.white,
                      label: Text(totalBusinessList.toString(),style: TextStyle(fontSize: screenWidth/25,color: Colors.black)),

                    ),

                  ],
                ),

                ),
              ],
            ),
            title: Row(
              children: [
                Image.asset(
                    'assets/images/dashboard/app/26.png',
                    width: 40,
                    height: 40),
                Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Manage Users',
                      style: TextStyle(fontSize: screenWidth / 15),
                    ))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildDoctorlist(context),
              buildBusinesslist(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDoctorlist(BuildContext context) {
    debugPrint('switch to doctor');
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    // screenHeight = _mediaQueryData.size.height;
    // final List<String> list = List.generate(10, (index) => "Text $index");

    return Scaffold(
      key: _scaffoldKey,
       body: Center(
            child: Container(
              padding:EdgeInsets.only(top: 5,bottom: 5),
              child:Column(
                children: [

                  Container(
                    padding:EdgeInsets.all(5),
                    child: TextFormField(
                      onChanged: (text) {
                        if (text.length > 0) {
                          setState(() {
                            searchingDoc = true;
                            filteredDoctorAccDtlList = [];
                          });

                          doctorAccountStatusModelList1.forEach((user) {
                            if (user.firstName
                                .toString()
                                .toLowerCase()
                                .contains(text.toLowerCase()) ||
                                user.contactNo.toString().contains(text)) {
                              setState(() {
                                filteredDoctorAccDtlList.add(user);
                              });

                            }
                          });
                          debugPrint('filteredDoctorAccDtlList lenght=${filteredDoctorAccDtlList.length}');
                        } else {

                          setState(() {
                            searchingDoc = false;
                            filteredDoctorAccDtlList = [];
                          });

                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        suffixIcon: TextButton(onPressed: (){
                          debugPrint('fetching excel data');
                          Map<String, dynamic> reqBody = new Map<String, String>();
                          reqBody={
                            "accountType":CommonConstant.ACCOUNT_DOCTOR
                          };
                            userExcelDownload(context,reqBody);
                          },
                          child: Icon(Icons.file_download,color: Colors.green,), ),
                        labelText: "Search Doctor's Account",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenWidth / 25),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  Expanded(child: filteredDoctorAccDtlList.length>0?
                  Container(
                    child: ListView.builder(
                        itemCount:filteredDoctorAccDtlList.length ,
                        itemBuilder: (context,int index){
                          return buildDoctorsDetailsTiles(filteredDoctorAccDtlList[index]);
                        }),
                  ):
                  searchingDoc?CommonUtil.getEmptyMsg("User Not Found", context):FutureBuilder(
                      future: doctorAccountStatusModelList,
                      builder: (context,AsyncSnapshot snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return CommonUtil.showLoading("Loading Users...",context);
                        }
                        else if(snapshot.hasError){
                          debugPrint('error at haserror');
                          return Text('Error');
                        }
                        else{
                          if(snapshot.data!=null && snapshot.data.length>0){
                            return ListView.builder(
                                itemCount:snapshot.data.length ,
                                itemBuilder: (context,int index){
                                  return buildDoctorsDetailsTiles(snapshot.data[index]);
                                });
                          }else{
                            return Text('Users not found');
                          }

                        }
                      }
                  ),)

                ],
              ),

      ),
    )
    );
  }
  Widget buildBusinesslist() {
    debugPrint('switch to doctor');
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    // screenHeight = _mediaQueryData.size.height;
    // final List<String> list = List.generate(10, (index) => "Text $index");

    return Scaffold(
        key: _scaffoldKeyBusiness,
        body: Center(
          child: Container(
            padding:EdgeInsets.only(top: 5,bottom: 5),
            child:Column(
              children: [
                Container(
                  padding:EdgeInsets.all(5),
                  child:  TextFormField(
                    onChanged: (text) {
                      if (text.length > 0) {

                        setState(() {
                          searchingBusi = true;
                          filteredBusinessAccDtlList = [];
                        });

                        businessAccountDetailsList.forEach((user) {
                          if (user.companyName
                              .toString()
                              .toLowerCase()
                              .contains(text.toLowerCase()) ||
                              user.contactNo.toString().contains(text)) {
                            setState(() {
                              filteredBusinessAccDtlList.add(user);
                            });

                          }
                        });
                        debugPrint('filteredBusinessAccDtlList lenght=${filteredBusinessAccDtlList.length}');
                      } else {
                        setState(() {
                          searchingBusi = false;
                          filteredBusinessAccDtlList = [];
                        });

                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      suffixIcon: TextButton(onPressed: (){
                        debugPrint('fetching excel data');
                        Map<String, dynamic> reqBody = new Map<String, String>();
                        reqBody={
                          "accountType":CommonConstant.ACCOUNT_BUSINESS
                        };
                        userExcelDownload(context,reqBody);
                      },
                        child: Icon(Icons.file_download,color: Colors.green,), ),
                      labelText: "Search Business Account",
                      labelStyle: TextStyle(
                          color: Colors.white, fontSize: screenWidth / 25),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Expanded(
                    child:filteredBusinessAccDtlList.length>0?Container(
                    child: ListView.builder(
                        itemCount:filteredBusinessAccDtlList.length ,
                        itemBuilder: (context,int index){
                          return buildBusinessDetailsTiles(filteredBusinessAccDtlList[index]);
                        }),
                ): searchingBusi?CommonUtil.getEmptyMsg("User Not Found", context):FutureBuilder(
                    future: futureBusinessAccountDtlsModelList,
                    builder: (context,AsyncSnapshot snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return CommonUtil.showLoading("Loading Users...",context);
                      }
                      else if(snapshot.hasError){
                        debugPrint('error at haserror');
                        return Text('Error');
                      }
                      else{
                        if(snapshot.data!=null && snapshot.data.length>0){
                          return ListView.builder(
                              itemCount:snapshot.data.length ,
                              itemBuilder: (context,int index){
                                return buildBusinessDetailsTiles(snapshot.data[index]);
                              });
                        }else{
                          return Text('Users not found');
                        }

                      }
                    }
                ) )
              ],
            ),

          ),
        )
    );
  }
  Widget buildDoctorsDetailsTiles(DoctorAccountStatusModel doctorAccountStatusModel) {

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
        child:Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child:Container(
            padding:EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                ListTile(
                    leading: Icon(Icons.person),
                    title: Text(doctorAccountStatusModel.nameTitle + ' ' +
                        doctorAccountStatusModel.firstName + ' ' +
                        doctorAccountStatusModel.lastName),
                    subtitle: Row(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              doctorAccountStatusModel.id,
                              style: TextStyle(color: Colors.white.withOpacity(0.8)),
                            ),
                          ],
                        ),
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  CommonUtil.getDDMMMYYYYStringDate(doctorAccountStatusModel.createDate).toString(),
                                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            )
                        ),
                      ],
                    )
                ),
                Container(
                  padding:EdgeInsets.only(left: 15,top: 0,bottom: 0,right: 15),
                  child:StepProgressIndicator(
                      roundedEdges:Radius.circular(100) ,
                      totalSteps: 4,
                      currentStep: getCurrentStep(doctorAccountStatusModel.stepCompleted),
                      size: 36,
                      selectedColor: Colors.blue,
                      unselectedColor: Colors.grey,
                      customStep: (index, color, _) => index ==0
                          ? Container(
                        color: color,
                        child: Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                      )
                          :index==1? Container(
                        color: color,
                        child: Icon(
                          Icons.payment,
                        ),
                      ):index==2?Container(
                        color: color,
                        child: Icon(
                          Icons.attach_file,
                        ),
                      ):Container(
                        color: color,
                        child: Icon(
                          Icons.login,
                        ),
                      )
                  ),
                ),
                Container(
                  padding:EdgeInsets.all(10),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                        child:Row(
                          children: <Widget>[
                            SizedBox(width: 10,),
                            Icon(Icons.call,size: 20,color: Colors.blue,),

                            RichText(
                              text:TextSpan(
                                text: doctorAccountStatusModel.contactNo,
                                recognizer: TapGestureRecognizer()..onTap = () => {
                                  debugPrint('call to '+doctorAccountStatusModel.contactNo),
                                  _makePhoneCall(doctorAccountStatusModel.contactNo)
                                  },
                              ),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Icon(Icons.phone_android,size: 20,color:Colors.red),

                              RichText(
                                text:TextSpan(
                                  text: doctorAccountStatusModel.emergencyNo,
                                  recognizer: TapGestureRecognizer()..onTap = () => {
                                    debugPrint('call to emergencyNo '+doctorAccountStatusModel.emergencyNo),
                                    _makePhoneCall(doctorAccountStatusModel.emergencyNo)
                              },
                            ),
                          ),
                              ],
                            )
                        ),
                        Expanded(
                            child: Row(

                              children: <Widget>[
                                SizedBox(width: 10,),
                                Icon(Icons.chat,size: 20,color:Colors.green),

                                RichText(
                                  text:TextSpan(
                                    text: doctorAccountStatusModel.whatsappNo,
                                    recognizer: TapGestureRecognizer()..onTap = () => {
                                      debugPrint('call to whatsappNo '+doctorAccountStatusModel.whatsappNo),
                                    _makePhoneCall(doctorAccountStatusModel.whatsappNo)
                                    // FlutterPhoneDirectCaller.callNumber(doctorAccountStatusModel.whatsappNo)
                                    },
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Account',
              color: Colors.blue,
              icon: Icons.book_outlined,
              onTap: () => _showDoctorAccountDetails(doctorAccountStatusModel.id),
            ),
            IconSlideAction(
              caption: 'Documents',
              color: Colors.indigo,
              icon: Icons.attach_file,
              onTap: () => _showDoctorDocumentsDetails(doctorAccountStatusModel.id),
            ),
          ],

      ),
    )
    );
  }

  _showDoctorAccountDetails(String id){
    debugPrint('display account details for $id');
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorAccountDetails(accountId: id,)));
  }
  _showDoctorDocumentsDetails(String id){
    debugPrint('display documents details for $id');
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDocumentDetails(accountId: id,)));
  }

  _makePhoneCall(String url) async {
    FlutterPhoneDirectCaller.callNumber(url);
  }
  int getCurrentStep(String step){
    switch (step) {
      case 'step1':
        return 1;
      case 'step2':
        return 2;
      case 'step3':
        return 3;
      case 'step4':
        return 4;
      default:
        return 1;
    }
  }

  Future<List<DoctorAccountStatusModel>> getDoctorList( BuildContext context) async{
    ApiProvider _provider = new ApiProvider();
    try {
      final response = await _provider.post("/account/get-doctor-acc-list-status",{});
      doctorAccountStatusModelList1 = (response as List).map((data) => DoctorAccountStatusModel.fromJson(data)).toList();
      setState(() {
        isLoadingDoctorList=false;
        totalDoctorList = doctorAccountStatusModelList1.length;
      });
    } catch (e) {
      debugPrint('error at display page='+e.toString().toString());
      // final snackBar =normalSnackBar(e.toString().toString(), Colors.red,  Colors.white);
      // _scaffoldKey.currentState.showSnackBar(snackBar);
      futureShowSnackBar(context, e.toString(), Colors.red,  Colors.white);
    }
    return doctorAccountStatusModelList1;
  }

  Future<List<BusinessAccountDetailsModel>> getBusinessUserList(BuildContext context) async{
    ApiProvider _provider = new ApiProvider();
    try {
      final response = await _provider.post("/account/get-business-list",{});
      businessAccountDetailsList = (response as List).map((data) => BusinessAccountDetailsModel.fromJson(data)).toList();
      setState(() {
        // isLoadingDoctorList=false;
        totalBusinessList = businessAccountDetailsList.length;
      });
    } catch (e) {
      debugPrint('error at display page='+e.toString().toString());
      futureShowSnackBar(context, e.toString(), Colors.red,  Colors.white);
    }
    return businessAccountDetailsList;
  }
  void userExcelDownload(BuildContext context, Map<String, dynamic> reqBody) async{
    ApiProvider _provider = new ApiProvider();
    SuccessModel successModel;
    showProgressIndicator("Fetching Data...");
    try {
      final response = await _provider.post("/account/excel-user-download",reqBody);
      successModel = SuccessModel.fromJson(response);
      dismissProgressIndicator();
      if (successModel != null) {
        if (successModel.status!=null && successModel.status == CommonConstant.STATUS_SUCCESS) {
          debugPrint('successModel.data');
          debugPrint(successModel.data);
          String savedPath=await CommonUtil.createFolderInAppDocDirStr("${reqBody['accountType']}_list", successModel.data, "temp", null, ".xlsx");
          debugPrint('savedPath=$savedPath');
          if(!CommonUtil.isBlank(savedPath)){
            showSnackBar(context, 'File saved at >> $savedPath', Colors.green, Colors.white,3000);
          }else{
            showSnackBar(context, 'Failed to save', Colors.red, Colors.white,1000);
          }
        }
        }
    } catch (e) {
      dismissProgressIndicator();
      print('error at display page='+e);
      print('error at display page='+e.toString().toString());
      futureShowSnackBar(context, e.toString(), Colors.red,  Colors.white);
    }
    // return successModel;
  }
  showProgressIndicator(String msg){
    EasyLoading.show(status: msg);
  }
  showSuccessIndicator(String msg){
    EasyLoading.showSuccess(msg,duration: Duration(milliseconds: 700));
  }
  dismissProgressIndicator(){
    EasyLoading.dismiss(animation: true);
  }
  showSnackBar(BuildContext context, String msg, Color bgcolor, Color txtColor,int duration) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: duration),
        content: Text(
          msg,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgcolor,
      ));
    });
  }
  Widget buildBusinessDetailsTiles(BusinessAccountDetailsModel businessAccountDetailsModel) {
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
          child:Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child:Container(
              padding:EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  ListTile(
                      leading: Icon(Icons.business),
                      title: Text(CommonUtil.convertToTitleCase(businessAccountDetailsModel.companyName) + ' ' +
                          CommonUtil.convertToTitleCase(businessAccountDetailsModel.companyTitle)),
                      subtitle: Row(
                        children: [
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                businessAccountDetailsModel.id,

                              ),
                            ],
                          ),
                          Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  Text(
                                    CommonUtil.getDDMMMYYYYStringDate(businessAccountDetailsModel.createDate).toString(),
                                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                  ),

                  Container(
                    padding:EdgeInsets.all(10),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                              child:Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Icon(Icons.call,size: 20,color: Colors.blue,),

                                  RichText(
                                    text:TextSpan(
                                      text: businessAccountDetailsModel.contactNo,
                                      recognizer: TapGestureRecognizer()..onTap = () => {
                                        debugPrint('call to '+businessAccountDetailsModel.contactNo),
                                        _makePhoneCall(businessAccountDetailsModel.contactNo)
                                      },

                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Icon(Icons.phone_android,size: 20,color:Colors.red),

                                  RichText(
                                    text:TextSpan(
                                      text: businessAccountDetailsModel.otherContactNo,
                                      recognizer: TapGestureRecognizer()..onTap = () => {
                                        debugPrint('call to emergencyNo '+businessAccountDetailsModel.otherContactNo),
                                        _makePhoneCall(businessAccountDetailsModel.otherContactNo)
                                      },

                                    ),
                                  ),
                                ],
                              )
                          ),
                          Expanded(
                              child: Row(

                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Icon(Icons.chat,size: 20,color:Colors.green),

                                  RichText(
                                    text:TextSpan(
                                      text: businessAccountDetailsModel.whatsappNo,
                                      recognizer: TapGestureRecognizer()..onTap = () => {
                                        debugPrint('call to whatsappNo '+businessAccountDetailsModel.whatsappNo),
                                        _makePhoneCall(businessAccountDetailsModel.whatsappNo)
                                        // FlutterPhoneDirectCaller.callNumber(doctorAccountStatusModel.whatsappNo)
                                      },

                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Account',
                color: Colors.blue,
                icon: Icons.book_outlined,
                onTap: () => showBusinessAccountDetails(businessAccountDetailsModel.id),
              ),
              IconSlideAction(
                caption: 'Documents',
                color: Colors.indigo,
                icon: Icons.attach_file,
                onTap: () => showBusinessDocumentsDetails(businessAccountDetailsModel.id),
              ),
            ],

          ),
        )
    );
  }

  showBusinessDocumentsDetails(String id) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessDocumentDetails(accountId: id,)));
  }

  showBusinessAccountDetails(String id) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessAccountDetails(accountId: id,)));
  }

}

SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor){
  return SnackBar(
      content: Text(msg,
        style: TextStyle(color:txtColor),
      ),
      backgroundColor: bgcolor
  );
}
futureShowSnackBar(BuildContext context, String msg, Color bgcolor, Color txtColor) {
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