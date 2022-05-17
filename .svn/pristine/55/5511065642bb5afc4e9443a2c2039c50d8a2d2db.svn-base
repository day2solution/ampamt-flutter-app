import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  final String accountId;
  final String accountType;
  final String emailId;
  ChangePassword({this.accountId,this.accountType,this.emailId}) : super();
  @override
  _ChangePasswordState createState() => _ChangePasswordState(accountId: accountId,accountType: accountType,emailId: emailId);
}

class _ChangePasswordState extends State<ChangePassword> {
  final String accountId;
  final String accountType;
  final String emailId;
  _ChangePasswordState({this.accountId,this.accountType,this.emailId}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final currentPassword = TextEditingController();
  bool _showConPassword=false;
  bool _showPassword=false;
  bool _showCurrPassword=false;
  final conPassword = TextEditingController();
  Map<String, dynamic> documentReqBody = new Map<String, String>();
  bool isDataProcessed=false;
  @override
  void initState() {
    print('chnage password=$accountId accountType=$accountType emailId=$emailId');
    super.initState();

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
            Image.asset(
                'assets/images/dashboard/app/21.png',
                width: 40,
                height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: screenWidth / 20),
                ))
          ],
        ),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children:<Widget> [
            Card(
              color: CompanyStyle.primaryColor,
              child: Text('Your password must be in 6 to 12 in length'),
            ),
            Container(
              color: CompanyStyle.primaryColor,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      maxLength: 12,
                      obscureText: !_showCurrPassword,
                      controller: currentPassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                        labelText: "Enter Current Password *",
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _showCurrPassword ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() => this._showCurrPassword = !this._showCurrPassword);
                          },
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      maxLength: 12,
                      obscureText: !_showPassword,
                      controller: password,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value.length<6) {
                          return 'Your password must be at least 6 character';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                        labelText: "Enter New Password *",
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
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      maxLength: 12,
                      obscureText: !_showConPassword,
                      controller: conPassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value.length<6) {
                          return 'Your password must be at least 6 character';
                        }
                        if (!CommonUtil.isEqualBothString(value, password.text)) {
                          return "Please ensure both password must be same";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                        labelText: "Confirm New Password *",
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _showConPassword ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() => this._showConPassword = !this._showConPassword);
                          },
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    Center(
                      child:ElevatedButton(
                        style:  CompanyStyle.getButtonStyle(),
                        onPressed: isDataProcessed?null:() {

                          documentReqBody['id']=accountId;
                          documentReqBody['password']= password.text;
                          documentReqBody['currentPassword']= currentPassword.text;
                          documentReqBody['accountType']= accountType;
                          documentReqBody['emailId']= emailId;
                          if (_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            debugPrint('documentReqBody=' + documentReqBody.toString());
                            changePassword(context, documentReqBody);
                          }else{

                            debugPrint('documentReqBody=' + documentReqBody.toString());
                          }

                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Text('Change Password', style: TextStyle(fontSize: screenWidth/25),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
  void changePassword(BuildContext context, Map<String, dynamic> reqBody) async{
    debugPrint('before submitting='+documentReqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    SuccessModel successModel;
    try {
      final response = await _provider.post("/account/change-current-password", reqBody);
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
        showSnackBar(context, 'Password changed successfully', Colors.green, Colors.white);
        Navigator.pop(context);
      }
      else if (successModel.status == CommonConstant.STATUS_FAILED && successModel.msg==CommonConstant.NOTFOUNT) {
        showSnackBar(
            context, 'Incorrect current password, please enter correct password', Colors.red, Colors.white);
      }else if (successModel.status == CommonConstant.STATUS_FAILED) {
        showSnackBar(
            context, 'Failed to change your password.', Colors.red, Colors.white);
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
