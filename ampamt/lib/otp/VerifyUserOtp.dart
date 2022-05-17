import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/dashboard/user-dashboard.dart';
import 'package:ampamt/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class VerifyUserOtp extends StatefulWidget{
  VerifyUserOtp({this.accountId,this.accountType,this.emailId}) : super();
  final String accountId;
  final String accountType;
  final String emailId;
  @override
  _VerifyUserOtpState createState()=>_VerifyUserOtpState(accountId:accountId ,accountType: accountType,emailId: emailId);

}

class _VerifyUserOtpState extends State<VerifyUserOtp> {
  _VerifyUserOtpState({this.accountId,this.accountType,this.emailId}) ;
  final String accountId;
  final String accountType;
  final String emailId;
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  final _formKey = GlobalKey<FormState>();
  final txtEmailId = TextEditingController();

  final otp = TextEditingController();

  bool isDataProcessed=false;

  Map<String, dynamic> documentReqBody = new Map<String, String>();
  @override
  void initState() {
    print('documentupload page accountId=$accountId $accountType');
    super.initState();

    setState(() {
      txtEmailId.text=emailId;
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
            Image.asset('assets/images/home/upload-doc.png',width: 40,height: 40),
            Container(
                padding: const EdgeInsets.all(10.0), child: Text('Email-ID Verification')
            )
          ],
        ),
      ),
      body:Container(


            child:ListView(
              children: <Widget>[
                Card(
                  color: CompanyStyle.primaryColor,
                  child:Container(
                    padding: EdgeInsets.all(10.0),
                    child:  Text('OTP has been successfully sent to your registered Email-Id', style: TextStyle(fontSize: screenWidth/35)),
                  ),
                ),

                Container(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: CompanyStyle.primaryColor,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              enabled: false,
                              controller: txtEmailId,
                              // validator: (value) {
                              //
                              //   return null;
                              // },
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

                                  documentReqBody['id']=accountId;
                                  documentReqBody['emailId']= txtEmailId.text;
                                  documentReqBody['otp']= otp.text;
                                  documentReqBody['accountType']= accountType;


                                  if (_formKey.currentState.validate()){
                                    _formKey.currentState.save();
                                    debugPrint('documentReqBody=' + documentReqBody.toString());
                                    verifyOtp(context, documentReqBody);
                                  }else{

                                    debugPrint('documentReqBody=' + documentReqBody.toString());
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
                ),
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

  void verifyOtp(BuildContext context, Map<String, dynamic> documentReqBody) async{
    debugPrint('before submitting='+documentReqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    SuccessModel successModel;
    try {
      final response = await _provider.post("/account/verify-otp", documentReqBody);
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
        _formKey.currentState.reset();
        showSnackBar(context, 'OTP verified Successfully', Colors.green, Colors.white);

        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => UserHomePage(accountId: accountId,accountType: accountType,)));
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
}

