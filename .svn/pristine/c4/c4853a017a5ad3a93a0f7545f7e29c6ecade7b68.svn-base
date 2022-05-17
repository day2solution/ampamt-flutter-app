import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/loadingindicator/BarProgressIndicator.dart';
import 'package:ampamt/model/doctor/DoctorDocumentsModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class EditDoctorDocumentsDetails extends StatefulWidget{
  EditDoctorDocumentsDetails({Key key, this.accountId}) : super(key: key);
  final String accountId;
  @override
  _EditDoctorDocumentsDetailsState createState()=>_EditDoctorDocumentsDetailsState(accountId:accountId );

}
class _EditDoctorDocumentsDetailsState extends State<EditDoctorDocumentsDetails> {
  _EditDoctorDocumentsDetailsState({this.accountId}) ;
  final String accountId;
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;

  String status = '';
  String base64StrImage="";
  PickedFile tmpFile;
  File file;
  String errMessage = 'Error Uploading Image';

  List<ImageUploadModel> images = [];
  ImageUploadModel imageUploadModel=new ImageUploadModel();
  PhotoViewController controller;
  Future<XFile> _imageFile;
  final _formKey = GlobalKey<FormState>();
  final websiteLink = TextEditingController();
  final facebookLink = TextEditingController();
  final instagramLink = TextEditingController();
  final youtubeLink = TextEditingController();
  final twitterLink = TextEditingController();
  final achievementsComments = TextEditingController();
  final experienceComments = TextEditingController();
  bool isDataProcessed=false;

  Future<List<DoctorDocumentsModel>> doctorDocumentsModelFutureList;

  List<DoctorDocumentsModel> doctorDocumentsModelList=[];
  DoctorDocumentsModel doctorDocumentsModel;
  Map<String, dynamic> documentReqBody = new Map<String, String>();
  @override
  void initState() {
    print('documentupload page accountId=$accountId');
    // TODO: implement initState
    super.initState();
    controller = PhotoViewController();
    doctorDocumentsModelFutureList=getDoctorDocuments(context);

    getDocumentsReady();


  }
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CompanyStyle.primaryColor,
          title:  Row(
            children: [
              Image.asset('assets/images/home/upload-doc.png',width: 40,height: 40),
              Container(
                  padding: const EdgeInsets.all(10.0), child: Text('Upload Documents')
              )
            ],
          ),
        ),
        body:Container(
          child:Center(
              child:FutureBuilder(
                  future: doctorDocumentsModelFutureList,
                  builder: (context,AsyncSnapshot snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return showLoading();
                    }
                    else if(snapshot.hasError){
                      print('error at haserror');
                      return Text('Error occurred');
                    }
                    else{
                      if(snapshot.data!=null && snapshot.data.length>0){
                        return buildDoctorsDocumentsTiles(snapshot.data);
                      }else{
                        return CommonUtil.getEmptyMsg("Details not found",context);
                      }
                    }
                  }
              )
          ),
        ),
      );
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
        return AlertDialog(
          scrollable: true,
          backgroundColor: CompanyStyle.primaryColor,
          title: new Text("Please Upload Following Required Images",style: TextStyle(color: Colors.red,fontSize: screenWidth/30),),
          content: new Text(error,style: TextStyle(fontSize: screenWidth/25)),
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
        if(CommonUtil.isBlank(images[i].imageBase64)){
          errorList.add('Please Upload ${images[i].imageTitle}');
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
          // debugPrint(images[index]);
          ImageUploadModel uploadModel = images[index];
          debugPrint('uploadModel in loop='+uploadModel.imageName);
          if(uploadModel.imageFile is PickedFile){
            file = File(uploadModel.imageFile.path);
            return Card(
              color: CompanyStyle.primaryColor[200],
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  Image.file(
                    file,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                    alignment : Alignment.center,
                    repeat: ImageRepeat.noRepeat,
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: InkWell(
                      focusColor:CompanyStyle.primaryColor[800],

                      child: Icon(
                        Icons.delete_forever,
                        size: screenWidth/15,
                        color: Colors.red,
                      ),
                      onTap: () {
                        setState(() {
                          ImageUploadModel rm = images[index];
                          debugPrint('removing imageName='+rm.imageName);
                          // debugPrint(screenWidth);
                          rm.imageFile=null;
                          images.replaceRange(index, index + 1, [rm]);
                          debugPrint('index='+index.toString());
                        });
                      },
                    ),
                  ),
                  Positioned(
                    right: 60,
                    top: 5,
                    child: InkWell(
                      focusColor:CompanyStyle.primaryColor[800],

                      child: Icon(
                        Icons.remove_red_eye,
                        size: screenWidth/15,

                      ),
                      onTap:  () async {
                        ImageUploadModel rm = images[index];
                        await showDialog(
                            context: context,
                            builder: (_) => viewImage(rm.imageFile)
                        );
                      },
                    ),
                  ),
                  Positioned(
                      bottom: 1,
                      left: 1,
                      child:Card(
                          color: CompanyStyle.primaryColor[200],
                          child:Text(uploadModel.imageTitle,style: TextStyle(fontWeight: FontWeight.bold,backgroundColor: CompanyStyle.primaryColor[200]),softWrap: false,)
                      )
                  ),
                ],
              ),
            );
          }else{
            return Card(
                child:Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.photo_camera),
                        tooltip: 'Camera',
                        onPressed: () {
                          _imgFromCamera(index);
                        },
                        iconSize: screenWidth/12,
                      ),
                      IconButton(
                        icon: Icon(Icons.photo_library,color: Colors.green,),
                        tooltip: 'Photo Library',
                        onPressed: () =>{
                          _onAddImageClick(index)
                        },
                        iconSize: screenWidth/12,
                      ),
                      Text(uploadModel.imageTitle),
                    ]
                )
            );
          }
        }
        else{
          return Card(
              child:  TextButton(
                onPressed: () => {
                  _onAddImageClick(index)
                },
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Text("Something Went Wrong")
                  ],
                ),
              )
          );
        }
      },
      ),

    );
  }
  viewImage(XFile pfile) {
    file = File(pfile.path);
    return Dialog(
      child:InteractiveViewer(
          panEnabled: false,
          minScale: 0.5,
          maxScale: 10,
          child:Image.file(
            file,
          )
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
  viewBase64StrImage(String base64Img) {
    return Dialog(
        child:InteractiveViewer(
          panEnabled: false,
          minScale: 0.5,
          maxScale: 10,
          child: CommonUtil.getImageFromBase64OriginalSize(base64Img,context),

        ));
  }

  Future _onAddImageClick(int index) async {

    try{
      _imageFile = _picker.pickImage(source: ImageSource.gallery);

    }catch(e){

    }

    setState(() {

      getFileImage(index);

    });
  }
  _imgFromCamera(int index) async {
    try{
      _imageFile =  _picker.pickImage(source: ImageSource.camera);
      setState(() {
        getFileImage(index);
      });
    }on PlatformException catch (err) {
      showSnackBar(context,'Error $err',Colors.red,Colors.white);
    }catch( e){
      showSnackBar(context,'Something went wrong',Colors.red,Colors.white);
    }

  }
  void getFileImage(int index) async {
    ImageUploadModel model1 = images[index];
    debugPrint('_imageFile');
    _imageFile.then((file) async {
      debugPrint('adding image in model look here');
      debugPrint(model1.imageUrl);
      debugPrint(model1.imageName);
      model1.imageFile=file;
      ImageUploadModel imageUpload = new ImageUploadModel();
      String base64Image=await CommonUtil.convertImgToBase64Str(model1.imageFile);
      debugPrint('base64Image='+base64Image);
      setState(() {
        imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageBase64=base64Image;
        imageUpload.isImageReq=model1.isImageReq;
        imageUpload.imageTitle=model1.imageTitle;
        imageUpload.imageUrl = model1.imageUrl;
        imageUpload.imageName = model1.imageName;
        images.replaceRange(index, index + 1, [imageUpload]);
      });
      uploadImageOnServer(imageUpload,index);
    });
  }
  uploadImageOnServer(ImageUploadModel imageUpload,int index) async{
    Map<String, dynamic> docuUploadForm = new Map<String, String>();
    debugPrint('upload image name='+imageUpload.imageName);
    debugPrint('upload image=');
    // debugPrint(imageUpload.imageFile);
    debugPrint(imageUpload.imageFile.path);
    showProgressIndicator("Uploading...");
    docuUploadForm={
      'userId':accountId,
      'imageName':imageUpload.imageName+'_'+accountId,
      'imageBase64':CommonConstant.START_OF_IMAGE_BASE64+imageUpload.imageBase64
    };
    debugPrint('docuUploadForm='+docuUploadForm.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    SuccessModel response2;
    try {
      final response = await _provider.post("/upload/upload-doctor-image", docuUploadForm);
      response2 = SuccessModel.fromJson(response);
    } catch (e) {
      setState(() {
        isDataProcessed = false;
      });
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    setState(() {
      isDataProcessed = false;
    });
    dismissProgressIndicator();
    if (response2 != null) {
      if (response2.status == CommonConstant.STATUS_SUCCESS) {
        showSuccessIndicator("Uploaded");
        updateRequestBody(imageUpload);
      } else if (response2.status == CommonConstant.STATUS_FAILED) {
        showSnackBar(
            context, 'Failed To Upload image, please try again.', Colors.red, Colors.white);
      } else {
        showSnackBar(
            context, 'Something went wrong please try again after sometime.', Colors.red, Colors.white);
      }
    }else{
      showSnackBar(
          context, 'Something went wrong please try again after sometime.', Colors.red, Colors.white);
    }
  }
  updateRequestBody(ImageUploadModel imageUpload){
    if(imageUpload.imageName!=null && imageUpload.imageName=="PROFILE"){
      documentReqBody['profilePic']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="PANFRONT"){
      documentReqBody['panFront']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="AADHAR"){
      documentReqBody['aadhar']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="AADHARBACK"){
      documentReqBody['aadharBack']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="QUALIFICATION1"){
      documentReqBody['qualiCertificate1']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="QUALIFICATION2"){
      documentReqBody['qualiCertificate2']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="QUALIFICATION3"){
      documentReqBody['qualiCertificate3']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="QUALIFICATION4"){
      documentReqBody['qualiCertificate4']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="QUALIFICATION5"){
      documentReqBody['qualiCertificate5']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="QUALIFICATION6"){
      documentReqBody['qualiCertificate6']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="RAMP"){
      documentReqBody['rampCertificate']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="PROFCERT"){
      documentReqBody['profCertificate']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="MEDICOUNCIL"){
      documentReqBody['mediCouncilRegistration']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="HEALTHDEP"){
      documentReqBody['healthDepCertificate']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="AYUSHDEP"){
      documentReqBody['ayushDepRegistration']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="OTHERLICCERT1"){
      documentReqBody['otherLicCertificate1']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="OTHERLICCERT2"){
      documentReqBody['otherLicCertificate2']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="OTHERLICCERT3"){
      documentReqBody['otherLicCertificate3']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="PROFWORK1"){
      documentReqBody['professionalWorkimg1']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="PROFWORK2"){
      documentReqBody['professionalWorkimg2']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="PROFWORK3"){
      documentReqBody['professionalWorkimg3']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="SIGNATURE"){
      documentReqBody['signatureImg']='Y';
    }
  }
  void updateDocumentsdetails(BuildContext context, Map<String, dynamic> documentReqBody) async{
    debugPrint('before submitting='+documentReqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    // showProgressIndicator("Uploading...");
    SuccessModel successModel;

    try {
      final response = await _provider.post("/account/update-doctor-document", documentReqBody);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Scaffold.of(context).hideCurrentSnackBar();
      successModel = SuccessModel.fromJson(response);

      setState(() {
        isDataProcessed = false;
      });
      if (successModel != null) {
        if (successModel.status == CommonConstant.STATUS_SUCCESS) {
          _formKey.currentState.reset();
          showSnackBar(context, 'Account Updated Successfully', Colors.green, Colors.white);
          Navigator.of(context).pop(true);
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorLogin()));
        } else if (successModel.status == CommonConstant.STATUS_FAILED) {
          showSnackBar(
              context, 'Failed To Update Account, please try again.', Colors.red, Colors.white);
        } else {
          showSnackBar(
              context, 'Something went wrong please try again.', Colors.red, Colors.white);
        }
      }else{
        showSnackBar(
            context, 'Something went wrong please try again.', Colors.red, Colors.white);
      }
    } catch (e) {
      setState(() {
        isDataProcessed = false;
      });
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }

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

  Future<List<DoctorDocumentsModel>> getDoctorDocuments(BuildContext context) async{
    Map<String, dynamic> reqBody = new Map<String, String>();
    reqBody={
      'id': accountId

    };
    ApiProvider _provider = new ApiProvider();
    try {
      final response = await _provider.post("/account/get-doc-document-detail",reqBody);
      doctorDocumentsModelList = (response as List).map((data) => DoctorDocumentsModel.fromJson(data)).toList();

    } catch (e) {
      debugPrint('error at getAdvertisementsList page='+e.toString().toString());
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    return doctorDocumentsModelList;
  }

  void getDocumentsReady() {
    doctorDocumentsModelFutureList.whenComplete(() => null).then((value) =>
    {

      debugPrint("completed"),
      setState(() {
        doctorDocumentsModel = value[0];
        if (doctorDocumentsModel != null) {


          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'PROFILE';
          imageUploadModel.imageTitle = 'Profile Image *';
          if (!CommonUtil.isBlank(doctorDocumentsModel.profilePic) &&
              doctorDocumentsModel.profilePic == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 = doctorDocumentsModel.profilePicB64Img;
            documentReqBody['profilePic']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }

          imageUploadModel.isImageReq = true;
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'PANFRONT';
          imageUploadModel.imageTitle = 'Pan Card *';
          if (!CommonUtil.isBlank(doctorDocumentsModel.panFront) &&
              doctorDocumentsModel.panFront == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 = doctorDocumentsModel.panFrontImgBase64;
            documentReqBody['panFront']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          imageUploadModel.isImageReq = true;
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'AADHAR';
          imageUploadModel.imageTitle = 'Aadhar card Front *';
          debugPrint('aadhar value=${doctorDocumentsModel.aadhar}');
          if (!CommonUtil.isBlank(doctorDocumentsModel.aadhar) &&
              doctorDocumentsModel.aadhar == CommonConstant.FLAG_Y) {
            debugPrint('aadhar=Y found');
            imageUploadModel.imageBase64 =doctorDocumentsModel.aadharImgBase64;
            documentReqBody['aadhar']='Y';
          } else {
            debugPrint('aadhar=N found');
            imageUploadModel.imageBase64 = "";
          }

          debugPrint('aadhar=${doctorDocumentsModel.aadharImgBase64}');
          imageUploadModel.isImageReq = true;
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'AADHARBACK';
          imageUploadModel.imageTitle = 'Aadhar Card Back *';
          if (!CommonUtil.isBlank(doctorDocumentsModel.aadharBack) &&
              doctorDocumentsModel.aadharBack == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.aadharBackImgBase64;
            documentReqBody['aadharBack']='Y';
          }
          imageUploadModel.isImageReq = true;
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'QUALIFICATION1';
          imageUploadModel.imageTitle = 'Qualification Certificate 1 *';
          if (!CommonUtil.isBlank(doctorDocumentsModel.qualiCertificate1) &&
              doctorDocumentsModel.qualiCertificate1 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.qualiCertificate1B64Img;
            documentReqBody['qualiCertificate1']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          imageUploadModel.isImageReq = true;
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'QUALIFICATION2';
          imageUploadModel.imageTitle = 'Qualification Certificate 2';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.qualiCertificate2) &&
              doctorDocumentsModel.qualiCertificate2 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.qualiCertificate2B64Img;
            documentReqBody['qualiCertificate2']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'QUALIFICATION3';
          imageUploadModel.imageTitle = 'Qualification Certificate 3';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.qualiCertificate3) &&
              doctorDocumentsModel.qualiCertificate3 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.qualiCertificate3B64Img;
            documentReqBody['qualiCertificate3']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'QUALIFICATION4';
          imageUploadModel.imageTitle = 'Qualification Certificate 4';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.qualiCertificate4) &&
              doctorDocumentsModel.qualiCertificate4 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.qualiCertificate4B64Img;
            documentReqBody['qualiCertificate4']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'QUALIFICATION5';
          imageUploadModel.imageTitle = 'Qualification Certificate 5';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.qualiCertificate5) &&
              doctorDocumentsModel.qualiCertificate5 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.qualiCertificate5B64Img;
            documentReqBody['qualiCertificate5']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'QUALIFICATION6';
          imageUploadModel.imageTitle = 'Qualification Certificate 6';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.qualiCertificate6) &&
              doctorDocumentsModel.qualiCertificate6 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.qualiCertificate6B64Img;
            documentReqBody['qualiCertificate6']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'RAMP';
          imageUploadModel.imageTitle = 'RAMP Certificate';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.rampCertificate) &&
              doctorDocumentsModel.rampCertificate == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.rampCertificateB64Img;
            documentReqBody['rampCertificate']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'PROFCERT';
          imageUploadModel.imageTitle = 'Professional Certificate';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.profCertificate) &&
              doctorDocumentsModel.profCertificate == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.profCertificateB64Img;
            documentReqBody['profCertificate']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'MEDICOUNCIL';
          imageUploadModel.imageTitle = 'Medical Council registration';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.mediCouncilRegistration) &&
              doctorDocumentsModel.mediCouncilRegistration == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.medicalCouncilB64Img;
            documentReqBody['mediCouncilRegistration']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'HEALTHDEP';
          imageUploadModel.imageTitle = 'Health department registration';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.healthDepCertificate) &&
              doctorDocumentsModel.healthDepCertificate == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.healthDepCertificateB64Img;
            documentReqBody['healthDepCertificate']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'AYUSHDEP';
          imageUploadModel.imageTitle = 'Ayush department registration';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.ayushDepRegistration) &&
              doctorDocumentsModel.ayushDepRegistration == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.ayushDepRegistrationB64Img;
            documentReqBody['ayushDepRegistration']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'OTHERLICCERT1';
          imageUploadModel.imageTitle = 'Other License/Certificate 1 *';
          imageUploadModel.isImageReq = true;
          if (!CommonUtil.isBlank(doctorDocumentsModel.otherLicCertificate1) &&
              doctorDocumentsModel.otherLicCertificate1 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.otherLicCertificate1B64Img;
            documentReqBody['otherLicCertificate1']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'OTHERLICCERT2';
          imageUploadModel.imageTitle = 'Other License/Certificate 2';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.otherLicCertificate2) &&
              doctorDocumentsModel.otherLicCertificate2 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.otherLicCertificate2B64Img;
            documentReqBody['otherLicCertificate2']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'OTHERLICCERT3';
          imageUploadModel.imageTitle = 'Other License/Certificate 3';
          imageUploadModel.isImageReq = false;
          if (!CommonUtil.isBlank(doctorDocumentsModel.otherLicCertificate3) &&
              doctorDocumentsModel.otherLicCertificate3 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.otherLicCertificate3B64Img;
            documentReqBody['otherLicCertificate3']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'PROFWORK1';
          imageUploadModel.imageTitle = 'Professional Working 1 *';
          imageUploadModel.isImageReq = true;
          if (!CommonUtil.isBlank(doctorDocumentsModel.professionalWorkimg1) &&
              doctorDocumentsModel.professionalWorkimg1 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.professionalWorkimg1B64Img;
            documentReqBody['professionalWorkimg1']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'PROFWORK2';
          imageUploadModel.imageTitle = 'Professional Working 2 *';
          imageUploadModel.isImageReq = true;
          if (!CommonUtil.isBlank(doctorDocumentsModel.professionalWorkimg2) &&
              doctorDocumentsModel.professionalWorkimg2 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.professionalWorkimg2B64Img;
            documentReqBody['professionalWorkimg2']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'PROFWORK3';
          imageUploadModel.imageTitle = 'Professional Working 3 *';
          imageUploadModel.isImageReq = true;
          if (!CommonUtil.isBlank(doctorDocumentsModel.professionalWorkimg3) &&
              doctorDocumentsModel.professionalWorkimg3 == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.professionalWorkimg3B64Img;
            documentReqBody['professionalWorkimg3']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          imageUploadModel = new ImageUploadModel();
          imageUploadModel.imageName = 'SIGNATURE';
          imageUploadModel.imageTitle = 'Your Signature *';
          imageUploadModel.isImageReq = true;
          if (!CommonUtil.isBlank(doctorDocumentsModel.signatureImg) &&
              doctorDocumentsModel.signatureImg == CommonConstant.FLAG_Y) {
            imageUploadModel.imageBase64 =doctorDocumentsModel.signatureB64Img;
            documentReqBody['signatureImg']='Y';
          } else {
            imageUploadModel.imageBase64 = "";
          }
          images.add(imageUploadModel);

          websiteLink.text=doctorDocumentsModel.websiteLink;
          facebookLink.text=doctorDocumentsModel.facebookLink;
          instagramLink.text=doctorDocumentsModel.instagramLink;
          youtubeLink.text=doctorDocumentsModel.youtubeLink;
          twitterLink.text=doctorDocumentsModel.twitterLink;
          achievementsComments.text=doctorDocumentsModel.achievementsComments;
          experienceComments.text=doctorDocumentsModel.experienceComments;

        }
      }),
    });
  }

  Widget showLoading(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: BarProgressIndicator(
              numberOfBars: 4,
              color: Colors.white,
              fontSize: 5.0,
              barSpacing: 2.0,
              beginTweenValue: 5.0,
              endTweenValue: 13.0,
              milliseconds: 200,
            ),
            height:screenWidth/ 7,
            width: screenWidth/ 7,
          ),
          SizedBox(height: 10,),
          Text('Loading please wait...',style: TextStyle(fontSize: screenWidth/20),),
        ],
      ),
    );
  }

  Widget buildDoctorsDocumentsTiles(data) {
    return ListView(
      children: <Widget>[
        Card(
          color: CompanyStyle.primaryColor,
          child:Container(
            padding: EdgeInsets.all(10.0),
            child:  Text('Uploaded Documents', style: TextStyle(fontSize: screenWidth/25)),
          ),
        ),

        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,

                      child: TextButton(onPressed: () {
                        if(images[0].imageBase64.length>10) {
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[0].imageBase64)
                          );
                        }
                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[0].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(0)
                      },
                      iconSize: screenWidth/12,
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(0);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[0].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[1].imageBase64.length>10) {
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[1].imageBase64)
                          );
                        }
                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[1].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(1)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(1);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[1].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[2].imageBase64.length>10) {
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[2].imageBase64)
                          );
                        }
                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[2].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(2)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(2);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[2].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[3].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[3].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[3].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(3)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(3);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[3].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,

                      child: TextButton(onPressed: () {
                        if(images[4].imageBase64.length>10) {
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[4].imageBase64)
                          );
                        }
                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[4].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(4)
                      },
                      iconSize: screenWidth/12,
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(4);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[4].imageTitle)),
                  ]
              )
          ),
        ),

        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[5].imageBase64.length>10) {
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[5].imageBase64)
                          );
                        }
                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[5].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(5)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(5);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[5].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[6].imageBase64.length>10) {
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[6].imageBase64)
                          );
                        }
                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[6].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(6)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(6);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[6].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[3].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[7].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[7].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(7)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(7);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[7].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[8].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[8].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[8].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(8)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(8);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[8].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[9].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[9].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[9].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(9)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(9);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[9].imageTitle)),
                  ]
              )
          ),
        ),

        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[10].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[10].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[10].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(10)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(10);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[10].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[11].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[11].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[11].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(11)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(11);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[11].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[12].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[12].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[12].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(12)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(12);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[12].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[13].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[13].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[13].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(13)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(13);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[13].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[14].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[14].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[14].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(14)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(14);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[14].imageTitle)),
                  ]
              )
          ),
        ),

        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[15].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[15].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[15].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(15)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(15);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[15].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[16].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[16].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[16].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(16)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(16);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[16].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[17].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[17].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[17].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(17)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(17);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[17].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[18].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[18].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[18].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(18)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(18);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[18].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[19].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[19].imageBase64)
                          );
                        }

                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[19].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(19)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(19);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[19].imageTitle)),
                  ]
              )
          ),
        ),

        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[20].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[20].imageBase64)
                          );
                        }
                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[20].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(20)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(20);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[20].imageTitle)),
                  ]
              )
          ),
        ),
        Card(
          color: CompanyStyle.primaryColor,
          child: Center(
              child:Row(
                  children:<Widget>[
                    Container(
                      alignment:Alignment.topRight,
                      width: 60,
                      height: 60,
                      child: TextButton(onPressed: () {
                        if(images[21].imageBase64.length>10){
                          showDialog(
                              context: context,
                              builder: (_) => viewBase64StrImage(images[21].imageBase64)
                          );
                        }
                      },
                        child:CommonUtil.getImageFromBase64OriginalSize(images[21].imageBase64,context),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.photo_library,color: Colors.green,),
                      tooltip: 'Photo Library',
                      onPressed: () =>{
                        _onAddImageClick(21)
                      },
                      iconSize: screenWidth/12,
                    ),

                    IconButton(
                      icon: Icon(Icons.photo_camera),
                      tooltip: 'Camera',
                      onPressed: () {
                        _imgFromCamera(21);
                      },
                      iconSize: screenWidth/12,
                    ),

                    Flexible(child: Text(images[21].imageTitle)),
                  ]
              )
          ),
        ),
        Container(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              color: CompanyStyle.primaryColor,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: websiteLink,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.link, color: Colors.white),
                        labelText: "Your Website link",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 45),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      controller: facebookLink,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.link, color: Colors.white),
                        labelText: "Facebook link",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 45),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      controller: instagramLink,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.link, color: Colors.white),
                        labelText: "Instagram link",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 45),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      controller: youtubeLink,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.link, color: Colors.white),
                        labelText: "YouTube link",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 45),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      controller: twitterLink,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.link, color: Colors.white),
                        labelText: "Twitter link",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 45),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      controller: experienceComments,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your Education Practice & Experience.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.book_outlined, color: Colors.white),
                        labelText: "About Your Education Practice & Experience",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 55),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      controller: achievementsComments,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your Achievements.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.auto_awesome, color: Colors.white),
                        labelText: "About your Achievements *",
                        labelStyle: TextStyle(
                            color: Colors.white, fontSize: screenHeight / 55),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    Center(
                      child:ElevatedButton(
                        style:  CompanyStyle.getButtonStyle(),
                        onPressed: isDataProcessed?null:() {
                          List<String> errorList= validateImage();
                          documentReqBody['id']=accountId;
                          documentReqBody['websiteLink']= websiteLink.text;
                          documentReqBody['facebookLink']= facebookLink.text;
                          documentReqBody['instagramLink']= instagramLink.text;
                          documentReqBody['youtubeLink']= youtubeLink.text;
                          documentReqBody['twitterLink']= twitterLink.text;
                          documentReqBody['experienceComments']= experienceComments.text;
                          documentReqBody['achievementsComments']= achievementsComments.text;


                          if (_formKey.currentState.validate() && errorList.length==0){
                            _formKey.currentState.save();
                            debugPrint('documentReqBody=' + documentReqBody.toString());
                            updateDocumentsdetails(context, documentReqBody);
                          }else{
                            debugPrint('total error found='+errorList.length.toString());
                            debugPrint('documentReqBody=' + documentReqBody.toString());
                          }

                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Text('Update Details', style: TextStyle(fontSize: screenWidth/25),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  bool isImageReq;
  XFile imageFile;
  String imageTitle;
  String imageBase64;
  String imageUrl;
  String imageName;

  ImageUploadModel({
    this.isUploaded=false,
    this.uploading=false,
    this.isImageReq=false,
    this.imageFile,
    this.imageTitle,
    this.imageBase64,
    this.imageUrl,
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