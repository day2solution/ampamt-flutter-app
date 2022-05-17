import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/model/search-user-model.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewUserDetails extends StatefulWidget {
  final String accountId;
  ViewUserDetails({this.accountId}) : super();
  @override
  _ViewUserDetailsState createState() => _ViewUserDetailsState(accountId: accountId);
}

class _ViewUserDetailsState extends State<ViewUserDetails> {
  final String accountId;
  _ViewUserDetailsState({this.accountId}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  Future<List<UserSearchModel>> futureUserSearchModelList;
  List<UserSearchModel> userSearchModelList = [];
  @override
  void initState() {
    debugPrint('getting user details');
    super.initState();
    debugPrint('accountId=$accountId');
    futureUserSearchModelList=searchUserDetails();
  }
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    // screenHeight = _mediaQueryData.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title: Row(
          children: [
            Image.asset(
                'assets/images/dashboard/app/25.png',
                width: 40,
                height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'User Details',
                  style: TextStyle(fontSize: screenWidth / 20),
                ))
          ],
        ),
      ),
      body:  ListView(
          children: [
            Container(
                child:FutureBuilder(
                    future: futureUserSearchModelList,
                    builder: (context,AsyncSnapshot snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return CommonUtil.showLoading("Loading Details...",context);
                      }else if(snapshot.hasError){
                        print('error at haserror');
                        return Text('Error occurred');
                      }
                      else{
                        if(snapshot.data!=null && snapshot.data.length>0){
                         return buildUserDetails(snapshot.data);
                        }else{
                          return CommonUtil.getEmptyMsg("Details not found", context);
                        }
                      }
                    }
                ),
              ),

          ],
        ),

    );
  }

  Future<List<UserSearchModel>> searchUserDetails() async {
    ApiProvider _provider = new ApiProvider();
    Map<String, dynamic> userForm = new Map<String, String>();
    userForm['id']=accountId;
    try {
      final response = await _provider.post("/account/search-users", userForm);
      userSearchModelList = (response as List).map((data) => UserSearchModel.fromJson(data)).toList();

    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
    }
    return userSearchModelList;
  }
  SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor) {
    return SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgcolor);
  }

  Widget buildUserDetails(List<UserSearchModel> userSearchModelList) {
    UserSearchModel userModel=userSearchModelList[0];
    return Container(
        child:Column(
          children:<Widget> [
            Container(
              child:ListTile(
                leading: Text('Name :',style: getHeadingTextStyle(),),
                title: Text(
                  (userModel.nameTitle!=null?userModel.nameTitle:'-') + ' ' + (userModel.name!=null?userModel.name:'-')
                  , style: getTextStyle(),),

              ),
            ),
            Divider(color: CompanyStyle.primaryColor[1003],),
            Container(
              child:ListTile(
                leading: Text('Account Type :',style: getHeadingTextStyle(),),
                title: Text(userModel.accountType!=null?userModel.accountType:'-',style: getTextStyle(),),

              ),
            ),
            Divider(color: CompanyStyle.primaryColor[1003],),
            Container(
              child:ListTile(
                leading: Text('Gender :',style: getHeadingTextStyle(),),
                title: Text(userModel.gender!=null?(userModel.gender=='M'?'Male':
                (userModel.gender=='F'?'Female':
                (userModel.gender=='T'?'Transgender':
                userModel.gender))): "-",
                  style: getTextStyle(),),

              ),
            ),
            Divider(color: CompanyStyle.primaryColor[1003],),
            Container(
              child:ListTile(
                leading: Text('Email-ID :',style: getHeadingTextStyle(),),
                title: Text(userModel.emailId!=null?userModel.emailId:'-',style: getTextStyle(),),

              ),
            ),
            Divider(color: CompanyStyle.primaryColor[1003],),
            Container(
              child:ListTile(
                leading: Text('Mobile No. :',style: getHeadingTextStyle(),),
                title: Text(userModel.contactNo!=null?userModel.contactNo:'-',style: getTextStyle(),),

              ),
            ),
            Divider(color: CompanyStyle.primaryColor[1003],),
            Container(
              child:ListTile(
                leading: Text('WhatsApp No. :',style: getHeadingTextStyle(),),
                title: Text(userModel.whatsappNo!=null?userModel.whatsappNo:'-',style: getTextStyle(),),

              ),
            ),
            Divider(color: CompanyStyle.primaryColor[1003],),
            Container(
              child:ListTile(
                leading: Text('Emergency No. :',style: getHeadingTextStyle(),),
                title: Text(userModel.emergencyNo!=null?userModel.emergencyNo:'-',style: getTextStyle(),),

              ),
            ),
            Divider(color: CompanyStyle.primaryColor[1003],),
            Container(
              child:ListTile(
                leading: Text('City :',style: getHeadingTextStyle(),),
                title: Text(userModel.city!=null?userModel.city:'-',style: getTextStyle(),),

              ),
            ),
            Divider(color: CompanyStyle.primaryColor[1003],),
            Container(
              child:ListTile(
                leading: Text('State :',style: getHeadingTextStyle(),),
                title: Text(userModel.state!=null?userModel.state:'-',style: getTextStyle(),),

              ),
            ),
            Divider(color: CompanyStyle.primaryColor[1003],),
            Container(
              child:ListTile(
                leading: Text('Pin Code :',style: getHeadingTextStyle(),),
                title: Text(userModel.zipCode!=null?userModel.zipCode:'-',style: getTextStyle(),),

              ),
            ),
          ],
        )

    );
  }
  getHeadingTextStyle(){
    return TextStyle(
      fontSize: screenWidth/25,

    );
  }
  getTextStyle(){
    return TextStyle(
      fontSize: screenWidth/25,

    );
  }
}