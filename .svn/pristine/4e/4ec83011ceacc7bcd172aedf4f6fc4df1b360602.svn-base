import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/dashboard/profile/business/edit-business-acc-details.dart';
import 'package:ampamt/dashboard/profile/business/edit-business-documents.dart';
import 'package:ampamt/dashboard/profile/change-password.dart';
import 'package:ampamt/model/business/BusinessAccountDetailsModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessProfile extends StatefulWidget {
  final String accountId;
  final Future<List<BusinessAccountDetailsModel>> businessAccDtlModel;
  BusinessProfile({this.accountId,this.businessAccDtlModel}) : super();
  @override
  _BusinessProfileState createState() => _BusinessProfileState(accountId: accountId,businessAccDtlModel: businessAccDtlModel);
}

class _BusinessProfileState extends State<BusinessProfile> {
  final String accountId;
  final Future<List<BusinessAccountDetailsModel>> businessAccDtlModel;
  _BusinessProfileState({this.accountId,this.businessAccDtlModel}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  Future<List<BusinessAccountDetailsModel>> businessAccountDetailsFutureList;

  List<BusinessAccountDetailsModel> doctorsAccountDetailsModelList=[];

  @override
  void initState() {
    super.initState();
    debugPrint('accountId=$accountId');
    debugPrint('businessAccDtlModel=$businessAccDtlModel');
    // if(doctorsAccDtlModel==null){
    //   doctorsAccountDetailsFutureList=getLoggedDoctorAccount(context);
    // }else{
    //   debugPrint('api call not required');
    //   doctorsAccountDetailsFutureList=doctorsAccDtlModel;
    // }
    businessAccountDetailsFutureList=getLoggedBusinessAccount(context);
  }
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title: Row(
          children: [
            Image.asset('assets/images/home/business_login.png', width: 40, height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text('Profile', style: TextStyle(fontSize: screenWidth / 20),)
            )
          ],
        ),
      ),
      body: Center(
        child: ListView(
          children:<Widget> [
            Card(
              color: CompanyStyle.primaryColor,
              child:Container(
                padding: EdgeInsets.all(15.0),
                child:  Text('Unique Account Id : $accountId', style: TextStyle(fontSize: screenWidth/25)),
              ),
            ),
            Container(
              child:FutureBuilder(
                  future: businessAccountDetailsFutureList,
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
                        return buildBusinessDetailsTiles(snapshot.data[0]);
                      }else{
                        return CommonUtil.getEmptyMsg("Details not found", context);
                      }
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget buildBusinessDetailsTiles(BusinessAccountDetailsModel doctorsAccDtlModel) {
    String firstName;

    String nameTitle;
    if(doctorsAccDtlModel!=null){
      if(doctorsAccDtlModel.companyTitle!=null){
        nameTitle=CommonUtil.convertToTitleCase(doctorsAccDtlModel.companyTitle);
      }

      if(doctorsAccDtlModel.companyName!=null){
        firstName=CommonUtil.convertToTitleCase(doctorsAccDtlModel.companyName);
      }
      // if(doctorsAccDtlModel.lastName!=null){
      //   lastName=CommonUtil.convertToTitleCase(doctorsAccDtlModel.lastName);
      // }
    }
    return Container(

        child:Column(
          children: [
            Card(

              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: CompanyStyle.primaryColor.withOpacity(0.2),
                    width: 2,
                  )
              ),
              color: CompanyStyle.primaryColor,
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  CommonUtil.getImage(doctorsAccDtlModel.companyLogo, context),
                  SizedBox(width: 10,),
                  Flexible(child: Text(nameTitle+' '+firstName+'\r\n'+doctorsAccDtlModel.emailId+'\r\n'+doctorsAccDtlModel.contactNo,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      overflow:TextOverflow.visible,
                      style:TextStyle(fontSize: screenWidth / 25,)
                  ),),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide( //                   <--- left side
                        color: CompanyStyle.primaryColor[400],
                        width: 1,
                      ),
                      bottom: BorderSide( //                    <--- top side
                        color: CompanyStyle.primaryColor[400],
                        width: 1,
                      ),
                    )
                ),
                child:ListTile(
                  leading: Icon(Icons.vpn_key,size: 20),
                  title: Text('Change Password'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword(accountId: accountId,emailId: doctorsAccDtlModel.emailId,accountType: CommonConstant.ACCOUNT_BUSINESS,)));
                  },
                )),
            Container(
                decoration: BoxDecoration(
                    border: Border(

                      bottom: BorderSide( //                    <--- top side
                        color: CompanyStyle.primaryColor[400],
                        width: 1,
                      ),
                    )
                ),
                child:ListTile(

                  leading: Icon(Icons.image,size: 20),
                  title: Text('Edit Certificate & Profile Image'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBusinessDocuments(accountId: accountId,)));
                  },
                )),
            Container(
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: CompanyStyle.primaryColor[400],
                        width: 1,
                      ),
                    )
                ),
                child:ListTile(
                  leading: Icon(Icons.edit,size: 20),
                  title: Text('Edit Account Details'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBusinessAccDetails(accountId: accountId,businessAccDtlModel: businessAccountDetailsFutureList,)));
                  },
                )),
          ],
        )
    );
  }

  Future<List<BusinessAccountDetailsModel>> getLoggedBusinessAccount( BuildContext context) async{
    Map<String, dynamic> reqBody = new Map<String, String>();
    reqBody={
      'id': accountId

    };
    ApiProvider _provider = new ApiProvider();
    try {
      final response = await _provider.post("/account/get-business-acc-detail",reqBody);
      doctorsAccountDetailsModelList = (response as List).map((data) => BusinessAccountDetailsModel.fromJson(data)).toList();

    } catch (e) {
      debugPrint('error at getAdvertisementsList page='+e.toString().toString());
      // final snackBar =normalSnackBar(e.toString().toString(), Colors.red,  Colors.white);
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    return doctorsAccountDetailsModelList;
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

}
