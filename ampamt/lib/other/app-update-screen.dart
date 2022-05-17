import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/dashboard/admin/display/doctor-account-details.dart';
import 'package:ampamt/model/app-update-model.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateScreen extends StatefulWidget {
  final AppUpdateModel appUpdateModel;
  AppUpdateScreen({this.appUpdateModel}) : super();

  @override
  _AppUpdateScreenState createState() => _AppUpdateScreenState(appUpdateModel: appUpdateModel);
}

class _AppUpdateScreenState extends State<AppUpdateScreen> {
  final AppUpdateModel appUpdateModel;
  _AppUpdateScreenState({this.appUpdateModel}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  // static double screenHeight;
  Future<String> futureVersionName;
  String versionName = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureVersionName = CommonUtil.getVersionCode();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    // screenHeight = _mediaQueryData.size.height;

    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 5),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Image.asset(
                                          'assets/images/icon.png',
                                          width: screenWidth / 10,
                                          height: screenWidth / 10,
                                        ),
                                      ),
                                      Text(
                                        'By AMPAMT Team',
                                        style: TextStyle(
                                            fontSize: screenWidth / 80,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  child:FutureBuilder(
                                      future: futureVersionName,
                                      builder: (context,AsyncSnapshot snapshot){
                                        if(snapshot.connectionState==ConnectionState.waiting){
                                          return Text('');
                                        }else if(snapshot.hasError){
                                          debugPrint('error at haserror');
                                          return Text('');
                                        }
                                        else{

                                          if(snapshot.data!=null && snapshot.data.length>0){
                                            return buildVersionDetails(snapshot.data);
                                          }else{
                                            return Text('');
                                          }
                                        }
                                      }
                                  ),
                                )

                              ],
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                        Divider(
                          color: CompanyStyle.primaryColor[800],
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Image.asset('assets/images/icon.png',
                              width: screenWidth / 2),
                        ),
                        Text(
                          'By AMPAMT Team',
                          style: TextStyle(
                              fontSize: screenWidth / 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('NEW VERSION AVAILABLE',
                            style: TextStyle(
                              fontSize: screenWidth / 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text('A New Version of AMPAMT App '
                              '${!CommonUtil.isBlank(appUpdateModel.versionName)?'(v'+(appUpdateModel.versionName)+')':''} '
                              'is now available. Please update it now.', softWrap: true, textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenWidth / 25,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                left: screenWidth / 20,
                                top: screenWidth / 40,
                                bottom: screenWidth / 40,
                                right: screenWidth / 20),
                            width: screenWidth,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Features :',
                                            style: TextStyle(
                                                fontSize: screenWidth / 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(width: 5,),
                                              Icon(Icons.star, color: Colors.green, size: screenWidth / 25,),
                                              SizedBox(width: 5,),
                                              Text('Minor Bug Fixes', style: TextStyle(fontSize: screenWidth / 30),),
                                            ],
                                          ),
                                        ],
                                      ),

                                      // Text('Support Email\r\n', softWrap: true, textAlign: TextAlign.left, style: TextStyle(fontSize: screenWidth/50),),
                                    ],
                                  ),
                                ),
                                // Expanded(

                                // ),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 1, color: Colors.black26),
                      primary: Colors.black26,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(2),
                      child: Text('NOT NOW',),
                      width: screenWidth / 3,
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          width: 1, color: CompanyStyle.primaryColor[700]),
                      primary: CompanyStyle.primaryColor,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      padding: EdgeInsets.all(2),
                      child: Text(
                        'UPDATE NOW',
                      ),
                      width: screenWidth / 3,
                    ),
                    onPressed: () {
                      _launchInBrowser();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget buildVersionDetails(String version) {
    debugPrint('buildVersionDetails version=$version');
    return Text('v$version',
        style: TextStyle(
          color: Colors.grey,
        ));
  }
  Future<void> _launchInBrowser() async {
    String url = CommonConstant.APP_PLAY_STORE_LINK;
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        showSnackBar(
            context, 'Could not launch $url', Colors.red, Colors.white);
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }
}
