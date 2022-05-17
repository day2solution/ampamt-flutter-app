import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';

// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/model/business/BusinessAccountDetailsModel.dart';
import 'package:ampamt/model/doctor/DoctorsAccountDetailsModel.dart';
import 'package:ampamt/model/search-user-model.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pdf;

class PdfViewerScreen extends StatefulWidget {
  final DoctorsAccountDetailsModel doctorModel;
  final BusinessAccountDetailsModel businessModel;
  final String accountType;
  PdfViewerScreen({this.doctorModel,this.accountType,this.businessModel}) : super();
  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState(doctorModel: doctorModel,accountType: accountType,businessModel: businessModel);
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';


  final String accountType;
  final DoctorsAccountDetailsModel doctorModel;
  final BusinessAccountDetailsModel businessModel;
  _PdfViewerScreenState({this.doctorModel,this.accountType,this.businessModel}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  Future<List<UserSearchModel>> futureUserSearchModelList;
  List<UserSearchModel> userSearchModelList = [];
  final pdfDoc = pdf.Document();
  // String pathPDF = "";
  String pathPDF = "";
  Future<Uint8List> uint8List;
  Future<Io.File> futureFile;
  bool isPdfLoaded=false;
  String pdfBase64String;
  String accountId="";
  final _formKey = GlobalKey<FormState>();
  final txtEmailId = TextEditingController();
  // PDFDocument pDFDocument;
  var profileImage;
  @override
  void initState() {
    debugPrint('getting user details');
    super.initState();
    debugPrint('doctorModel=$doctorModel');
    if(doctorModel!=null){
      debugPrint('doctorModel=${doctorModel.id}');
      accountId=doctorModel.id;
    }
    if(businessModel!=null){
      accountId=businessModel.id;
      debugPrint('businessModel id=${businessModel.id}');
    }

    uint8List=previewPdf(context,doctorModel,businessModel);
    uint8List.then((value) => futureFile=getBase64StrPdf(value, context));
  }

  Future<Uint8List> previewPdf(BuildContext context,DoctorsAccountDetailsModel doctorModel,BusinessAccountDetailsModel businessModel) async{
    profileImage = pdf.MemoryImage(
      (await rootBundle.load('assets/images/icon.png')).buffer.asUint8List(),
    );
    pdfDoc.addPage(
      pdf.MultiPage(
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _contentHeader(context,doctorModel),
          pdf.SizedBox(height: 5),
          accountType==CommonConstant.ACCOUNT_DOCTOR?_doctorContentTable(context,doctorModel)
              :_businessContentTable(context, businessModel),
        ],
      ),
    );
    return pdfDoc.save();
  }
  pdf.Widget _businessContentTable(pdf.Context context,BusinessAccountDetailsModel businessModel){

    String companyTitle="";
    String companyName="";
    String ownerNameTitle="";
    String companyOwnerName="";
    String representativeNameTitle="";
    String representativeName="";
    String ownerGender="";
    String representativeGender="";
    if(businessModel.companyTitle!=null){
      companyTitle=CommonUtil.convertToTitleCase(businessModel.companyTitle);
    }
    if(businessModel.companyName!=null){
      companyName=CommonUtil.convertToTitleCase(businessModel.companyName);
    }
    if(businessModel.ownerNameTitle!=null){
      ownerNameTitle=CommonUtil.convertToTitleCase(businessModel.ownerNameTitle);
    }
    if(businessModel.companyOwnerName!=null){
      companyOwnerName=CommonUtil.convertToTitleCase(businessModel.companyOwnerName);
    }

    if(businessModel.representativeNameTitle!=null){
      representativeNameTitle=CommonUtil.convertToTitleCase(businessModel.representativeNameTitle);
    }
    if(businessModel.representativeName!=null){
      representativeName=CommonUtil.convertToTitleCase(businessModel.representativeName);
    }

    if(!CommonUtil.isBlank(businessModel.ownerGender) && businessModel.ownerGender=="M"){
      ownerGender="Male";
    }
    if(!CommonUtil.isBlank(businessModel.ownerGender) && businessModel.ownerGender=="F"){
      ownerGender="Female";
    }
    if(!CommonUtil.isBlank(businessModel.ownerGender) && businessModel.ownerGender=="T"){
      ownerGender="Transgender";
    }

    if(!CommonUtil.isBlank(businessModel.representativeGender) && businessModel.representativeGender=="M"){
      representativeGender="Male";
    }
    if(!CommonUtil.isBlank(businessModel.representativeGender) && businessModel.representativeGender=="F"){
      representativeGender="Female";
    }
    if(!CommonUtil.isBlank(businessModel.representativeGender) && businessModel.representativeGender=="T"){
      representativeGender="Transgender";
    }

    return pdf.Table.fromTextArray(headerCount: 0,context: context, data: <List<String>>[
      <String>['Company Name', companyName+' '+companyTitle ],
      <String>['Company Email-ID', !CommonUtil.isBlank(businessModel.emailId)?businessModel.emailId:'-' ],
      <String>['Other Email-ID', !CommonUtil.isBlank(businessModel.otherEmailId)?businessModel.otherEmailId:'-' ],
      <String>['Contact No.', !CommonUtil.isBlank(businessModel.contactNo)?businessModel.contactNo:'-' ],
      <String>['Whatsapp No.', !CommonUtil.isBlank(businessModel.whatsappNo)?businessModel.whatsappNo:'-' ],
      <String>['Other Contact No.', !CommonUtil.isBlank(businessModel.otherContactNo)?businessModel.otherContactNo:'-' ],
      <String>['Owner Name', ownerNameTitle+' '+companyOwnerName ],
      <String>['Owner Gender', ownerGender ],
      <String>['Owner Religion', !CommonUtil.isBlank(businessModel.ownerReligion)?businessModel.ownerReligion:'-' ],
      <String>['Owner Nationality', !CommonUtil.isBlank(businessModel.ownerNationality)?businessModel.ownerNationality:'-' ],
      <String>['Owner Detail', !CommonUtil.isBlank(businessModel.ownerDetail)?businessModel.ownerDetail:'-' ],
      <String>['Representative Name', representativeNameTitle+' '+representativeName ],
      <String>['Representative Gender', representativeGender ],
      <String>['Pincode', !CommonUtil.isBlank(businessModel.zipCode)?businessModel.zipCode:'-' ],
      <String>['city', CommonUtil.convertToTitleCaseReturnDash(businessModel.city) ],
      <String>['state', CommonUtil.convertToTitleCaseReturnDash(businessModel.state) ],
      <String>['Landmark', CommonUtil.convertToTitleCaseReturnDash(businessModel.landmark) ],
      <String>['Office Address', CommonUtil.convertToTitleCaseReturnDash(businessModel.registOfficeAdd) ],
      <String>['Aadhar No.', !CommonUtil.isBlank(businessModel.aadharNo)?businessModel.aadharNo:'-'  ],
      <String>['Pan No.', !CommonUtil.isBlank(businessModel.panNo)?businessModel.panNo:'-'  ],
      <String>['Experienc Establishment(Yr.)', !CommonUtil.isBlank(businessModel.experiencEstablishment)?businessModel.experiencEstablishment:'-'  ],
      <String>['T&C Accepted', !CommonUtil.isBlank(businessModel.tncAccepted)?businessModel.tncAccepted:'-'  ],
    ]);
  }
  pdf.Widget _doctorContentTable(pdf.Context context,DoctorsAccountDetailsModel doctorModel){

    String nameTitle="";
    String firstName="";
    String lastName="";
    String gender="";
    if(doctorModel.nameTitle!=null){
      nameTitle=CommonUtil.convertToTitleCase(doctorModel.nameTitle);
    }
    if(doctorModel.firstName!=null){
      firstName=CommonUtil.convertToTitleCase(doctorModel.firstName);
    }
    if(doctorModel.lastName!=null){
      lastName=CommonUtil.convertToTitleCase(doctorModel.lastName);
    }
    if(!CommonUtil.isBlank(doctorModel.gender) && doctorModel.gender=="M"){
      gender="Male";
    }
    if(!CommonUtil.isBlank(doctorModel.gender) && doctorModel.gender=="F"){
      gender="Female";
    }
    if(!CommonUtil.isBlank(doctorModel.gender) && doctorModel.gender=="T"){
      gender="Transgender";
    }

    return pdf.Table.fromTextArray(headerCount: 0,context: context, data: <List<String>>[
      <String>['Name', nameTitle+' '+firstName+' '+lastName ],
      <String>['Gender', gender],
      <String>['Email-ID', doctorModel.emailId!=null?doctorModel.emailId:'-',],
      <String>['Contact No.', doctorModel.contactNo!=null?doctorModel.contactNo:'-', ],
      <String>['WhatsApp No.', doctorModel.whatsappNo!=null?doctorModel.whatsappNo:'-', ],
      <String>['Emergency Contact No.', doctorModel.emergencyNo!=null?doctorModel.emergencyNo:'-', ],
      <String>['Marital Status', CommonUtil.convertToTitleCaseReturnDash(doctorModel.maritalStatus), ],
      <String>['Religion', CommonUtil.convertToTitleCaseReturnDash(doctorModel.religion), ],
      <String>['Mother Name', CommonUtil.convertToTitleCaseReturnDash(doctorModel.motherName), ],
      <String>['Father Name', CommonUtil.convertToTitleCaseReturnDash(doctorModel.fatherName), ],
      <String>['Husband/Wife Name', CommonUtil.convertToTitleCaseReturnDash(doctorModel.wifeHusbandName), ],
      <String>['Practicing As', CommonUtil.convertToTitleCaseReturnDash(doctorModel.practicingAs), ],
      <String>['Practicing', CommonUtil.convertToTitleCaseReturnDash(doctorModel.practicing), ],
      <String>['Blood Group', CommonUtil.convertToTitleCaseReturnDash(doctorModel.bloodGroup), ],
      <String>['Date Of Birth', doctorModel.dob!=null?doctorModel.dob:'-', ],
      <String>['City', CommonUtil.convertToTitleCaseReturnDash(doctorModel.city), ],
      <String>['State', CommonUtil.convertToTitleCaseReturnDash(doctorModel.state), ],
      <String>['Country', CommonUtil.convertToTitleCaseReturnDash(doctorModel.country), ],
      <String>['Pin Code', doctorModel.zipCode!=null?doctorModel.zipCode:'-', ],
      <String>['Permanent Address', CommonUtil.convertToTitleCaseReturnDash(doctorModel.permanentAddress), ],
      <String>['Office Address', CommonUtil.convertToTitleCaseReturnDash(doctorModel.registOfficeAdd), ],
      <String>['Experienc Establishment (Year)', doctorModel.experiencEstablishment!=null?doctorModel.experiencEstablishment:'-', ],
      <String>['Nationality', CommonUtil.convertToTitleCaseReturnDash(doctorModel.nationality), ],
      <String>['Account Create Date', doctorModel.createDate!=null?doctorModel.createDate:'-', ],
      <String>['Aadhar No.', doctorModel.aadharNo!=null?doctorModel.aadharNo:'-', ],
      <String>['Pan No.', doctorModel.panNo!=null?doctorModel.panNo:'-', ],
      <String>['Reference', !CommonUtil.isBlank(doctorModel.reference)?doctorModel.reference:'-', ],
      <String>['Account Status', doctorModel.status!=null?doctorModel.status:'-', ],
    ]);
  }
  pdf.Widget _buildHeader(pdf.Context context){
    DateFormat outputFormat =new DateFormat('dd/MMM/yyyy hh:mm');
    return pdf.Column(
      children: [
        pdf.Row(
          crossAxisAlignment: pdf.CrossAxisAlignment.start,
          children: [
            pdf.Expanded(
              child: pdf.Column(
                children: [
                  pdf.Container(
                    padding: const pdf.EdgeInsets.only(left: 1),
                    alignment: pdf.Alignment.topLeft,
                    child: pdf.Text(
                      'Date Time : '+ outputFormat.format(DateTime.now()),
                      style: pdf.TextStyle(
                        fontWeight: pdf.FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pdf.Expanded(
              child: pdf.Column(
                mainAxisSize: pdf.MainAxisSize.min,
                children: [
                pdf.Container(
                padding: const pdf.EdgeInsets.only(right: 1),
                alignment: pdf.Alignment.topRight,
                child: pdf.Text('AMPAMT Customer Account Details',
                  style: pdf.TextStyle(
                    fontWeight: pdf.FontWeight.bold,
                    fontSize: 10,
                    ),
                  ),
                ),
                ],
              ),
            ),

          ],
        ),
        pdf.Row(
          crossAxisAlignment: pdf.CrossAxisAlignment.center,
          mainAxisAlignment: pdf.MainAxisAlignment.center,
          children: [
            pdf.Expanded(
              child: pdf.Container(
                width: 80,
                height: 80,
                child: pdf.Image(profileImage),
              ),
            ),
          ],
        )
      ],
    );
  }
  // pdf.Widget _buildHeaderLogo(pdf.Context context,final profileImage) {
  //   return pdf.Row(
  //     crossAxisAlignment: pdf.CrossAxisAlignment.center,
  //     mainAxisAlignment: pdf.MainAxisAlignment.center,
  //     children: [
  //     pdf.Expanded(
  //       child: pdf.Container(
  //         width: 100,
  //         height: 100,
  //         child: pdf.Image(profileImage),
  //       ),
  //   ),
  //     ],
  //   );
  // }
  pdf.Widget _buildFooter(pdf.Context context) {
    return pdf.Column(
      children: [
        pdf.Row(
          // crossAxisAlignment: pdf.CrossAxisAlignment.start,
          children: [
            pdf.Expanded(
              child: pdf.Column(
                children: [
                  pdf.Container(
                    alignment: pdf.Alignment.bottomLeft,
                    child: pdf.Text(
                      'In case of any related query or issue please feel free to contact us on '
                          '${CommonConstant.AMPAMT_CONTACTNO} or visit www.ampamt.com',
                      style: pdf.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  pdf.Widget _contentHeader(pdf.Context context,DoctorsAccountDetailsModel doctorModel) {
    debugPrint('preview pdf 2');
    return  pdf.Column(
      children: [
        pdf.Row(
          // crossAxisAlignment: pdf.CrossAxisAlignment.start,
          children: [
            pdf.Expanded(
              child: pdf.Column(
                children: [
                  pdf.Container(
                    padding: const pdf.EdgeInsets.only(top: 10),
                    alignment: pdf.Alignment.topLeft,
                    child: pdf.Text(
                      'Unique Account ID : '+accountId,
                      style: pdf.TextStyle(
                        fontWeight: pdf.FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<Io.File> getBase64StrPdf(Uint8List uint8List,BuildContext context) async{
    String base64Image=CommonConstant.START_OF_PDF_JSON+base64Encode(uint8List);
    debugPrint('base64Image=$base64Image');
    String path= await CommonUtil.createFolderInAppDocDirStr('tempPdf',base64Image,"ACCOUNT",null,".pdf");
    Io.File file2 = Io.File(path);
    // PDFDocument doc = await PDFDocument.fromFile(file2);
    setState(() {
      // pDFDocument=doc;
      pathPDF=path;
      isPdfLoaded=true;
      pdfBase64String=base64Image;

    });
    debugPrint('path final3=$path');
    return file2;
  }
  void savePdfToStorage(BuildContext context,String accountId,String accountType) async{
    // String base64Image=CommonConstant.START_OF_PDF_JSON+base64Encode(uint8List);
    debugPrint('pdfBase64String=$pdfBase64String');
    String savedPath= await CommonUtil.createFolderInAppDocDirStr(accountId,pdfBase64String,"ACCOUNT/$accountType",null,".pdf");
    if(!CommonUtil.isBlank(savedPath)){
      showSnackBar(context, 'File saved at >> $savedPath', Colors.green, Colors.white,3000);
    }else{
      showSnackBar(context, 'Failed to save', Colors.red, Colors.white,1000);
    }
    debugPrint('saved status=$savedPath');
    // return file2;
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
            Image.asset('assets/images/dashboard/app/26.png', width: 40, height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Account Details',
                  style: TextStyle(fontSize: screenWidth / 20),
                ))
          ],
        ),
      ),
      body: Center(
        child:Container(

        child:FutureBuilder(
            future: uint8List,
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
                  return buildActionTiles(snapshot.data);
                }else{
                  return CommonUtil.getEmptyMsg("Details not found", context);
                }
              }
            }
        ),
      ),
    )

    );
  }

  showSnackBar(BuildContext context, String msg, Color bgcolor, Color txtColor,int duration) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: duration),
        content: Text(
          msg,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgcolor,
      ));
    });
  }

  Widget buildActionTiles(Uint8List data) {

   return  Container(
     child:Column(
       children: [
         Row(
           children: [

             // Container(
             //
             //   child: Center(
             //     child: Column(
             //         mainAxisAlignment: MainAxisAlignment.center,
             //         children: <Widget>[
             //           TextButton(onPressed: () {
             //
             //             printPdfFile(pathPDF);
             //           },
             //               child: Image.asset('assets/images/dashboard/app/8.png',width: screenWidth / 10, height: screenWidth / 10,)
             //           ),
             //
             //
             //         ]),
             //   ),
             // ),
             Container(

               child: Center(
                 child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       TextButton(onPressed: () {
                         savePdfToStorage(context, accountId, accountType);
                       },
                           child: Image.asset('assets/images/home/upload-doc.png',width: screenWidth / 10, height: screenWidth / 10,)
                       ),


                     ]),
               ),
             ),
             Container(

               child: Center(
                 child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       TextButton(onPressed: () {
                         showTextBoxDialog(context);
                         // sendDocumentsMail(context, documentReqBody);
                       },
                           child: Image.asset('assets/images/support/email.png',width: screenWidth / 10, height: screenWidth / 10,)
                       ),


                     ]),
               ),
             ),
           ],
         ),
         Expanded(
           child: isPdfLoaded?PDFView(
             filePath: pathPDF,
             enableSwipe: true,
             swipeHorizontal: false,
             autoSpacing: false,
             pageFling: true,
             pageSnap: true,
             defaultPage: currentPage,
             fitPolicy: FitPolicy.BOTH,
             preventLinkNavigation: false, // if set to true the link is handled in flutter
             onRender: (_pages) {
               setState(() {
                 pages = _pages;
                 isReady = true;
               });
             },
             onError: (error) {
               setState(() {
                 errorMessage = error.toString();
               });
               debugPrint(error.toString());
             },
             onPageError: (page, error) {
               setState(() {
                 errorMessage = '$page: ${error.toString()}';
               });
               debugPrint('$page: ${error.toString()}');
             },
             onViewCreated: (PDFViewController pdfViewController) {
               _controller.complete(pdfViewController);
             },
             onLinkHandler: (String uri) {
               debugPrint('goto uri: $uri');
             },
             onPageChanged: (int page, int total) {
               debugPrint('page change: $page/$total');
               setState(() {
                 currentPage = page;
               });
             },
           ):CommonUtil.showLoading("Loading Account Details...", context),
           // errorMessage.isEmpty ? Container(child: Text(""),) : Container(child: Text(errorMessage),),
           //   errorMessage.isEmpty?
         ),
         // Expanded(
         //   child:  isPdfLoaded?PDFViewer(document: pDFDocument):CommonUtil.showLoading("Loading file...", context),
         // )
        // isPdfLoaded?PDFViewer(document: pDFDocument):CommonUtil.showLoading("Loading...", context)
         errorMessage.isEmpty?Container(child: Text(""),) : Container(child: Text(errorMessage),)
       ],
     ),
   );
  }
  void printPdfFile(String path) async {
    debugPrint('path toprint file=$path');

  }
  void showTextBoxDialog(BuildContext context) {
     showDialog(

      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Dialog(

          backgroundColor: CompanyStyle.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding:EdgeInsets.all(10),
            child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: txtEmailId,
                          validator: (value) {
                            if (value.isEmpty) {
                              return null;
                            }
                            if (!CommonUtil.isBlank(value) && !CommonUtil.isValidEmail(value)) {
                              return 'Please enter valid email-Id';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            suffixIcon: TextButton(onPressed: (){

                              debugPrint('sending email data');
                              _formKey.currentState.save();
                              Map<String, dynamic> documentReqBody = new Map<String, String>();
                              documentReqBody={
                                "base64String":pdfBase64String,
                                "fileExtension":CommonConstant.PDF_EXTENSION,
                                "userId":accountId,
                                "emailId":txtEmailId.text
                              };
                              if (_formKey.currentState.validate()) {
                                sendDocumentsMail(context, documentReqBody);
                              }else{
                                debugPrint('please fill all the required details');
                              }
                              debugPrint('txtEmailId=${txtEmailId.text}');


                            },
                              child: Icon(Icons.send,color: Colors.green,), ),
                            labelText: "Enter Email-ID",
                            labelStyle: TextStyle(
                                color: Colors.white, fontSize: screenWidth / 25),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white, width: 0.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white, width: 0.5),
                            ),
                            alignLabelWithHint: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]


            ),
          ),
        );
      },
    );
  }
  void sendDocumentsMail(BuildContext context, Map<String, dynamic> documentReqBody) async{
    ApiProvider _provider = new ApiProvider();
    showProgressIndicator("Sending please wait...");
    SuccessModel successModel;
    try {
      final response = await _provider.post("/email-service/send-pdfdata-email", documentReqBody);
      dismissProgressIndicator();
      successModel = SuccessModel.fromJson(response);
      if (successModel != null) {
        if (successModel.status == CommonConstant.STATUS_SUCCESS) {
          showSnackBar(context, 'Details sent successfully', Colors.green, Colors.white,1000);
          Navigator.of(context).pop(true);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorLogin()));
        } else if (successModel.status == CommonConstant.STATUS_FAILED) {
          showSnackBar(
              context, 'Failed to send details, please try again.', Colors.red, Colors.white,2000);
        } else {
          showSnackBar(
              context, 'Failed to send details, please try again.', Colors.red, Colors.white,2000);
        }
      }else{
        showSnackBar(
            context, 'Something went wrong please try again.', Colors.red, Colors.white,2000);
      }
    } catch (e) {
      dismissProgressIndicator();
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white,2000);
    }
  }
}