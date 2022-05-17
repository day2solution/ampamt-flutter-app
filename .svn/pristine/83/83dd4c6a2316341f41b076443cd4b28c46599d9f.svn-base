import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/dashboard/pdf-viewer-screen.dart';
import 'package:ampamt/model/business/BusinessAccountDetailsModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
double screenWidth;
class BusinessAccountDetails extends StatefulWidget {
  final String accountId;
  BusinessAccountDetails({Key key, this.accountId}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<BusinessAccountDetails> {
  static MediaQueryData _mediaQueryData;
  static double screenHeight;
  final String accountId;
  _MyCustomFormState({Key key, this.accountId}) : super();
  Future<List<BusinessAccountDetailsModel>>  futureBusinessAccountDtlsModelList;
  List<BusinessAccountDetailsModel>  businessAccountDtlsModelList;
  // DoctorBloc _doctorBloc=new DoctorBloc();
  Map<String, dynamic> reqBody = new Map<String, String>();
  @override
  void initState() {
    debugPrint('calling api');
    super.initState();
    reqBody['id']=widget.accountId;
    futureBusinessAccountDtlsModelList=getBusinessAccountById(reqBody);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title: Row(
          children: [
            Image.asset(
                'assets/images/home/business_login.png',
                width: 40,
                height: 40),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Account Details',
                style: TextStyle(fontSize: screenWidth / 20),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child:  Container(
          child: FutureBuilder(
              future: futureBusinessAccountDtlsModelList,
              builder: (context,AsyncSnapshot snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CommonUtil.showLoading("Loading Details...",context);
                }
                else if(snapshot.hasError){
                  print('error at haserror');
                  return Text('Error');
                }
                else{
                  if(snapshot.data!=null && snapshot.data.length>0){
                    return ListView.builder(
                        itemCount:snapshot.data.length ,
                        itemBuilder: (context,int index){
                          return buildAccountDetailsTiles(snapshot.data[0]);
                        });
                  }else{
                    return CommonUtil.getEmptyMsg('Details not found', context);
                  }

                }
              }
          ),
        ),
      ),
    );
    // return ;
  }

  Future<List<BusinessAccountDetailsModel>> getBusinessAccountById(Map<String, dynamic> reqBody) async{
    ApiProvider _provider = new ApiProvider();
    try {
      final response = await _provider.post("/account/get-business-acc-detail",reqBody);
      businessAccountDtlsModelList = (response as List).map((data) => BusinessAccountDetailsModel.fromJson(data)).toList();
    } catch (e) {
      print('error at display page='+e.toString().toString());
      futureShowSnackBar(context, e.toString(), Colors.red,  Colors.white);
    }
    return businessAccountDtlsModelList;
  }
  futureShowSnackBar(BuildContext context, String msg, Color bgcolor, Color txtColor) {
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

  Widget buildAccountDetailsTiles(BusinessAccountDetailsModel businessAccountModel) {
    return Container(
      child: Column(
        children: [
          Card(

            shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(6),
                side: BorderSide(
                  color: CompanyStyle.primaryColor.withOpacity(0.2),
                  width: 2,
                )
            ),
            color: CompanyStyle.primaryColor,
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                CommonUtil.getImage(businessAccountModel.companyLogo, context),
                SizedBox(width: 10,),
                Flexible(child: Text(
                    CommonUtil.convertToTitleCase(businessAccountModel.companyName+' '+(businessAccountModel.companyTitle!=null?businessAccountModel.companyTitle:'')),
                    softWrap: true,
                    textAlign: TextAlign.start,
                    overflow:TextOverflow.visible,
                    style:TextStyle(fontSize: screenWidth / 25,)
                ),),
              ],
            ),
          ),
          Container(
            // width: screenWidth,
            padding:EdgeInsets.all( 5),
            color: Colors.white,

            child: Row(
              children: [
                Text('Contact Details',style: TextStyle(color: Colors.black,fontSize: screenWidth/20),),
                SizedBox(width: 10,),
                InputChip(
                  tooltip: 'Account Status',
                  backgroundColor: businessAccountModel.activeFlag!=null?( businessAccountModel.activeFlag=='Y'?Colors.green:Colors.red):Colors.grey,
                  label: Text(businessAccountModel.status,style: TextStyle(fontSize: screenWidth/25)),
                  onSelected: (bool value) {},
                ),
                SizedBox(width: 20,),
                InputChip(
                  tooltip: 'Open PDF',
                  backgroundColor: Colors.white,
                  label: Image.asset('assets/images/pdf_icon.png', width: 40, height: 40),
                  onSelected: (bool value) {
                    debugPrint('clicked');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfViewerScreen(businessModel: businessAccountModel,accountType: CommonConstant.ACCOUNT_BUSINESS,)));
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
              // Container(
              //   child: Row(
              //     children: [
              //       Container(
              //
              //         child: Center(
              //           child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget>[
              //                 TextButton(onPressed: () {
              //                   // previewPdf();
              //
              //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>
              //                       PdfViewerScreen(accountType: CommonConstant.ACCOUNT_BUSINESS,businessModel: businessAccountModel,)));
              //                 },
              //                     child: Image.asset('assets/images/dashboard/app/7.png',width: screenWidth / 10, height: screenWidth / 10,)
              //                 ),
              //
              //
              //               ]),
              //         ),
              //       ),
              //       Container(
              //
              //         child: Center(
              //           child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget>[
              //                 TextButton(onPressed: () { },
              //                     child: Image.asset('assets/images/dashboard/app/8.png',width: screenWidth / 10, height: screenWidth / 10,)
              //                 ),
              //
              //
              //               ]),
              //         ),
              //       ),
              //       Container(
              //
              //         child: Center(
              //           child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget>[
              //                 TextButton(onPressed: () { },
              //                     child: Image.asset('assets/images/home/upload-doc.png',width: screenWidth / 10, height: screenWidth / 10,)
              //                 ),
              //
              //
              //               ]),
              //         ),
              //       ),
              //       Container(
              //
              //         child: Center(
              //           child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget>[
              //                 TextButton(onPressed: () { },
              //                     child: Image.asset('assets/images/support/email.png',width: screenWidth / 10, height: screenWidth / 10,)
              //                 ),
              //
              //
              //               ]),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //   Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('contact No. :',style: getHeadingTextStyle(),),
                    title: Text(businessAccountModel.contactNo,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Other contact No. :',style: getHeadingTextStyle(),),
                    title: Text(businessAccountModel.otherContactNo,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Whatsapp No. :',style: getHeadingTextStyle(),),
                    title: Text(businessAccountModel.whatsappNo,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Email-ID :',style: getHeadingTextStyle(),),
                    title: Text(businessAccountModel.emailId,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Other Email-ID :',style: getHeadingTextStyle(),),
                    title: Text(!CommonUtil.isBlank(businessAccountModel.otherEmailId)?businessAccountModel.otherEmailId:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  padding:EdgeInsets.all( 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text('Owner Details',style: TextStyle(color: Colors.black,fontSize: screenWidth/20),),
                      SizedBox(height: 40,width: 10,),
                      Icon(Icons.person, color: Colors.blue,)
                    ],
                  ),
                ),
                Container(
                  child:ListTile(
                    leading: Text('Owner Name :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.ownerNameTitle) + ' ' +
                      CommonUtil.convertToTitleCase(businessAccountModel.companyOwnerName),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Owner Gender :',style: getHeadingTextStyle(),),
                    title: Text(businessAccountModel.ownerGender!=null?(businessAccountModel.ownerGender=='M'?'Male':
                              (businessAccountModel.ownerGender=='F'?'Female':
                              (businessAccountModel.ownerGender=='T'?'Transgender':
                              businessAccountModel.ownerGender))):
                              "-",style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Owner Religion :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.ownerReligion),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Owner Nationality :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.ownerNationality),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Owner Detail :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.ownerDetail),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  padding:EdgeInsets.all( 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text('Representative Details',style: TextStyle(color: Colors.black,fontSize: screenWidth/20),),
                      SizedBox(height: 40,width: 10,),
                      Icon(Icons.person, color: Colors.blue,)
                    ],
                  ),
                ),
                Container(
                  child:ListTile(
                    leading: Text('Representative Name :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.representativeNameTitle) + ' ' +
                        CommonUtil.convertToTitleCase(businessAccountModel.representativeName),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Representative Gender :',style: getHeadingTextStyle(),),
                    title: Text(businessAccountModel.representativeGender!=null?(businessAccountModel.representativeGender=='M'?'Male':
                    (businessAccountModel.representativeGender=='F'?'Female':
                    (businessAccountModel.representativeGender=='T'?'Transgender':
                    businessAccountModel.representativeGender))):
                    "-",style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  padding:EdgeInsets.all( 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text('Address Info',style: TextStyle(color: Colors.black,fontSize: screenWidth/20),),
                      SizedBox(height: 40,width: 10,),
                      Icon(Icons.location_city, color: Colors.blue,)
                    ],
                  ),
                ),
                Container(
                  child:ListTile(
                    leading: Text('Pincode :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.zipCode),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('City :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.city),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('State :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.state),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Landmark :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.landmark),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Office Address :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.registOfficeAdd),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  padding:EdgeInsets.all( 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text('Other Info',style: TextStyle(color: Colors.black,fontSize: screenWidth/20),),
                      SizedBox(height: 40,width: 10,),
                      Icon(Icons.info, color: Colors.blue,)
                    ],
                  ),
                ),
                Container(
                  child:ListTile(
                    leading: Text('Terms & conditions accepted :',style: getHeadingTextStyle(),),
                    title: Text(!CommonUtil.isBlank(businessAccountModel.tncAccepted)?(businessAccountModel.tncAccepted==CommonConstant.FLAG_Y?'Yes':'No'):'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Account Type :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.accountType),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Created Date :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.getDDMMMYYYYStringDate(businessAccountModel.createDate),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Experience Establishment(Year) :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.experiencEstablishment),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Sector :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.sector),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Aadhar No. :',style: getHeadingTextStyle(),),
                    title: Text(CommonUtil.convertToTitleCase(businessAccountModel.aadharNo),style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Pan No. :',style: getHeadingTextStyle(),),
                    title: Text(!CommonUtil.isBlank(businessAccountModel.panNo)?businessAccountModel.panNo:'-',style: getTextStyle(),),

                  ),
                ),
                // Divider(color: CompanyStyle.primaryColor[1003],),
              ],
            ),
          )
        ],
      ),
    );
  }
}

getHeadingTextStyle(){
  return TextStyle(
    fontSize: screenWidth/25,

  );
}
getTextStyle(){
  return TextStyle(
    fontSize: screenWidth/25,

  );
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