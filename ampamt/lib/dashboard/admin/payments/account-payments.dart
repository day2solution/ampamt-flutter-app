import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/dashboard/admin/display/doctor-account-details.dart';
import 'package:ampamt/model/payment/ampamt-cash-account-model.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AccountPayments extends StatefulWidget {
  final String accountId;
  AccountPayments({this.accountId}) : super();
  @override
  _AccountPaymentsState createState() => _AccountPaymentsState(accountId: accountId);
}

class _AccountPaymentsState extends State<AccountPayments> {
  final String accountId;
  _AccountPaymentsState({this.accountId}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  // static double screenHeight;
  Future<List<AmpamtCashAccountModel>> futureAmpamtCashAccountModelList;

  List<AmpamtCashAccountModel> ampamtCashAccountModelList = [];
  int totalPayments=0;
  double totalAmount=0;
  @override
  void initState() {
    debugPrint('getting payment list');
    super.initState();
    debugPrint('accountId=$accountId');
    futureAmpamtCashAccountModelList=getAllCashAccountsPayments();
    futureAmpamtCashAccountModelList.then((value) => totalAmount=getTotalAmount(value));
  }

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
            Image.asset(
                'assets/images/dashboard/app/payment-done.png',
                width: 40,
                height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Account Payments',
                  style: TextStyle(fontSize: screenWidth / 20),
                ))
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: CompanyStyle.primaryColor[200],
              padding: EdgeInsets.only(left: 15.0,right: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Payment List',  style: TextStyle(fontSize: screenWidth/25,fontWeight: FontWeight.bold),),
                            SizedBox(width: 5,),
                            InputChip(
                              tooltip: 'Total payments',
                              disabledColor: Colors.white,
                              label: Text('$totalPayments',style: TextStyle(fontSize: screenWidth/25,color: Colors.black,fontWeight: FontWeight.bold)),
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
                      Image.asset('assets/images/dashboard/app/money_bag.png', width: screenWidth/15, height: screenWidth/15),
                      SizedBox(width: 5,),
                      Text('${CommonUtil.convertToIndianCurrency(totalAmount)}',style: TextStyle(fontSize: screenWidth/22,fontWeight: FontWeight.bold),),

                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child:Container(
                child:FutureBuilder(
                    future: futureAmpamtCashAccountModelList,
                    builder: (context,AsyncSnapshot snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return CommonUtil.showLoading("Loading Payments...",context);
                      }else if(snapshot.hasError){
                        print('error at haserror');
                        return Text('Error occurred');
                      }
                      else{
                        if(snapshot.data!=null && snapshot.data.length>0){
                          return Container(
                              child:Column(
                            children: [
                                Expanded(
                                  child: ListView.builder(
                                      padding:EdgeInsets.all(5),
                                      itemCount:snapshot.data.length ,
                                      itemBuilder: (context,int index){

                                        return buildPaymentDetailsCards(snapshot.data[index]);
                                      })),

                            ],
                          )
                          );
                        }else{
                          return CommonUtil.getEmptyMsg("Details not found", context);
                        }
                      }
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<AmpamtCashAccountModel>> getAllCashAccountsPayments() async {
    ApiProvider _provider = new ApiProvider();
    Map<String, dynamic> eventMap = new Map<String, String>();

    try {
      final response = await _provider.post("/transaction/get-cash-account-detail", eventMap);
      ampamtCashAccountModelList = (response as List).map((data) => AmpamtCashAccountModel.fromJson(data)).toList();
      setState(() {
        totalPayments=ampamtCashAccountModelList.length;
      });
    } catch (e) {
      print('error at getAllCashAccountsPayments page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
    }
    return ampamtCashAccountModelList;
  }
  SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor) {
    return SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgcolor);
  }
  _showDoctorAccountDetails(String id){
    print('display account details for $id');
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorAccountDetails(accountId: id,)));
  }
  Widget buildPaymentDetailsCards(AmpamtCashAccountModel ampamtCashAccountModel) {

    return Container(

      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: CompanyStyle.primaryColor[1003].withOpacity(0.2),
              width: 2,
            )
        ),
        color: CompanyStyle.primaryColor,
        child: Column(
          children: [
            Container(
              padding:EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start ,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Icon(Icons.calendar_today),
                              SizedBox(width: 5,),
                              Text(CommonUtil.getDDMMMYYYYStringDate(ampamtCashAccountModel.createDate),style: TextStyle(fontSize: screenWidth/25)),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TextButton(onPressed: () {
                              _showDoctorAccountDetails(ampamtCashAccountModel.accountId);
                            },
                                child: Text('${ampamtCashAccountModel.accountId}',style: TextStyle(color: Colors.blue,fontSize: screenWidth/25),),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  CompanyStyle.getInputElementGap(),
                  Container(
                    child: Row(
                      children: [
                        Text('Amount : ',style: TextStyle(fontSize: screenWidth/20),),
                        SizedBox(width: 5,),
                        Text('${CommonUtil.convertToIndianCurrency(ampamtCashAccountModel.availableAmount)}',style: TextStyle(fontSize: screenWidth/25),),

                      ],
                    ),
                  ),

                ],
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


  double getTotalAmount(List<AmpamtCashAccountModel> value) {
    double totalAmount=0;
    for(AmpamtCashAccountModel model in value){
      totalAmount=totalAmount+model.availableAmount;
    }

    return totalAmount;
  }
}