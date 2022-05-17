import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
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

class DoctorDocumentDetails extends StatefulWidget{
  final String accountId;
  DoctorDocumentDetails({Key key, this.accountId}) : super(key: key);
  @override
  _DoctorDocumentUploadState createState()=>_DoctorDocumentUploadState();

}
class _DoctorDocumentUploadState extends State<DoctorDocumentDetails>{
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
            Image.asset('assets/images/home/doctor_login.png',width: 40,height: 40),
            Container(
                padding: const EdgeInsets.all(10.0), child: Text('Doctor Documents')
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
  Future<List<DoctorDocumentsModel>> doctorDocumentsModelListFuture;
  List<DoctorDocumentsModel> doctorDocumentsModelList=[];
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
    doctorDocumentsModelListFuture=getDoctorDocumentsDetails(context);
    doctorDocumentsModelListFuture.then((value) => {
      doctorDocumentsModelList=value,
      imageUploadModel=new ImageUploadModel(),
      setState((){
        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='profilePic';
        imageUploadModel.imageTitle='Profile Pic';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].profilePicB64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='aadharImage';
        imageUploadModel.imageTitle='Aadhar Card';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].aadharImgBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='aadharBackImage';
        imageUploadModel.imageTitle='Aadhar Card Back';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].aadharBackImgBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='panFrontImage';
        imageUploadModel.imageTitle='Pan Card Front';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].panFrontImgBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='panBackImage';
        imageUploadModel.imageTitle='Pan Card Back';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].panBackImgBase64;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='qualiCertificate1';
        imageUploadModel.imageTitle='Qualification Certificate 1';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].qualiCertificate1B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='qualiCertificate2';
        imageUploadModel.imageTitle='Qualification Certificate 2';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].qualiCertificate2B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='qualiCertificate3';
        imageUploadModel.imageTitle='Qualification Certificate 3';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].qualiCertificate3B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='qualiCertificate4';
        imageUploadModel.imageTitle='Qualification Certificate 4';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].qualiCertificate4B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='qualiCertificate5';
        imageUploadModel.imageTitle='Qualification Certificate 5';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].qualiCertificate5B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='qualiCertificate6';
        imageUploadModel.imageTitle='Qualification Certificate 6';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].qualiCertificate6B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='rampCertificate';
        imageUploadModel.imageTitle='Ramp Certificate';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].rampCertificateB64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='profCertificate';
        imageUploadModel.imageTitle='Professional Certificate';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].profCertificateB64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='medicalCouncil';
        imageUploadModel.imageTitle='Medical Council';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].medicalCouncilB64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='healthDepCertificate';
        imageUploadModel.imageTitle='Health Department Cert.';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].healthDepCertificateB64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='ayushDepRegistration';
        imageUploadModel.imageTitle='Ayush Dep. Registration.';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].ayushDepRegistrationB64Img;
        images.add(imageUploadModel);


        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='otherLicCertificate1';
        imageUploadModel.imageTitle='Other License Certificate 1';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].otherLicCertificate1B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='otherLicCertificate2';
        imageUploadModel.imageTitle='Other License Certificate 2';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].otherLicCertificate2B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='otherLicCertificate3';
        imageUploadModel.imageTitle='Other License Certificate 3';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].otherLicCertificate3B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='professionalWorkimg1';
        imageUploadModel.imageTitle='Professional Working 1';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].professionalWorkimg1B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='professionalWorkimg2';
        imageUploadModel.imageTitle='Professional Working 2';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].professionalWorkimg2B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='professionalWorkimg3';
        imageUploadModel.imageTitle='Professional Working 3';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].professionalWorkimg3B64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='signature';
        imageUploadModel.imageTitle='Signature';
        imageUploadModel.isImageReq=true;
        imageUploadModel.imageFile=doctorDocumentsModelList[0].signatureB64Img;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Website Link';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=doctorDocumentsModelList[0].websiteLink;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Facebook Link';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=doctorDocumentsModelList[0].facebookLink;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Instagram Link';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=doctorDocumentsModelList[0].instagramLink;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='YouTube Link';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=doctorDocumentsModelList[0].youtubeLink;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Twitter Link';
        imageUploadModel.isLink=true;
        imageUploadModel.textContent=doctorDocumentsModelList[0].twitterLink;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Experience Comments';
        imageUploadModel.isLink=false;
        imageUploadModel.textContent=doctorDocumentsModelList[0].experienceComments;
        imageUploadModel.isTextRequired=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.isText=true;
        imageUploadModel.textTitle='Achievements Comments';
        imageUploadModel.isLink=false;
        imageUploadModel.textContent=doctorDocumentsModelList[0].achievementsComments;
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
  Future<List<DoctorDocumentsModel>> getDoctorDocumentsDetails( BuildContext context) async{
    ApiProvider _provider = new ApiProvider();
    try {
      reqBody['id']=widget.accountId;
      final response = await _provider.post("/account/get-doc-document-detail",reqBody);
      doctorDocumentsModelList = (response as List).map((data) => DoctorDocumentsModel.fromJson(data)).toList();
      setState(() {
        // totalDoctorList = doctorDocumentsModelList.length;
      });
    } catch (e) {
      debugPrint('error at display page='+e.toString().toString());
      // final snackBar =normalSnackBar(e.toString().toString(), Colors.red,  Colors.white);
      // _scaffoldKey.currentState.showSnackBar(snackBar);
      showSnackBar(context, e.toString(), Colors.red, Colors.white,1000);
    }
    return doctorDocumentsModelList;
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
                      future: doctorDocumentsModelListFuture,
                      builder: (context,AsyncSnapshot snapshot){
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return CommonUtil.showLoading("Loading Documents...", context);
                          default:
                            if (snapshot.hasError)
                              return new Text('Error: ${snapshot.error}');
                            else
                              return buildGridView();
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
          if(uploadModel.imageFile !=null && uploadModel.imageFile!=""){
            file = uploadModel.imageFile;
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
                            builder: (_) => viewImage(rm.imageFile,context)
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
                        await downloadImage(rm.imageName,rm.imageFile,context);
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