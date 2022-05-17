import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/forgotpassword/reset-new-password.dart';

import 'package:ampamt/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class ForgotPassword extends StatefulWidget{
  ForgotPassword({this.accountType,}) : super();
  final String accountType;

  @override
  _ForgotPasswordState createState()=>_ForgotPasswordState(accountType: accountType);

}

class _ForgotPasswordState extends State<ForgotPassword> {
  _ForgotPasswordState({this.accountType}) ;

  final String accountType;

  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  final _sendOtpFormKey = GlobalKey<FormState>();
  final _verifyOtpFormKey = GlobalKey<FormState>();
  final txtEmailId = TextEditingController();
  bool isOTPSent=false;
  // bool isDataFetched=false;
  final otp = TextEditingController();
  String sendBtnTxt="Send OTP";
  bool isDataProcessed=false;
  String accountId;
  Map<String, dynamic> documentReqBody = new Map<String, String>();
  @override
  void initState() {
    print('accountType=$accountType');
    super.initState();

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    // return new MaterialApp(
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title:  Row(
          children: [
            Image.asset('assets/images/dashboard/app/21.png',width: 40,height: 40),
            Container(
                padding: const EdgeInsets.all(10.0), child: Text('Verify OTP')
            )
          ],
        ),
      ),
      body:Container(


        child:ListView(
          children: <Widget>[


            Container(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: CompanyStyle.primaryColor,
                  child: Form(
                    key: _sendOtpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: txtEmailId,
                          validator: (value) {
                            if(value.isEmpty){
                              return 'Please Enter Email-Id Or Mobile No.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            labelText: "Email-Id or Mobile No. *",
                            labelStyle: TextStyle(
                                color: Colors.white, fontSize: screenHeight / 45),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                              BorderSide(color: Colors.white, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                              BorderSide(color: Colors.white, width: 0.5),
                            ),
                          ),
                        ),
                        CompanyStyle.getInputElementGap(),
                        Center(
                          child:ElevatedButton(
                            style:  CompanyStyle.getButtonStyle(),
                            onPressed: isDataProcessed?null:() {

                              documentReqBody['emailId']= txtEmailId.text;
                              documentReqBody['accountType']= accountType;

                              if (_sendOtpFormKey.currentState.validate()){
                                _sendOtpFormKey.currentState.save();
                                setState(() {
                                  isOTPSent=false;
                                });
                                debugPrint('documentReqBody=' + documentReqBody.toString());
                                getDetails(context, documentReqBody);
                              }else{

                                debugPrint('documentReqBody=' + documentReqBody.toString());
                              }

                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Text(sendBtnTxt, style: TextStyle(fontSize: screenWidth/25),),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            isOTPSent?Container(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  color: CompanyStyle.primaryColor,
                  child: Form(
                    key: _verifyOtpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        TextFormField(
                          controller: otp,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter an OTP sent to your registered Email-Id';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                            labelText: "Please Enter OTP *",
                            labelStyle: TextStyle(
                                color: Colors.white, fontSize: screenHeight / 45),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                              BorderSide(color: Colors.white, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                              BorderSide(color: Colors.white, width: 0.5),
                            ),
                          ),
                        ),
                        CompanyStyle.getInputElementGap(),
                        Center(
                          child:ElevatedButton(
                            style:  CompanyStyle.getButtonStyle(),
                            onPressed: isDataProcessed?null:() {
                              documentReqBody['emailId']= txtEmailId.text;
                              documentReqBody['accountType']= accountType;
                              documentReqBody['otp']= otp.text;
                              documentReqBody['id']= accountId;
                              debugPrint('documentReqBody=' + documentReqBody.toString());
                              if (_verifyOtpFormKey.currentState.validate()){
                                _verifyOtpFormKey.currentState.save();
                                debugPrint('documentReqBody=' + documentReqBody.toString());
                                verifyOtp(context, documentReqBody);
                              }else{


                              }

                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Text('Verify OTP', style: TextStyle(fontSize: screenWidth/25),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ):Text(""),
          ],
        ),

      ),

    );
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

  void verifyOtp(BuildContext context, Map<String, dynamic> reqBody) async{
    debugPrint('before verifyOtp='+reqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    SuccessModel successModel;
    try {
      final response = await _provider.post("/account/verify-change-password-otp", reqBody);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Scaffold.of(context).hideCurrentSnackBar();
      successModel = SuccessModel.fromJson(response);
    } catch (e) {
      setState(() {
        isDataProcessed = false;
      });
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    setState(() {
      isDataProcessed = false;
    });
    if (successModel != null) {
      if (successModel.status == CommonConstant.STATUS_SUCCESS) {
        _verifyOtpFormKey.currentState.reset();
        showSnackBar(context, 'OTP verified Successfully', Colors.green, Colors.white);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>
                ResetNewPasssword(accountId: successModel.id,accountType: successModel.accountType,emailId: successModel.emailId,)));
      } else if (successModel.status == CommonConstant.STATUS_FAILED) {
        showSnackBar(
            context, 'Failed To Verify OTP, please enter correct OTP.', Colors.red, Colors.white);
      } else {
        showSnackBar(
            context, 'Something went wrong please try again.', Colors.red, Colors.white);
      }
    }else{
      showSnackBar(
          context, 'Something went wrong please try again.', Colors.red, Colors.white);
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
  void getDetails(BuildContext context, Map<String, dynamic> reqBody) async{
    debugPrint('before submitting='+documentReqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    SuccessModel successModel;
    try {
      final response = await _provider.post("/account/check-ampamt-account", reqBody);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Scaffold.of(context).hideCurrentSnackBar();
      successModel = SuccessModel.fromJson(response);
    } catch (e) {
      setState(() {
        isDataProcessed = false;
      });
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    setState(() {
      isDataProcessed = false;
    });
    if (successModel != null) {
      if (successModel.status == CommonConstant.STATUS_SUCCESS) {

        setState(() {
          accountId=successModel.id;
          documentReqBody['emailId']=successModel.emailId;
          documentReqBody['id']=successModel.id;
          sendOtp(context, documentReqBody);
        });


      } else if (successModel.status == CommonConstant.STATUS_FAILED && successModel.msg==CommonConstant.NOTFOUNT) {
        showSnackBar(
            context, 'We have not found any record, please enter correct detail.', Colors.red, Colors.white);
      } else {
        showSnackBar(
            context, 'Failed to fetch your details', Colors.red, Colors.white);
      }
    }else{
      showSnackBar(
          context, 'Failed to fetch your details', Colors.red, Colors.white);
    }
  }
  void sendOtp(BuildContext context, Map<String, dynamic> documentReqBody) async{
    debugPrint('before submitting='+documentReqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    SuccessModel successModel;
    try {
      final response = await _provider.post("/email-service/send-otp-email", documentReqBody);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Scaffold.of(context).hideCurrentSnackBar();
      successModel = SuccessModel.fromJson(response);
    } catch (e) {
      setState(() {
        isDataProcessed = false;
      });
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    setState(() {
      isDataProcessed = false;
    });
    if (successModel != null) {
      if (successModel.status == CommonConstant.STATUS_SUCCESS) {
        setState(() {
          isOTPSent=true;
          sendBtnTxt="Resend OTP";
        });

        showSnackBar(context, 'OTP Sent Successfully', Colors.green, Colors.white);
      } else if (successModel.status == CommonConstant.STATUS_FAILED) {
        showSnackBar(
            context, 'Failed To Send OTP, please try again.', Colors.red, Colors.white);
      } else {
        showSnackBar(
            context, 'Something went wrong please try again.', Colors.red, Colors.white);
      }
    }else{
      showSnackBar(
          context, 'Something went wrong please try again.', Colors.red, Colors.white);
    }
  }
}
