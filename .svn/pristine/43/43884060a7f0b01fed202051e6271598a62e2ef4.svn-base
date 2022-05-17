import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerSupport extends StatefulWidget {

  @override
  _CustomerSupportState createState() => _CustomerSupportState();
}
class _CustomerSupportState extends State<CustomerSupport> {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  // static double screenHeight;
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
            Image.asset('assets/images/dashboard/app/otherservices.png',
                width: 40, height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text('Customer Support',style: TextStyle(fontSize: screenWidth/20),))
          ],
        ),
      ),
      body: ServicesForm(),
    );
  }
}
class ServicesForm extends StatefulWidget {
  @override
  ServicesFormState createState() {
    return ServicesFormState();
  }
}

class ServicesFormState extends State<ServicesForm> {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    return Center(
      child:ListView(
        children:<Widget> [
          Column(
            children: <Widget>[
              Container(
                padding:EdgeInsets.all(5),
                child: Text('CUSTOMER CARE SUPPORT',style: TextStyle(fontSize: screenWidth/20,fontWeight: FontWeight.bold,letterSpacing: 3,wordSpacing: 10 ),),
              ),
              Divider(color: CompanyStyle.primaryColor[800],),
              Container(
                padding:EdgeInsets.all(5),
                child: Image.asset('assets/images/icon.png',width: screenWidth/2),
              ),

              Container(
                  alignment: Alignment.center,
                  padding:EdgeInsets.only(left:screenWidth/20,top: screenWidth/40,bottom: screenWidth/40,right: screenWidth/20),
                  width: screenWidth,
                  child:Row(
                    children:<Widget> [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Image.asset('assets/images/support/active-call.png', width: screenWidth / 10, height: screenWidth / 10,),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Support Email',  style: TextStyle(fontSize: screenWidth/25,fontWeight: FontWeight.bold),),
                                Text(CommonConstant.AMPAMT_EMAIL,  style: TextStyle(fontSize: screenWidth/30),),
                              ],
                            ),

                            // Text('Support Email\r\n', softWrap: true, textAlign: TextAlign.left, style: TextStyle(fontSize: screenWidth/50),),
                          ],
                        ),
                      ),
                      // Expanded(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TextButton(onPressed: (){
                              final Uri emailLaunchUri = Uri(scheme: 'mailto', path: CommonConstant.AMPAMT_EMAIL,);
                              launch(emailLaunchUri.toString());
                            }, child: Icon(Icons.email,color: Colors.red,), ),
                          // Text('Support Email\r\n', softWrap: true, textAlign: TextAlign.left, style: TextStyle(fontSize: screenWidth/50),),
                          ],
                        ),
                      // ),
                    ],
                  )
              ),
              Divider(color: CompanyStyle.primaryColor[800],),
              Container(
                  alignment: Alignment.center,
                  padding:EdgeInsets.only(left:screenWidth/20,top: screenWidth/40,bottom: screenWidth/40,right: screenWidth/20),
                  width: screenWidth,
                  child:Row(
                    children:<Widget> [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Image.asset('assets/images/support/call.png', width: screenWidth / 10, height: screenWidth / 10,),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Customer Care',  style: TextStyle(fontSize: screenWidth/25,fontWeight: FontWeight.bold),),
                                Text(CommonConstant.AMPAMT_CONTACTNO,  style: TextStyle(fontSize: screenWidth/30),),
                              ],
                            ),

                            // Text('Support Email\r\n', softWrap: true, textAlign: TextAlign.left, style: TextStyle(fontSize: screenWidth/50),),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TextButton(onPressed: (){
                              _makePhoneCall(CommonConstant.AMPAMT_CONTACTNO);
                            }, child: Icon(Icons.call,color: Colors.blue,), ),
                            // Text('Support Email\r\n', softWrap: true, textAlign: TextAlign.left, style: TextStyle(fontSize: screenWidth/50),),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
              Divider(color: CompanyStyle.primaryColor[800],),
              Container(
                  alignment: Alignment.center,
                  padding:EdgeInsets.only(left:screenWidth/20,top: screenWidth/40,bottom: screenWidth/40,right: screenWidth/20),
                  width: screenWidth,
                  child:Row(
                    children:<Widget> [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Image.asset('assets/images/support/active-call.png', width: screenWidth / 10, height: screenWidth / 10,),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Customer Care Available',  style: TextStyle(fontSize: screenWidth/25,fontWeight: FontWeight.bold),),
                                Text(CommonConstant.AMPAMT_WORKING_HOUR,  style: TextStyle(fontSize: screenWidth/30),),
                              ],
                            ),

                            // Text('Support Email\r\n', softWrap: true, textAlign: TextAlign.left, style: TextStyle(fontSize: screenWidth/50),),
                          ],
                        ),
                      ),

                    ],
                  )
              ),
              Divider(color: CompanyStyle.primaryColor[800],),
              Container(
                  alignment: Alignment.center,
                  padding:EdgeInsets.only(left:screenWidth/20,top: screenWidth/40,bottom: screenWidth/40,right: screenWidth/20),
                  width: screenWidth,
                  child:Row(
                    children:<Widget> [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[

                            Image.asset('assets/images/support/working-hours.png', width: screenWidth / 10, height: screenWidth / 10,),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Head Office Address',  style: TextStyle(fontSize: screenWidth/25,fontWeight: FontWeight.bold),),
                                Text(CommonConstant.AMPAMT_HEAD_OFFICE_ADDRESS,  style: TextStyle(fontSize: screenWidth/30),),
                              ],
                            ),

                            // Text('Support Email\r\n', softWrap: true, textAlign: TextAlign.left, style: TextStyle(fontSize: screenWidth/50),),
                          ],
                        ),
                      ),

                    ],
                  )
              ),
            ],
          ),
        ],
      ),

    );
  }

  _makePhoneCall(String url) async {
    FlutterPhoneDirectCaller.callNumber(url);
  }
}
