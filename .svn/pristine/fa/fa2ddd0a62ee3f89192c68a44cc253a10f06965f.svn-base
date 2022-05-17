import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';

import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class ResetNewPasssword extends StatefulWidget{
  ResetNewPasssword({this.accountId,this.accountType,this.emailId}) : super();
  final String accountId;
  final String accountType;
  final String emailId;
  @override
  _ResetNewPasssword createState()=>_ResetNewPasssword(accountId:accountId ,accountType: accountType,emailId: emailId);

}

class _ResetNewPasssword extends State<ResetNewPasssword> {
  _ResetNewPasssword({this.accountId,this.accountType,this.emailId}) ;
  final String accountId;
  final String accountType;
  final String emailId;
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  bool _showConPassword=false;
  bool _showPassword=false;
  final conPassword = TextEditingController();

  bool isDataProcessed=false;

  Map<String, dynamic> documentReqBody = new Map<String, String>();
  @override
  void initState() {
    print('documentupload page accountId=$accountId $accountType');
    super.initState();

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
                padding: const EdgeInsets.all(10.0), child: Text('Reset Forgot Password')
            )
          ],
        ),
      ),
      body:Container(
        child:ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: CompanyStyle.primaryColor,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      maxLength: 12,
                      obscureText: !_showPassword,
                      controller: password,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                        labelText: "Enter Password *",
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
                          return 'Please confirm your password';
                        }

                        if (!CommonUtil.isEqualBothString(value, password.text)) {
                          return "Please ensure both password must be same";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                        labelText: "Confirm Password *",
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
                          documentReqBody['emailId']= emailId;
                          documentReqBody['accountType']= accountType;


                          if (_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            debugPrint('documentReqBody=' + documentReqBody.toString());
                            resetPassword(context, documentReqBody);
                          }else{

                            debugPrint('documentReqBody=' + documentReqBody.toString());
                          }

                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Text('Submit', style: TextStyle(fontSize: screenWidth/25),),
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

  showProgressIndicator(String msg){
    EasyLoading.show(status: msg);
  }
  showSuccessIndicator(String msg){
    EasyLoading.showSuccess(msg,duration: Duration(milliseconds: 700));
  }
  dismissProgressIndicator(){
    EasyLoading.dismiss(animation: true);
  }

  void resetPassword(BuildContext context, Map<String, dynamic> reqBody) async{
    debugPrint('before submitting='+documentReqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    SuccessModel successModel;
    try {
      final response = await _provider.post("/account/change-password", reqBody);
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
        showSnackBar(context, 'Password changed successfully, please login', Colors.green, Colors.white);
        Navigator.pop(context);
      } else if (successModel.status == CommonConstant.STATUS_FAILED) {
        showSnackBar(
            context, 'Failed to update your password.', Colors.red, Colors.white);
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

