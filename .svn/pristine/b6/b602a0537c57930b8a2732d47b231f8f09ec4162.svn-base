import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/CustomResponseModel.dart';
import 'package:ampamt/dashboard/bloc/DoctorBloc.dart';
import 'package:ampamt/dashboard/pdf-viewer-screen.dart';
import 'package:ampamt/model/doctor/DoctorsAccountDetailsModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
double screenWidth;
class DoctorAccountDetails extends StatefulWidget {
  final String accountId;
  DoctorAccountDetails({Key key, this.accountId}) : super(key: key);

  @override
  _DoctorAccountDetailsState createState() => _DoctorAccountDetailsState(accountId: accountId);
}



// class MyCustomForm extends StatefulWidget {
//   final String accountId;
//   MyCustomForm({Key key,this.accountId}):super(key: key);
//   @override
//   MyCustomFormState createState() {
//     return MyCustomFormState();
//   }
// }

class _DoctorAccountDetailsState extends State<DoctorAccountDetails> {
  static MediaQueryData _mediaQueryData;
  static double screenHeight;
  final String accountId;
  _DoctorAccountDetailsState({Key key, this.accountId}) : super();

DoctorBloc _doctorBloc=new DoctorBloc();
Map<String, dynamic> reqBody = new Map<String, String>();
  @override
  void initState() {
    debugPrint('calling api');
    super.initState();
    reqBody['id']=widget.accountId;
    _doctorBloc.getDoctorAccountById(reqBody);

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
                'assets/images/dashboard/app/doctor.png',
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
        child: ListView(
          shrinkWrap: true,

          children: <Widget>[
            Container(
              // padding: EdgeInsets.all(5.0),
              child: StreamBuilder<CustomResponseModel<List<DoctorsAccountDetailsModel>>>(

                stream: _doctorBloc.doctorDataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        return CommonUtil.showLoading("Loading Account Details...", context);
                        break;
                      case Status.COMPLETED:
                        return CompletedData(
                          doctorModel: snapshot.data.data[0],
                          accountId: accountId,
                        );
                        break;
                      case Status.ERROR:

                        return Error(errorMessage:snapshot.data.message, onRetryPressed:()=>_doctorBloc.getDoctorAccountById(reqBody));
                        break;
                    }
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );

  }
}
class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('errorMessage='+errorMessage);
    showSnackBar(context, errorMessage, Colors.red, Colors.white);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth/40,
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

  const Loading({Key key, this.loadingMessage}) : super(key: key);
  // showAlertDialog(BuildContext context){
  //   AlertDialog alert=AlertDialog(
  //     content: new Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
  //       ],),
  //   );
  //   showDialog(barrierDismissible: false,
  //     context:context,
  //     builder:(BuildContext context){
  //       return alert;
  //     },
  //   );
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // showAlertDialog(context),
          SizedBox(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(CompanyStyle.primaryColor[900]),
            ),
            height:screenWidth/ 5,
            width: screenWidth/ 5,
          ),
          SizedBox(height: 10,),
          Text('Loading Account Details...',style: TextStyle(fontSize: screenWidth/20),),
        ],
      ),
    );
  }
}
class CompletedData extends StatelessWidget {

  final DoctorsAccountDetailsModel doctorModel;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final String accountId;
  CompletedData({Key key, this.doctorModel,this.onRetryPressed,this.accountId}) : super(key: key);
  final Function onRetryPressed;
  @override
  Widget build(BuildContext context) {
    // String base64ProfileImage=doctorModel.profilePic;
    // var finalimg2;
    // if(base64ProfileImage!=null){
    //   String finalimg=base64ProfileImage.split(",")[1];
    //   finalimg2 = Base64Decoder().convert(finalimg);
    // }

    return Container(
      child: Column(

        children: <Widget>[
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
                CommonUtil.getImage(doctorModel.profilePic, context),
                SizedBox(width: 10,),
                Flexible(child: Text(
                    CommonUtil.convertToTitleCase(doctorModel.companyName+' '+(doctorModel.companyTitle!=null?doctorModel.companyTitle:'')),
                    softWrap: true,
                    textAlign: TextAlign.start,
                      overflow:TextOverflow.visible,
                    style:TextStyle(fontSize: screenWidth / 25,)
                ),),
              ],
            ),
          ),
          // Divider(color: Colors.blue,height: 2,thickness: 2,),
          Container(
            // width: screenWidth,
            padding:EdgeInsets.all( 5),
            color: Colors.white,

             child: Row(
               children: [
                 Text('Personal Details',style: TextStyle(color: Colors.black,fontSize: screenWidth/20),),
                 SizedBox(width: 10,),
                 InputChip(
                  tooltip: 'Account Status',
                   backgroundColor: doctorModel.activeFlag!=null?( doctorModel.activeFlag=='Y'?Colors.green:Colors.red):Colors.grey,
                   label: Text(doctorModel.status,style: TextStyle(fontSize: screenWidth/25)),
                   onSelected: (bool value) {
                    debugPrint('clicked');
                   },
                 ),
                 SizedBox(width: 20,),
                 InputChip(
                   tooltip: 'Open PDF',
                   backgroundColor: Colors.white,
                   label: Image.asset('assets/images/pdf_icon.png', width: 40, height: 40),
                   onSelected: (bool value) {
                     debugPrint('clicked');
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfViewerScreen(doctorModel: doctorModel,accountType: CommonConstant.ACCOUNT_DOCTOR,)));
                   },
                 ),


               ],
             ),
          ),
          Container(
            child:Column(
              children:<Widget> [

                // Container(
                //   child:Row(
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
                //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfViewerScreen(doctorModel: doctorModel,)));
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
                //   ) ,
                // ),
                // Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                    child:ListTile(
                      leading: Text('Name :',style: getHeadingTextStyle(),),
                      title: Text(doctorModel.nameTitle + ' ' +
                          doctorModel.firstName + ' ' +
                          doctorModel.lastName,style: getTextStyle(),),

                    ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Email-ID :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.emailId,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Mobile No. :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.contactNo,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Emergency No. :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.emergencyNo,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Other Contact No. :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.otherContactNo,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('WhatsApp No. :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.whatsappNo,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Religion :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.religion,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Blood Group :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.bloodGroup,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Father Name :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.fatherName,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Mother Name :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.motherName,style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Wife/Husband Name :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.wifeHusbandName!=null?doctorModel.wifeHusbandName:"-",style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Gender :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.gender!=null?(doctorModel.gender=='M'?'Male':
                    (doctorModel.gender=='F'?'Female':
                    (doctorModel.gender=='T'?'Transgender':
                    doctorModel.gender))):
                    "-",style: getTextStyle(),),
                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Marital Status :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.maritalStatus,style: getTextStyle(),),

                  ),
                ),
                Container(
                  padding:EdgeInsets.all( 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text('Address Info',style: TextStyle(color: Colors.black,fontSize: screenWidth/20),),
                      SizedBox(height: 40,width: 10,),
                     Icon(Icons.location_on, color: Colors.red,)
                    ],
                  ),
                ),
                Container(
                  child:ListTile(
                    leading: Text('Practice City :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.practiceCity!=null?doctorModel.practiceCity:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Registered Office Address :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.registOfficeAdd!=null?doctorModel.registOfficeAdd:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Nationality :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.nationality!=null?doctorModel.nationality:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('City :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.city!=null?doctorModel.city:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('State :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.state!=null?doctorModel.state:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Pin Code :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.zipCode!=null?doctorModel.zipCode:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Permanent Address :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.permanentAddress!=null?doctorModel.permanentAddress:'-',style: getTextStyle(),),

                  ),
                ),
                Container(
                  padding:EdgeInsets.all( 5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text('Other Info',style: TextStyle(color: Colors.black,fontSize: screenWidth/20),),
                      SizedBox(height: 40,width: 10,),
                      Icon(Icons.info, color: Colors.red,)
                    ],
                  ),
                ),

                Container(
                  child:ListTile(
                    leading: Text('Terms & Conditions Accepted :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.tncAccepted!=null?doctorModel.tncAccepted:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Account Type :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.accountType!=null?doctorModel.accountType:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Create Date :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.createDate!=null?CommonUtil.getYYYYMMDDStringDate(doctorModel.createDate):'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Experience Establishment(Year.Month) :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.experiencEstablishment!=null?doctorModel.experiencEstablishment:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Practicing As :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.practicingAs!=null?doctorModel.practicingAs:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Practicing :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.practicing!=null?doctorModel.practicing:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Aadhar No. :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.aadharNo!=null?doctorModel.aadharNo:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Pan No :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.panNo!=null?doctorModel.panNo:'-',style: getTextStyle(),),

                  ),
                ),
                Divider(color: CompanyStyle.primaryColor[1003],),
                Container(
                  child:ListTile(
                    leading: Text('Reference :',style: getHeadingTextStyle(),),
                    title: Text(doctorModel.reference!=null?doctorModel.reference:'-',style: getTextStyle(),),

                  ),
                ),
              ],
            )

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