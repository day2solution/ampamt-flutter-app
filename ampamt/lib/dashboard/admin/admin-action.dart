import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/dashboard/admin/advertisement/manage-advertisements.dart';
import 'package:ampamt/dashboard/admin/display-users.dart';
import 'package:ampamt/dashboard/admin/events/manage-events.dart';
import 'package:ampamt/dashboard/admin/payments/account-payments.dart';
import 'package:ampamt/model/business/BusinessAccountDetailsModel.dart';
import 'package:ampamt/model/doctor/DoctorsAccountDetailsModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminAction extends StatefulWidget {
  final BusinessAccountDetailsModel businessAccModel;
  final DoctorsAccountDetailsModel doctorsAccModel;
  AdminAction({this.businessAccModel,this.doctorsAccModel}) : super();

  @override
  _AdminActionState createState() => _AdminActionState(businessAccModel: businessAccModel,doctorsAccModel: doctorsAccModel);
}

class _AdminActionState extends State<AdminAction> {
  final BusinessAccountDetailsModel businessAccModel;
  final DoctorsAccountDetailsModel doctorsAccModel;
  _AdminActionState({this.businessAccModel,this.doctorsAccModel}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static bool isAdmin=false;
  @override
  void initState() {
    debugPrint('admin panel');
    debugPrint('businessAccModel=$businessAccModel');
    debugPrint('doctorsAccModel=$doctorsAccModel');
    super.initState();
    if(businessAccModel!=null){
      if(!CommonUtil.isBlank(businessAccModel.adminFlag)){
        if(CommonUtil.isEqualBothString(businessAccModel.adminFlag, CommonConstant.FLAG_Y)){
          isAdmin=true;
        }
      }
    }
    if(doctorsAccModel!=null){
      if(!CommonUtil.isBlank(doctorsAccModel.adminFlag)){
        if(CommonUtil.isEqualBothString(doctorsAccModel.adminFlag, CommonConstant.FLAG_Y)){
          isAdmin=true;
        }
      }
    }
    debugPrint('isAdmin =$isAdmin');
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
                'assets/images/dashboard/app/23.png',
                width: 40,
                height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Admin Panel',
                  style: TextStyle(fontSize: screenWidth / 15),
                ))
          ],
        ),
      ),
      body: Center(
        child: isAdmin?ListView(
          padding:EdgeInsets.only(top: 5,bottom: 5),
          children:<Widget> [
            Container(
              padding:EdgeInsets.only(left: 5,top: 10,bottom: 10,right: 5),
              alignment: Alignment.center,
              width: screenWidth,
              child: Row(
                crossAxisAlignment:CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayUsers()));
                            },
                                child: Image.asset('assets/images/dashboard/app/26.png',width: screenHeight / 8, height: screenHeight / 8,)
                            ),

                            Text('MANAGE\r\nUSERS',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: getStyle(),
                            ),
                          ]),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageAdvertisements()));
                                },
                                child:Image.asset(
                                  'assets/images/dashboard/app/57.png',
                                  width: screenHeight / 8,
                                  height: screenHeight / 8,
                                )),

                            Text('MANAGE\r\nADVERTISEMENTS',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: getStyle(),
                            ),
                          ]),
                    ),
                  ),

                ],
              ),
            ),
            Container(
              padding:EdgeInsets.only(left: 5,top: 10,bottom: 10,right: 5),
              alignment: Alignment.center,
              width: screenWidth,
              child: Row(
                crossAxisAlignment:CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageEvents()));
                            },
                                child: Image.asset('assets/images/dashboard/app/41.png',width: screenHeight / 8, height: screenHeight /8,)
                            ),

                            Text('MANAGE\r\nEVENTS',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: getStyle(),
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountPayments()));
                                },
                                child:Image.asset(
                                  'assets/images/dashboard/app/payment-done.png',
                                  width: screenHeight / 8,
                                  height: screenHeight / 8,
                                )),

                            Text('ACCOUNT\r\nPAYMENTS',
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: getStyle(),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],

        ):Container(
          padding:EdgeInsets.only(top: 5,bottom: 5),
            child: Image.asset('assets/images/access_denied.png', width: screenWidth, height: screenWidth),
        ),
      ),
    );
  }
  getStyle() {
    return TextStyle(
      fontSize: screenWidth / 20,
    );
  }
}