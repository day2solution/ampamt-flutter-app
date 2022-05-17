import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/dashboard/user-dashboard.dart';
import 'package:ampamt/docupload/business-document-upload.dart';
import 'package:ampamt/forgotpassword/forgot-password.dart';
import 'package:ampamt/model/doctor/DocumentsVerificationModel.dart';
import 'package:ampamt/otp/VerifyUserOtp.dart';
import 'package:ampamt/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessLogin extends StatefulWidget{
  @override
  _BusinessLoginPageState createState()=>_BusinessLoginPageState();

}
class _BusinessLoginPageState extends State<BusinessLogin>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title:  Row(
          children: [
            Image.asset('assets/images/home/business_login.png',width: 40,height: 40),
            Container(
                padding: const EdgeInsets.all(10.0), child: Text('Business Login'))
          ],
        ),
      ),
      body:MyCustomForm(),
    );
  }
    getButtonStyle(){
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      primary:CompanyStyle.primaryColor,
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;


  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  final username = TextEditingController();
  final password = TextEditingController();

  Map<String, dynamic> reqBody = new Map<String, String>();
  bool isLoginProcessed = false;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    return Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(10.0),

          children: <Widget>[
            Image.asset('assets/images/icon.png',width: screenHeight/2.7,height: screenHeight/2.7),
            CompanyStyle.getGap20(),
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: CompanyStyle.primaryColor[1003].withOpacity(0.2),
                      width: 1,
                    )
                ),
                elevation: 10.0,
                child:Container(
                  decoration: BoxDecoration(
                    color: CompanyStyle.primaryColor[100],
                    border: Border.all(width: 1,color:CompanyStyle.primaryColor[1003].withOpacity(0.2) ),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  padding: EdgeInsets.all(15.0),
                  // color: CompanyStyle.primaryColor[100],

                 child:Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: username,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email-id / mobile no.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.business,color: Colors.white),
                            labelText: "Email-ID/Mobile No.",
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight/35
                            ),

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
                        CompanyStyle.getGap15(),
                        TextFormField(
                          obscureText: !_showPassword,
                          controller: password,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key_rounded,color: Colors.white),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight/35
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white, width: 0.5),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _showPassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() => this._showPassword = !this._showPassword);
                              },
                            ),
                          ),
                        ),
                        CompanyStyle.getGap15(),
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
                                  'LogIn',
                                  style: TextStyle(
                                    fontSize: screenHeight / 35,
                                    letterSpacing: 2,
                                  ),

                                ),
                                Icon(Icons.login),
                              ],
                            ),
                            width: double.infinity,
                          ),
                          onPressed: isLoginProcessed
                              ? null
                              : () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              reqBody = {
                                'emailId': username.text,
                                'password': password.text,
                                'accountType':CommonConstant.ACCOUNT_BUSINESS
                              };
                              print('reqBody=' + reqBody.toString());
                              processLogin(context, reqBody);
                            }
                          },
                        ),
                        CompanyStyle.getGap10(),
                        ElevatedButton(
                          style: CompanyStyle.getButtonStyle(),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    fontSize: screenHeight / 35,
                                  ),
                                ),
                                Icon(Icons.help),
                              ],
                            ),
                            width: double.infinity,
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword(accountType: CommonConstant.ACCOUNT_BUSINESS,)));

                          },
                        ),
                        // ),
                      ],
                    ),
    ),
              ),
            ),
    ),
      ],
        ),
    );
  }

  login(){

  }

  void processLogin(BuildContext context, Map<String, dynamic> reqBody) async{
    // final SharedPreferences prefs = await _prefs;
    print(reqBody);
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isLoginProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);

    SuccessModel successModel;
    try {
      final response = await _provider.post("/account/business-login", reqBody);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Scaffold.of(context).hideCurrentSnackBar();
      successModel = SuccessModel.fromJson(response);
    } catch (e) {
      setState(() {
        isLoginProcessed = false;
      });

      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }

    // Scaffold.of(context).hideCurrentSnackBar();
    setState(() {
      isLoginProcessed = false;
    });
    if (successModel != null) {
      if (successModel.status == CommonConstant.STATUS_SUCCESS) {
        // showSnackBar(context, 'Success', Colors.green, Colors.white);
        double availableAmount=0;
        if(successModel.documentsVerificationModelList.isNotEmpty && successModel.documentsVerificationModelList.length>0){
          DocumentsVerificationModel documentsVerificationModel=DocumentsVerificationModel.fromJson(successModel.documentsVerificationModelList[0]);
          if(documentsVerificationModel!=null){
            debugPrint('availableAmount=${documentsVerificationModel.allDocUploaded}');
            if(documentsVerificationModel.allDocUploaded!=null && documentsVerificationModel.allDocUploaded==CommonConstant.FLAG_N)
            {
              debugPrint('going to docupload');
              _formKey.currentState.reset();
              password.clear();
              username.clear();
              Navigator.of(context).pop(true);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessDocumentUpload(accountId: successModel.id,)));
            }else{
              if(successModel.activeFlag!=null && successModel.activeFlag==CommonConstant.FLAG_Y) {
                _formKey.currentState.reset();
                password.clear();
                username.clear();
                // prefs.setString("accountId", successModel.id);
                // prefs.setString("accountType", CommonConstant.ACCOUNT_BUSINESS);
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (BuildContext context) => UserHomePage(accountId: successModel.id,accountType: CommonConstant.ACCOUNT_BUSINESS,)));
              }else{
                //open otp
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyUserOtp(accountId: successModel.id,accountType: CommonConstant.ACCOUNT_BUSINESS,emailId: successModel.emailId,)));

              }
            }
          }else{
            showSnackBar(context, 'Something went wrong!', Colors.red, Colors.white);
          }
        }else{
          showSnackBar(context, 'Something went wrong!', Colors.red, Colors.white);
        }
      } else if (successModel.status == CommonConstant.STATUS_FAILED) {
        showSnackBar(context, 'Incorrect Email-ID Or Password', Colors.red, Colors.white);
      } else {
        showSnackBar(context, 'User Not Found Please SignUp', Colors.red, Colors.white);
      }
    }
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