import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/dashboard/user-dashboard.dart';
import 'package:ampamt/docupload/doctor-document-upload.dart';
import 'package:ampamt/forgotpassword/forgot-password.dart';
import 'package:ampamt/model/doctor/DocumentsVerificationModel.dart';
import 'package:ampamt/otp/VerifyUserOtp.dart';
import 'package:ampamt/payment/payment-page.dart';
import 'package:ampamt/style.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class DoctorLogin extends StatefulWidget {
  @override
  _DoctorLoginPageState createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLogin> {
  // static MediaQueryData _mediaQueryData;
  // static double screenWidth;
  // static double screenHeight;

  @override
  Widget build(BuildContext context) {
    // _mediaQueryData = MediaQuery.of(context);
    // screenWidth = _mediaQueryData.size.width;
    // screenHeight = _mediaQueryData.size.height;
    // final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title: Row(
          children: [
            Image.asset('assets/images/home/doctor_login.png',
                width: 40, height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text('Doctor\'s Login'))
          ],
        ),
      ),
      body: MyCustomForm(),
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
  final username = TextEditingController();
  final password = TextEditingController();
  bool _showPassword = false;
  Map<String, dynamic> reqBody = new Map<String, String>();
  bool isLoginProcessed = false;
  // Future<SuccessModel> successModel;

  // ChuckBloc _bloc = new ChuckBloc();

  @override
  void initState() {
    debugPrint('calling api');
    super.initState();
    // _bloc.doctorAccountLogin({});
  }

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
          Image.asset(
            'assets/images/icon.png',
            width: screenHeight / 2.7,
            height: screenHeight / 2.7,
          ),
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
              child: Container(
                decoration: BoxDecoration(
                  color: CompanyStyle.primaryColor[100],
                    border: Border.all(width: 1,color:CompanyStyle.primaryColor[1003].withOpacity(0.2) ),
                    borderRadius: BorderRadius.circular(10),

                ),
                padding: EdgeInsets.all(15.0),
                // color: CompanyStyle.primaryColor,
                child: Form(
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
                          prefixIcon: Icon(Icons.medical_services, color: Colors.white),
                          labelText: "Email-ID/Mobile No.",
                          labelStyle: TextStyle(
                              color: Colors.white, fontSize: screenHeight / 35),
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
                          prefixIcon: Icon(Icons.vpn_key_rounded, color: Colors.white),
                          labelText: "Password",
                          labelStyle: TextStyle(
                              color: Colors.white, fontSize: screenHeight / 35),
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() =>
                                  this._showPassword = !this._showPassword);
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

                                  // final key = encrypt.Key.fromUtf8("6tAyL1hqrHEHruDtsiYS7A==");
                                  // final iv = encrypt.IV.fromLength(16);
                                  // final encrypter = encrypt.Encrypter(encrypt.AES(key));
                                  //
                                  // final encrypted = encrypter.encrypt(password.text, iv: iv);
                                  // final decrypted = encrypter.decrypt(encrypted, iv: iv);

                                  // debugPrint(decrypted);
                                  // debugPrint(encrypted.bytes.toString());
                                  // debugPrint(encrypted.base16);
                                  // debugPrint(encrypted.base64);

                                  reqBody = {
                                    'emailId': username.text,
                                    'password': password.text,
                                    'accountType':CommonConstant.ACCOUNT_DOCTOR
                                  };
                                  debugPrint('reqBody=' + reqBody.toString());
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
                                  letterSpacing: 2,
                                ),

                              ),
                              Icon(Icons.help),
                            ],
                          ),
                          width: double.infinity,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword(accountType: CommonConstant.ACCOUNT_DOCTOR,)));

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
  // void _onLoading() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: new Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             new CircularProgressIndicator(),
  //
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //
  // }

   processLogin(BuildContext context, Map<String, dynamic> reqBody) async {
     // final SharedPreferences prefs = await _prefs;
     debugPrint(reqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isLoginProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);

    SuccessModel successModel;
    try {
      final response = await _provider.post("/account/doctor-login", reqBody);
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
          debugPrint('availableAmount=${documentsVerificationModel.availableAmount}');
          if( documentsVerificationModel.availableAmount!=null && documentsVerificationModel.availableAmount!="")
          {
            availableAmount=double.parse(documentsVerificationModel.availableAmount);
          }
          if(availableAmount<1)
          {
            debugPrint('going to PaymentPage');
            debugPrint('allDocUploaded=${documentsVerificationModel.allDocUploaded}');
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(accountId: successModel.id,allDocUploaded: documentsVerificationModel.allDocUploaded,)));
          }
          else if(documentsVerificationModel.allDocUploaded!=null && documentsVerificationModel.allDocUploaded==CommonConstant.FLAG_N)
          {
            debugPrint('going to docupload');
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDocumentUpload(accountId: successModel.id,)));
          }else{
            if(successModel.activeFlag!=null && successModel.activeFlag==CommonConstant.FLAG_Y) {
              _formKey.currentState.reset();
              password.clear();
              username.clear();
              // prefs.setString("accountId", successModel.id);
              // prefs.setString("accountType", CommonConstant.ACCOUNT_DOCTOR);
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => UserHomePage(accountId: successModel.id,accountType: CommonConstant.ACCOUNT_DOCTOR,)));
            }else{
              //open otp
              Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyUserOtp(accountId: successModel.id,accountType: CommonConstant.ACCOUNT_DOCTOR,emailId: successModel.emailId,)));

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

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({this.errorMessage, this.onRetryPressed})
      : super();

  @override
  Widget build(BuildContext context) {
    debugPrint('errorMessage=' + errorMessage);
    showSnackBar(context, errorMessage, Colors.red, Colors.white);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'NaN',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          ElevatedButton(

            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({ this.loadingMessage}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 1,
            valueColor:
                AlwaysStoppedAnimation<Color>(CompanyStyle.primaryColor[900]),
          ),
        ],
      ),
    );
  }
}

class CompletedData extends StatelessWidget {
  final SuccessModel responseData;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  CompletedData({ this.responseData, this.onRetryPressed})
      : super();
  final Function onRetryPressed;

  @override
  Widget build(BuildContext context) {
    if (responseData.status == 'FAILED') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Login Failed',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    }
    debugPrint('inside completed');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(''),
        ],
      ),
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
