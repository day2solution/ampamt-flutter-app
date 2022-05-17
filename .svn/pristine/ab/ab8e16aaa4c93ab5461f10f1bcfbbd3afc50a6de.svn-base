import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/model/business/BusinessAccountDetailsModel.dart';
import 'package:ampamt/model/doctor/DoctorsAccountDetailsModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserServices extends StatefulWidget {
  final String title;
  final String imageName;
  final DoctorsAccountDetailsModel doctorModel;
  final BusinessAccountDetailsModel businessModel;
  UserServices({Key key, this.title, this.imageName,this.doctorModel,this.businessModel}) : super(key: key);

  @override
  _UserServicesSate createState() => _UserServicesSate(doctorsAccountDetailsModel: doctorModel,businessAccountDetailsModel: businessModel,title: title,imageName: imageName);
}

class _UserServicesSate extends State<UserServices> {
  final DoctorsAccountDetailsModel doctorsAccountDetailsModel;
  final BusinessAccountDetailsModel businessAccountDetailsModel;
  final String title;
  final String imageName;
  _UserServicesSate({this.doctorsAccountDetailsModel,this.businessAccountDetailsModel,this.title,this.imageName}) ;
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  final _formKey = GlobalKey<FormState>();
  final txtName = TextEditingController();
  final contactNo = TextEditingController();
  final emailId = TextEditingController();
  final message = TextEditingController();

  String city;
  String state;
  String userId;
  String accountType;
  Map<String, dynamic> reqBody = new Map<String, String>();
  bool isMsgProcessed = false;

  @override
  void initState() {
    print('doctorsAccountDetailsModel=$doctorsAccountDetailsModel');
    print('businessAccountDetailsModel=$businessAccountDetailsModel');
    String name="";
    String lastName="";
    String title="";

    if(doctorsAccountDetailsModel!=null){
      if(doctorsAccountDetailsModel.nameTitle!=null){
        title=CommonUtil.convertToTitleCase(doctorsAccountDetailsModel.nameTitle);
      }

      if(doctorsAccountDetailsModel.firstName!=null){
        name=CommonUtil.convertToTitleCase(doctorsAccountDetailsModel.firstName);
      }
      if(doctorsAccountDetailsModel.lastName!=null){
        lastName=CommonUtil.convertToTitleCase(doctorsAccountDetailsModel.lastName);
      }

      if(doctorsAccountDetailsModel.city!=null){
        city=CommonUtil.convertToTitleCase(doctorsAccountDetailsModel.city);
      }

      if(doctorsAccountDetailsModel.state!=null){
        state=CommonUtil.convertToTitleCase(doctorsAccountDetailsModel.state);
      }
      if(doctorsAccountDetailsModel.id!=null){
        userId=CommonUtil.convertToTitleCase(doctorsAccountDetailsModel.id);
      }
      if(doctorsAccountDetailsModel.accountType!=null){
        accountType=CommonUtil.convertToTitleCase(doctorsAccountDetailsModel.accountType);
      }

      txtName.text=title+" "+name+" "+lastName;
      emailId.text=doctorsAccountDetailsModel.emailId;
      contactNo.text=doctorsAccountDetailsModel.contactNo;
    }
    if(businessAccountDetailsModel!=null){
      if(businessAccountDetailsModel.companyTitle!=null){
        title=CommonUtil.convertToTitleCase(businessAccountDetailsModel.companyTitle);
      }

      if(businessAccountDetailsModel.companyName!=null){
        name=CommonUtil.convertToTitleCase(businessAccountDetailsModel.companyName);
      }
      if(businessAccountDetailsModel.city!=null){
        city=CommonUtil.convertToTitleCase(businessAccountDetailsModel.city);
      }

      if(businessAccountDetailsModel.state!=null){
        state=CommonUtil.convertToTitleCase(businessAccountDetailsModel.state);
      }
      if(businessAccountDetailsModel.id!=null){
        userId=CommonUtil.convertToTitleCase(businessAccountDetailsModel.id);
      }
      if(businessAccountDetailsModel.accountType!=null){
        accountType=CommonUtil.convertToTitleCase(businessAccountDetailsModel.accountType);
      }

      txtName.text=name+" "+title;
      emailId.text=businessAccountDetailsModel.emailId;
      contactNo.text=businessAccountDetailsModel.contactNo;
    }

    if(businessAccountDetailsModel==null && doctorsAccountDetailsModel==null){
      showSnackBar(context, "Unable to fetch your details, please try again", Colors.red, Colors.white);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title: Row(
          children: [
            Image.asset(
                'assets/images/dashboard/app/' + imageName + '.png',
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
      body: Container(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      readOnly: true,
                      controller: txtName,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.white),
                        labelText: "Name *",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 45),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      readOnly: true,
                      controller: emailId,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your email-Id';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail, color: Colors.white),
                        labelText: "Email-ID *",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 45),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      readOnly: true,
                      controller: contactNo,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your contact no.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.call, color: Colors.white),
                        labelText: "Contact No.*",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 45),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      maxLines: 8,
                      controller: message,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your comments/message';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.message, color: Colors.white),
                        labelText: "Comments/Message*",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 45),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
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
                              'Submit',
                              style: TextStyle(
                                fontSize: screenHeight / 45,
                                letterSpacing: 2,
                              ),
                            ),
                            Icon(Icons.send),
                          ],
                        ),
                        width: double.infinity,
                      ),
                      onPressed: () {
                        reqBody = {
                          'name': txtName.text,
                          'emailId': emailId.text,
                          'contactNo': contactNo.text,
                          'message': message.text,

                          'userId': userId,
                          'regards': title,
                          'city': city,
                          'state': state,
                          'accountType': accountType,

                        };
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          print('reqBody=' + reqBody.toString());
                          sendServiceEmail(reqBody);


                        }else{
                          print('reqBody=' + reqBody.toString());
                        }
                      },
                    ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  void sendServiceEmail(Map<String, dynamic> reqBody) async{
    debugPrint('sending message with=' + reqBody.toString());
    ApiProvider _provider = new ApiProvider();
    SuccessModel successModel;
    showProgressIndicator("Sending Message...");
    try {
      final response = await _provider.post("/email-service/send-service-email", reqBody);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Scaffold.of(context).hideCurrentSnackBar();
      successModel = SuccessModel.fromJson(response);
      if (successModel != null) {

        dismissProgressIndicator();
        if (successModel.status == CommonConstant.STATUS_SUCCESS) {
          message.clear();
          showSuccessIndicator("Message Sent");
        } else if (successModel.status == CommonConstant.STATUS_FAILED) {
          showSnackBar(context, 'Failed to send message, Please try again after some time.', Colors.red, Colors.white);
        } else {
          showSnackBar(context, 'Something went wrong, Please try again after some time.', Colors.red, Colors.white);
        }
      }
    } catch (e) {
      dismissProgressIndicator();
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }


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