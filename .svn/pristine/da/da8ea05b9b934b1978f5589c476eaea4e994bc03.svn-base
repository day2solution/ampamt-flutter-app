import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/model/business/BusinessDocumentUploadModel.dart';
import 'package:ampamt/model/doctor/DoctorDocumentsModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io' as Io;
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessDocumentDetails extends StatefulWidget{
  final String accountId;
  BusinessDocumentDetails({Key key, this.accountId}) : super(key: key);
  @override
  _BusinessDocumentDetailsState createState()=>_BusinessDocumentDetailsState();

}
class _BusinessDocumentDetailsState extends State<BusinessDocumentDetails>{
  // static MediaQueryData _mediaQueryData;
  // static double screenWidth;
  // static double screenHeight;

  @override
  Widget build(BuildContext context) {
    // _mediaQueryData = MediaQuery.of(context);
    // screenWidth = _mediaQueryData.size.width;
    // screenHeight = _mediaQueryData.size.height;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title:  Row(
          children: [
            Image.asset('assets/images/home/business_login.png',width: 40,height: 40),
            Container(
                padding: const EdgeInsets.all(10.0), child: Text('Business Documents')
            )
          ],
        ),
      ),

      body:DoctorDocumentDetailsStateForm(accountId: widget.accountId,),

    );
  }

  getButtonStyle(){
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      primary:CompanyStyle.primaryColor,

    );

  }
}
class DoctorDocumentDetailsStateForm extends StatefulWidget {
  final String accountId;
  DoctorDocumentDetailsStateForm({Key key, this.accountId}) : super(key: key);
  @override
  _DoctorDocumentDetailsStateForm createState() {
    return _DoctorDocumentDetailsStateForm();
  }
}

class _DoctorDocumentDetailsStateForm extends State<DoctorDocumentDetailsStateForm> {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  // static double screenHeight;
  // final ImagePicker _picker = ImagePicker();
  // @override
  // void initState() {
  //   super.initState();
  //
  // }
  final String uploadEndPoint =
      'http://localhost/flutter_test/upload_image.php';
  Future<PickedFile> pickedFile;
  String status = '';
  String base64Image;
  PickedFile tmpFile;
  String file;
  String errMessage = 'Error While Fetching Image';
  // PickedFile _image;
  Future<List<BusinessDocumentUploadModel>> businessDocumentsModelListFuture;
  List<BusinessDocumentUploadModel> businessDocumentsModelList=[];
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ImageUploadModel> images = [];
  ImageUploadModel imageUploadModel=new ImageUploadModel();
  PhotoViewController controller;
  Future<PickedFile> _imageFile;
  // DoctorBloc _doctorBloc=new DoctorBloc();
  String base64String="";
  Map<String, dynamic> reqBody = new Map<String, String>();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    reqBody['id']=widget.accountId;
    businessDocumentsModelListFuture=getBusinessDocumentsDetails(context);
    businessDocumentsModelListFuture.then((value) => {
      businessDocumentsModelList=value,
      imageUploadModel=new ImageUploadModel(),
      setState((){
        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='COMPLOGO';
        imageUploadModel.imageTitle='Company Logo *';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].companyLogoBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='MSME';
        imageUploadModel.imageTitle='MSME Certificate';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].msmeCertificateBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='COMPPAN';
        imageUploadModel.imageTitle='Company Pan card Image';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].companyPanBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='COMPAADHAR';
        imageUploadModel.imageTitle='Company Aadhar Card Front Image';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].companyAadharBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='COMPAADHARBACK';
        imageUploadModel.imageTitle='Company Aadhar Card Back Image';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].companyAadharBackBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='GUMASTACERT';
        imageUploadModel.imageTitle='Gumasta Certificate';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].gumastaCertificateBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='ISOCERT';
        imageUploadModel.imageTitle='ISO Certificate';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].isoCertificateBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='GSTCERT';
        imageUploadModel.imageTitle='GST Certificate';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].gstCertificateBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='COMPLIANCECERT';
        imageUploadModel.imageTitle='Compliance Certificate';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].complianceCertificateBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION1';
        imageUploadModel.imageTitle='Qualification Certificate 1';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].qualiCertificate1Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION2';
        imageUploadModel.imageTitle='Qualification Certificate 2';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].qualiCertificate2Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION3';
        imageUploadModel.imageTitle='Qualification Certificate 3';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].qualiCertificate3Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION4';
        imageUploadModel.imageTitle='Qualification Certificate 4';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].qualiCertificate4Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION5';
        imageUploadModel.imageTitle='Qualification Certificate 5';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].qualiCertificate5Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION6';
        imageUploadModel.imageTitle='Qualification Certificate 6';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64="";
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='PROFCERT';
        imageUploadModel.imageTitle='Professional Certificate';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].qualiCertificate6Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='OTHERLICCERT1';
        imageUploadModel.imageTitle='Other License/Certificate 1';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64="";
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='OTHERLICCERT2';
        imageUploadModel.imageTitle='Other License/Certificate 2';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].otherLicCertificate1Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='OTHERLICCERT3';
        imageUploadModel.imageTitle='Other License/Certificate 3';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].otherLicCertificate2Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='PROFWORK1';
        imageUploadModel.imageTitle='Professional Working 1';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].professionalWorkimg1Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='PROFWORK2';
        imageUploadModel.imageTitle='Professional Working 2';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].professionalWorkimg1Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='PROFWORK3';
        imageUploadModel.imageTitle='Professional Working 3';
        imageUploadModel.isImageReq=false;
        imageUploadModel.imageBase64=businessDocumentsModelList[0].professionalWorkimg1Base64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Website Link';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=businessDocumentsModelList[0].websiteLink;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Facebook Link';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=businessDocumentsModelList[0].facebookLink;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Instagram Link';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=businessDocumentsModelList[0].instagramLink;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='YouTube Link';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=businessDocumentsModelList[0].youtubeLink;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Twitter Link';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=businessDocumentsModelList[0].twitterLink;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='About company';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=businessDocumentsModelList[0].aboutCompany;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Details About Product';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=businessDocumentsModelList[0].detailAboutProduct;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

      }),

    });

    controller = PhotoViewController();

  }
  SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor){
    return SnackBar(
        content: Text(msg,
          style: TextStyle(color:txtColor),
        ),
        backgroundColor: bgcolor
    );
  }
  Future<List<BusinessDocumentUploadModel>> getBusinessDocumentsDetails( BuildContext context) async{
    ApiProvider _provider = new ApiProvider();
    try {
      reqBody['id']=widget.accountId;
      final response = await _provider.post("/account/get-busi-document-detail",reqBody);
      businessDocumentsModelList = (response as List).map((data) => BusinessDocumentUploadModel.fromJson(data)).toList();
      setState(() {
        // totalDoctorList = doctorDocumentsModelList.length;
      });
    } catch (e) {
      debugPrint('error at display page='+e.toString().toString());
      // final snackBar =normalSnackBar(e.toString().toString(), Colors.red,  Colors.white);
      // _scaffoldKey.currentState.showSnackBar(snackBar);
      showSnackBar(context, e.toString(), Colors.red, Colors.white,1000);
    }
    return businessDocumentsModelList;
  }
  // final ImagePicker _picker = ImagePicker();
  Widget showLoading(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(CompanyStyle.primaryColor[900]),
            ),
            height:screenWidth/ 7,
            width: screenWidth/ 7,
          ),
          SizedBox(height: 10,),
          Text('Loading Documents...',style: TextStyle(fontSize: screenWidth/20),),
        ],
      ),
    );
  }
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    // List<DoctorDocumentsModel> values = snapshot.data;
    return buildGridView();
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
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              color: CompanyStyle.primaryColor,
              child:Container(
                padding: EdgeInsets.all(10.0),
                child:  Text('User Uploaded Image Documents', style: TextStyle(fontSize: screenWidth/25)),
              ),
            ),
            Expanded(
                child: Container(
                  padding:EdgeInsets.only(top: 5,bottom: 5),
                  child:FutureBuilder(
                      future: businessDocumentsModelListFuture,
                      builder: (context,AsyncSnapshot snapshot){
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return CommonUtil.showLoading("Loading Documents...", context);
                          default:
                            if (snapshot.hasError)
                              return new Text('Error: ${snapshot.error}');
                            else{
                              if(snapshot.data!=null && snapshot.data.length>0){
                                return buildGridView();
                              }else{
                                return Text('Documents not found');
                              }
                            }

                        }
                      }
                  ),
                )
            ),

          ],
        ),
      ),
    );
    // );
  }
  void _showDialog(List<String> errorList) {
    // flutter defined function
    String error="";
    for(int i=0;i<errorList.length;i++){
      error+=(i+1).toString()+'. '+errorList[i]+'\r\n';
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: CompanyStyle.primaryColor,
          title: new Text("Error",style: TextStyle(color: Colors.red),),
          content: new Text(error),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new ElevatedButton(
              style: CompanyStyle.getButtonStyle(),
              child: new Text("Close",),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  List<String> validateImage(){
    List<String> errorList=[];
    // String error="";
    for(int i=0;i<images.length;i++){
      if(images[i].isImageReq){
        if(images[i].imageFile==null){
          if(images[i].imageName=='profilePic'){
            errorList.add('Please Upload Profile Image');
          }

          if(images[i].imageName=='pancard'){
            errorList.add('Please Upload Pan Card');
          }
        }


      }
    }
    if(errorList.length>0){
      _showDialog(errorList);
    }
    debugPrint('errorList='+errorList.toString());

    return errorList;
  }
  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          if(!CommonUtil.isBlank(uploadModel.imageBase64) && uploadModel.imageBase64.length>10){
            file = uploadModel.imageBase64;
            return Card(
              color: CompanyStyle.primaryColor[200],
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  Container(
                    child: CommonUtil.getImageFromBase64FillSize(file,context),
                    // width: double.infinity,
                    // height: double.infinity,
                  ),

                  Positioned(
                    right: 5,
                    top: 5,
                    child: InkWell(
                      focusColor:CompanyStyle.primaryColor[800],
                      child: Icon(
                        Icons.remove_red_eye,
                        size: screenWidth/15,
                        color: Colors.blue,
                      ),
                      onTap:  () async {
                        ImageUploadModel rm = images[index];
                        await showDialog(
                            context: context,
                            builder: (_) => viewImage(rm.imageBase64,context)
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 40,
                    top: 5,
                    child: InkWell(
                      focusColor:CompanyStyle.primaryColor[800],
                      child: Icon(
                        Icons.download_sharp,
                        size: screenWidth/15,
                        color: Colors.red,
                      ),
                      onTap:  () async {
                        ImageUploadModel rm = images[index];
                        await downloadImage(rm.imageName,rm.imageBase64,context);
                      },
                    ),
                  ),
                  Positioned(
                      bottom: 1,
                      left: 1,
                      child:Card(
                          color: CompanyStyle.primaryColor[200],
                          child:Text(uploadModel.imageTitle,style: TextStyle(fontWeight: FontWeight.bold),)
                      )
                  ),
                ],
              ),
            );
          }
          else if(uploadModel.isText){
            return Card(
              child: Container(
                  padding:  EdgeInsets.all(5),
                  child:ListView(
                      primary: false,
                      children:<Widget>[
                        Text(uploadModel.textTitle!=null?uploadModel.textTitle:""),
                        SizedBox(
                          height: screenWidth/30,
                        ),
                        RichText(
                          text:TextSpan(
                            text: uploadModel.textContent!=null?uploadModel.textContent:"-",
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()..onTap = () => {

                              launchURL(uploadModel.textContent,uploadModel.isLink)
                              // FlutterPhoneDirectCaller.callNumber(doctorAccountStatusModel.whatsappNo)
                            },
                          ),
                        ),
                      ]
                  )
              ),
            );
          }
          else{
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  Container(
                    child: CommonUtil.getImageFromBase64FillSize(null,context),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                      bottom: 1,
                      left: 1,
                      child:Card(
                          color: CompanyStyle.primaryColor[200],
                          child:Text(uploadModel.imageTitle,style: TextStyle(fontWeight: FontWeight.bold),)
                      )
                  ),
                ],
              ),
            );
          }

        }
        else{
          return Card(
              child: Column( // Replace with a Row for horizontal icon + text
                children: <Widget>[

                  Text("Something Went Wrong")
                ],
              )
          );
        }
      },
      ),

    );
  }
  launchURL(String url,bool isLink) async {
    debugPrint('url =$url');
    if(isLink && url!=null){
      debugPrint('launching');
      if (!url.contains('http')) url = 'https://$url';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }else{
      debugPrint('not a url');
    }

  }
  viewImage(String pfile,BuildContext context) {
    // file = File(pfile.path);
    return Dialog(
      backgroundColor:Colors.transparent,
      child:InteractiveViewer(
        panEnabled: false,
        minScale: 0.5,
        maxScale: 10,
        child:CommonUtil.getImageFromBase64OriginalSize(pfile,context),),
    );
  }
  downloadImage(String fileName,String base64ImgFile,BuildContext context) async{
    // file = File(pfile.path);
    debugPrint('download called');
    bool saveStatus=await CommonUtil.createFolderInAppDocDir(fileName,base64ImgFile,"IMAGES",widget.accountId,".jpg");
    if(saveStatus){
      showSnackBar(context, 'Saved', Colors.green, Colors.white,200);
    }else{
      showSnackBar(context, 'Failed', Colors.red, Colors.white,200);
    }
  }



  // _imgFromCamera(int index) async {
  //   _imageFile =  _picker.getImage(source: ImageSource.camera);
  //   setState(() {
  //     getFileImage(index);
  //   });
  // }
  void getFileImage(int index) async {
    ImageUploadModel model1 = images[index];
    _imageFile.then((file) async {
      final bytes = Io.File(file.path).readAsBytesSync();
      String img64 =CommonConstant.START_OF_IMAGE_BASE64+ base64Encode(bytes);
      debugPrint('base64='+img64);
      setState(() {
        base64String=img64;
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = img64;
        imageUpload.isImageReq=model1.isImageReq;
        imageUpload.imageTitle=model1.imageTitle;
        imageUpload.imageUrl = model1.imageUrl;
        imageUpload.imageName = model1.imageName;
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }


}
class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  bool isImageReq;
  String imageFile;
  String imageTitle;
  String imageUrl;
  String imageName;
  String textTitle;
  String textContent;
  String imageBase64;
  bool isText;
  bool isLink;
  bool isTextRequired;

  ImageUploadModel({
    this.isUploaded=false,
    this.uploading=false,
    this.isImageReq=false,
    this.imageFile,
    this.imageTitle,
    this.imageUrl,
    this.imageName,
    this.textTitle,
    this.textContent,
    this.imageBase64,
    this.isText=false,
    this.isLink=false,
    this.isTextRequired=false
  });
}
class ImageDialog extends StatelessWidget {
  final PickedFile imageFile;
  ImageDialog({Key key, this.imageFile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: PhotoView(

        imageProvider:AssetImage(imageFile.path),

      ),
    );
  }
}