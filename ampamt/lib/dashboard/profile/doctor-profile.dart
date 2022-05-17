import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/dashboard/profile/change-password.dart';
import 'package:ampamt/dashboard/profile/doctor/edit-doctor-acc-details.dart';
import 'package:ampamt/dashboard/profile/doctor/edit-doctor-documents.dart';
import 'package:ampamt/model/doctor/DoctorsAccountDetailsModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorProfile extends StatefulWidget {
  final String accountId;
  final Future<List<DoctorsAccountDetailsModel>> doctorsAccDtlModel;
  DoctorProfile({this.accountId,this.doctorsAccDtlModel}) : super();
  @override
  _DoctorProfileState createState() => _DoctorProfileState(accountId: accountId,doctorsAccDtlModel: doctorsAccDtlModel);
}

class _DoctorProfileState extends State<DoctorProfile> {
  final String accountId;
  final Future<List<DoctorsAccountDetailsModel>> doctorsAccDtlModel;
  _DoctorProfileState({this.accountId,this.doctorsAccDtlModel}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  Future<List<DoctorsAccountDetailsModel>> doctorsAccountDetailsFutureList;

  List<DoctorsAccountDetailsModel> doctorsAccountDetailsModelList=[];

  @override
  void initState() {
    super.initState();
    debugPrint('accountId=$accountId');
    debugPrint('doctorsAccDtlModel=$doctorsAccDtlModel');
    // if(doctorsAccDtlModel==null){
    //   doctorsAccountDetailsFutureList=getLoggedDoctorAccount(context);
    // }else{
    //   debugPrint('api call not required');
    //   doctorsAccountDetailsFutureList=doctorsAccDtlModel;
    // }
    doctorsAccountDetailsFutureList=getLoggedDoctorAccount(context);
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
            Image.asset('assets/images/home/doctor_login.png', width: 40, height: 40),
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
                  future: doctorsAccountDetailsFutureList,
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
                        return buildDoctorsDetailsTiles(snapshot.data[0]);
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
  Widget buildDoctorsDetailsTiles(DoctorsAccountDetailsModel doctorsAccDtlModel) {
    String firstName;
    String lastName;
    String nameTitle;
    if(doctorsAccDtlModel!=null){
      if(doctorsAccDtlModel.nameTitle!=null){
        nameTitle=CommonUtil.convertToTitleCase(doctorsAccDtlModel.nameTitle);
      }

      if(doctorsAccDtlModel.firstName!=null){
        firstName=CommonUtil.convertToTitleCase(doctorsAccDtlModel.firstName);
      }
      if(doctorsAccDtlModel.lastName!=null){
        lastName=CommonUtil.convertToTitleCase(doctorsAccDtlModel.lastName);
      }
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
                  CommonUtil.getImage(doctorsAccDtlModel.profilePic, context),
                  SizedBox(width: 10,),
                  Flexible(child: Text(nameTitle+' '+firstName+' '+lastName+'\r\n'+doctorsAccDtlModel.emailId+'\r\n'+doctorsAccDtlModel.contactNo,
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword(accountId: accountId,emailId: doctorsAccDtlModel.emailId,accountType: CommonConstant.ACCOUNT_DOCTOR,)));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditDoctorDocumentsDetails(accountId: accountId,)));


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

                  leading: Icon(Icons.edit,size: 20),
                  title: Text('Edit Account Details'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditDoctorAccDetails(accountId: accountId,doctorsAccDtlModel: doctorsAccountDetailsFutureList,)));
                  },
                )),
          ],
        )
    );
  }

  Future<List<DoctorsAccountDetailsModel>> getLoggedDoctorAccount( BuildContext context) async{
    Map<String, dynamic> reqBody = new Map<String, String>();
    reqBody={
      'id': accountId

    };
    ApiProvider _provider = new ApiProvider();
    try {
      final response = await _provider.post("/account/get-doctor-detail",reqBody);
      doctorsAccountDetailsModelList = (response as List).map((data) => DoctorsAccountDetailsModel.fromJson(data)).toList();

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
