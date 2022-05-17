import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/dashboard/admin/display/doctor-account-details.dart';
import 'package:ampamt/model/business/BusinessDocumentUploadModel.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class EditBusinessDocumentUpload extends StatefulWidget{
  EditBusinessDocumentUpload({Key key, this.accountId}) : super(key: key);
  final String accountId;
  @override
  _EditBusinessDocumentUploadState createState()=>_EditBusinessDocumentUploadState(accountId:accountId );

}
class _EditBusinessDocumentUploadState extends State<EditBusinessDocumentUpload>{
  _EditBusinessDocumentUploadState({this.accountId}) ;
  final String accountId;
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
            Image.asset('assets/images/home/upload-doc.png',width: 40,height: 40),
            Container(
                padding: const EdgeInsets.all(10.0), child: Text('Upload Documents')
            )
          ],
        ),
      ),
      body:EditBusinessDocumentUploadStateForm(accountId: accountId,),
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
class EditBusinessDocumentUploadStateForm extends StatefulWidget {
  EditBusinessDocumentUploadStateForm({Key key, this.accountId}) : super(key: key);
  final String accountId;
  @override
  EditBusDocUploadStateFormState createState() {
    return EditBusDocUploadStateFormState(accountId: accountId);
  }
}

class EditBusDocUploadStateFormState extends State<EditBusinessDocumentUploadStateForm> {
  EditBusDocUploadStateFormState({Key key, this.accountId}) ;
  final String accountId;
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  // final ImagePicker _picker = ImagePicker();
  // @override
  // void initState() {
  //   super.initState();
  //
  // }
  final String uploadEndPoint =
      'http://localhost/flutter_test/upload_image.php';
  // Future<PickedFile> pickedFile;
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

  Future<List<BusinessDocumentUploadModel>> businessDocumentUploadModelFutureList;
  List<BusinessDocumentUploadModel> businessDocumentUploadModelList = [];

  Map<String, dynamic> documentReqBody = new Map<String, String>();
  @override
  void initState() {
    print('documentupload page accountId=$accountId');
    // TODO: implement initState
    super.initState();
    controller = PhotoViewController();
    setState(() {
      businessDocumentUploadModelFutureList=getBusinessDocumentsDetails(context);


    });
    getReadyDocuments();
  }
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    // return new MaterialApp(
    return Scaffold(
        body:Container(
            child: WillPopScope(
              onWillPop: _onWillPop,
              child: FutureBuilder(
                  future: businessDocumentUploadModelFutureList,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return showLoading('Loading State List...');
                    } else if (snapshot.hasError) {
                      print('error at haserror');
                      return Text('Error');
                    } else {
                      // List<BusinessDocumentUploadModel> documentsList=snapshot.data;

                      // if(documentsList[0].companyLogo=="Y"){
                      //   images[0].imageBase64= documentsList[0].companyLogoBase64;
                      // }

                      return buildDocumentsList();
                    }
                  }),


            )
        )
    );
  }
  Widget buildDocumentsList(){

    return   ListView(
      children: <Widget>[

        Card(
          color: CompanyStyle.primaryColor,
          child:Container(
            padding: EdgeInsets.all(10.0),
            child:  Text('Please Upload All The Required (*) Images Here', style: TextStyle(fontSize: screenWidth/25)),
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
                              builder: (_) => viewBase64StrImage(0)
                          );
                        }
                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[0].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(1)
                          );
                        }
                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[1].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(2)
                          );
                        }
                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[2].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(3)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[3].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(4)
                          );
                        }
                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[4].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(5)
                          );
                        }
                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[5].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(6)
                          );
                        }
                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[6].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(7)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[7].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(8)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[8].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(9)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[9].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(10)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[10].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(11)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[11].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(12)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[12].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(13)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[13].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(14)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[14].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(15)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[15].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(16)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[16].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(17)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[17].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(18)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[18].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(19)
                          );
                        }

                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[19].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(20)
                          );
                        }
                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[20].imageBase64,context),
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
                              builder: (_) => viewBase64StrImage(21)
                          );
                        }
                      },
                        child:CommonUtil.getImgFromBase64FillSizeNoSplit(images[21].imageBase64,context),
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
                          return 'Please enter about your company.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.book_outlined, color: Colors.white),
                        labelText: "About Your company",
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
                          return 'Please enter details about your product.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.auto_awesome, color: Colors.white),
                        labelText: "Details About Your Product",
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
                          documentReqBody['aboutCompany']= experienceComments.text;
                          documentReqBody['detailAboutProduct']= achievementsComments.text;


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
                          child: Text('Submit', style: TextStyle(fontSize: screenWidth/25),),
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
  getReadyDocuments(){
    businessDocumentUploadModelFutureList.then((value) => {
      debugPrint(value.length.toString()),
      setState(() {
        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='COMPLOGO';
        imageUploadModel.imageTitle='Company Logo *';
        if(value[0].companyLogo!=null && value[0].companyLogo==CommonConstant.FLAG_Y && value[0].companyLogoBase64.length>10){
          List<String> list=value[0].companyLogoBase64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        imageUploadModel.isImageReq=true;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='MSME';
        imageUploadModel.imageTitle='MSME Certificate';
        if(value[0].msmeCertificate!=null && value[0].msmeCertificate==CommonConstant.FLAG_Y && value[0].msmeCertificateBase64.length>10){
          List<String> list=value[0].msmeCertificateBase64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        imageUploadModel.isImageReq=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='COMPPAN';
        imageUploadModel.imageTitle='Company Pan card Image';
        if(value[0].companyPan!=null && value[0].companyPan==CommonConstant.FLAG_Y && value[0].companyPanBase64.length>10){
          List<String> list=value[0].companyPanBase64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        imageUploadModel.isImageReq=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='COMPAADHARBACK';
        imageUploadModel.imageTitle='Company Aadhar Card Back Image';
        if(value[0].companyAadhar!=null && value[0].companyAadhar==CommonConstant.FLAG_Y && value[0].companyAadharBase64.length>10){
          List<String> list=value[0].companyAadharBase64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        imageUploadModel.isImageReq=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='COMPAADHAR';
        imageUploadModel.imageTitle='Company Aadhar Card Front Image';
        if(value[0].companyAadharBack!=null && value[0].companyAadharBack==CommonConstant.FLAG_Y && value[0].companyAadharBackBase64.length>10){
          List<String> list=value[0].companyAadharBackBase64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        imageUploadModel.isImageReq=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='GUMASTACERT';
        imageUploadModel.imageTitle='Gumasta Certificate *';
        if(value[0].gumastaCertificate!=null && value[0].gumastaCertificate==CommonConstant.FLAG_Y && value[0].gumastaCertificateBase64.length>10){
          List<String> list=value[0].gumastaCertificateBase64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        imageUploadModel.isImageReq=false;
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='ISOCERT';
        imageUploadModel.imageTitle='ISO Certificate';
        imageUploadModel.isImageReq=false;
        if(value[0].isoCertificate!=null && value[0].isoCertificate==CommonConstant.FLAG_Y && value[0].isoCertificateBase64.length>10){
          List<String> list=value[0].isoCertificateBase64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='GSTCERT';
        imageUploadModel.imageTitle='GST Certificate';
        imageUploadModel.isImageReq=false;
        if(value[0].gstCertificate!=null && value[0].gstCertificate==CommonConstant.FLAG_Y && value[0].gstCertificateBase64.length>10){
          List<String> list=value[0].gstCertificateBase64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='COMPLIANCECERT';
        imageUploadModel.imageTitle='Compliance Certificate';
        imageUploadModel.isImageReq=false;
        if(value[0].complianceCertificate!=null && value[0].complianceCertificate==CommonConstant.FLAG_Y && value[0].complianceCertificateBase64.length>10){
          List<String> list=value[0].complianceCertificateBase64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION1';
        imageUploadModel.imageTitle='Qualification Certificate 1';
        imageUploadModel.isImageReq=false;
        if(value[0].qualiCertificate1!=null && value[0].qualiCertificate1==CommonConstant.FLAG_Y && value[0].qualiCertificate1Base64.length>10){
          List<String> list=value[0].qualiCertificate1Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION2';
        imageUploadModel.imageTitle='Qualification Certificate 2';
        imageUploadModel.isImageReq=false;
        if(value[0].qualiCertificate2!=null && value[0].qualiCertificate2==CommonConstant.FLAG_Y && value[0].qualiCertificate2Base64.length>10){
          List<String> list=value[0].qualiCertificate2Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION3';
        imageUploadModel.imageTitle='Qualification Certificate 3';
        imageUploadModel.isImageReq=false;
        if(value[0].qualiCertificate3!=null && value[0].qualiCertificate3==CommonConstant.FLAG_Y && value[0].qualiCertificate3Base64.length>10){
          List<String> list=value[0].qualiCertificate3Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION4';
        imageUploadModel.imageTitle='Qualification Certificate 4';
        imageUploadModel.isImageReq=false;
        if(value[0].qualiCertificate4!=null && value[0].qualiCertificate4==CommonConstant.FLAG_Y && value[0].qualiCertificate4Base64.length>10){
          List<String> list=value[0].qualiCertificate4Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION5';
        imageUploadModel.imageTitle='Qualification Certificate 5';
        imageUploadModel.isImageReq=false;
        if(value[0].qualiCertificate5!=null && value[0].qualiCertificate5==CommonConstant.FLAG_Y && value[0].qualiCertificate5Base64.length>10){
          List<String> list=value[0].qualiCertificate5Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='QUALIFICATION6';
        imageUploadModel.imageTitle='Qualification Certificate 6';
        imageUploadModel.isImageReq=false;
        if(value[0].qualiCertificate6!=null && value[0].qualiCertificate6==CommonConstant.FLAG_Y && value[0].qualiCertificate6Base64.length>10){
          List<String> list=value[0].qualiCertificate6Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='PROFCERT';
        imageUploadModel.imageTitle='Professional Certificate';
        imageUploadModel.isImageReq=false;
        if(value[0].profCertificate!=null && value[0].profCertificate==CommonConstant.FLAG_Y && value[0].profCertificateBase64.length>10){
          List<String> list=value[0].profCertificateBase64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='OTHERLICCERT1';
        imageUploadModel.imageTitle='Other License/Certificate 1';
        imageUploadModel.isImageReq=false;
        if(value[0].otherLicCertificate1!=null && value[0].otherLicCertificate1==CommonConstant.FLAG_Y && value[0].otherLicCertificate1Base64.length>10){
          List<String> list=value[0].otherLicCertificate1Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='OTHERLICCERT2';
        imageUploadModel.imageTitle='Other License/Certificate 2';
        imageUploadModel.isImageReq=false;
        if(value[0].otherLicCertificate2!=null && value[0].otherLicCertificate2==CommonConstant.FLAG_Y && value[0].otherLicCertificate2Base64.length>10){
          List<String> list=value[0].otherLicCertificate2Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='OTHERLICCERT3';
        imageUploadModel.imageTitle='Other License/Certificate 3';
        imageUploadModel.isImageReq=false;
        if(value[0].otherLicCertificate3!=null && value[0].otherLicCertificate3==CommonConstant.FLAG_Y && value[0].otherLicCertificate3Base64.length>10){
          List<String> list=value[0].otherLicCertificate3Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='PROFWORK1';
        imageUploadModel.imageTitle='Professional Working 1';
        imageUploadModel.isImageReq=false;
        if(value[0].professionalWorkimg1!=null && value[0].professionalWorkimg1==CommonConstant.FLAG_Y && value[0].professionalWorkimg1Base64.length>10){
          List<String> list=value[0].professionalWorkimg1Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='PROFWORK2';
        imageUploadModel.imageTitle='Professional Working 2';
        imageUploadModel.isImageReq=false;
        if(value[0].professionalWorkimg2!=null && value[0].professionalWorkimg2==CommonConstant.FLAG_Y && value[0].professionalWorkimg2Base64.length>10){
          List<String> list=value[0].professionalWorkimg2Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);

        imageUploadModel=new ImageUploadModel();
        imageUploadModel.imageName='PROFWORK3';
        imageUploadModel.imageTitle='Professional Working 3';
        imageUploadModel.isImageReq=false;
        if(value[0].professionalWorkimg3!=null && value[0].professionalWorkimg3==CommonConstant.FLAG_Y && value[0].professionalWorkimg3Base64.length>10){
          List<String> list=value[0].professionalWorkimg3Base64.split(",");
          debugPrint(list.toString());
          imageUploadModel.imageBase64=list[1];
        }else{
          imageUploadModel.imageBase64="";
        }
        images.add(imageUploadModel);
      })
    }

    );

  }
  Widget showLoading(String msg) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor:
              AlwaysStoppedAnimation<Color>(CompanyStyle.primaryColor[900]),
            ),
            height: 1,
            width: screenWidth / 2,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            msg != null ? msg : 'Loading...',
            style: TextStyle(fontSize: screenWidth / 20),
          ),
        ],
      ),
    );
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: CompanyStyle.primaryColor,
        title: new Text('Are you sure you want to cancel the ongoing processes?'),
        content: new Text('Your changes may be lost!'),
        actions: <Widget>[
          new TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',style: TextStyle(color: Colors.green),),
          ),
          new TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes',style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    )) ??
        false;
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
          title: new Text("Please Upload Following Required Images",style: TextStyle(color: Colors.red),),
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
        if(images[i].imageBase64==null || images[i].imageBase64==""){
          debugPrint("imageBase64="+images[i].imageBase64.toString()+" for index="+i.toString());
          // if(images[i].imageName=='PROFILE'){
          //   errorList.add('Please Upload ${images[i].imageTitle}');
          // }
          errorList.add('Please Upload ${images[i].imageTitle}');
          // if(images[i].imageName=='PANFRONT'){
          //   errorList.add('Please Upload Pan Card');
          // }
          //
          // if(images[i].imageName=='AADHARFRONT'){
          //   errorList.add('Please Upload Aadhar Card Front');
          // }
          //
          // if(images[i].imageName=='AADHARBACK'){
          //   errorList.add('Please Upload Aadhar Card Back');
          // }
          //
          // if(images[i].imageName=='QUALIFICATION1'){
          //   errorList.add('Please Upload Qualification Certificate 1');
          // }
          //
          // if(images[i].imageName=='OTHERLICCERT1'){
          //   errorList.add('Please Upload Other License/Certificate 1');
          // }
          //
          // if(images[i].imageName=='PROFWORK1'){
          //   errorList.add('Please Upload Professional Working 1');
          // }
          //
          // if(images[i].imageName=='PROFWORK2'){
          //   errorList.add('Please Upload Professional Working 2');
          // }
          //
          // if(images[i].imageName=='PROFWORK3'){
          //   errorList.add('Please Upload Professional Working 3');
          // }
          //
          // if(images[i].imageName=='SIGNATURE'){
          //   errorList.add('Please Upload Your Signature');
          // }
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

  viewBase64StrImage(int index) {
    // String velocity = "VELOCITY";
    // TransformationController controller = TransformationController();
    return Dialog(
        child:InteractiveViewer(
          // alignPanAxis : false,
          panEnabled: false,
          minScale: 0.5,
          maxScale: 10,
          child: CommonUtil.getImgFromBase64FillSizeNoSplit(images[index].imageBase64,context),
          // transformationController: controller,
          // boundaryMargin: EdgeInsets.all(5.0),
          // onInteractionEnd: (ScaleEndDetails endDetails) {
          // controller.value = Matrix4.identity();
          // setState(() {
          //   velocity = endDetails.velocity.toString();
          // });
          // },
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
  Future _imgFromCamera(int index) async {
    try{
      _imageFile =  _picker.pickImage(source: ImageSource.camera);

    }on PlatformException catch (err) {
      showSnackBar(context,'Error $err',Colors.red,Colors.white);
    }catch( e){
      showSnackBar(context,'Something went wrong',Colors.red,Colors.white);
    }
    setState(() {
      getFileImage(index);
    });
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
      // uploadImageOnServer(imageUpload,index);
    });
  }
  uploadImageOnServer(ImageUploadModel imageUpload,int index) async{
    Map<String, dynamic> docuUploadForm = new Map<String, String>();
    debugPrint('upload image name='+imageUpload.imageName);
    debugPrint('upload image=');
    // debugPrint(imageUpload.imageFile);
    debugPrint(imageUpload.imageFile.path);
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
    // showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    Fluttertoast.showToast(msg: "Processing", timeInSecForIosWeb: 5);
    SuccessModel response2;
    try {
      final response = await _provider.post("/upload/upload-doctor-image", docuUploadForm);
      // ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Scaffold.of(context).hideCurrentSnackBar();
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
    if (response2 != null) {
      if (response2.status == CommonConstant.STATUS_SUCCESS) {
        // showSnackBar(context, 'Success', Colors.green, Colors.white);
        Fluttertoast.showToast(msg: "Success", timeInSecForIosWeb: 5);
        updateRequestBody(imageUpload);
      } else if (response2.status == CommonConstant.STATUS_FAILED) {
        showSnackBar(
            context, 'Failed To Create Account, please try again.', Colors.red, Colors.white);
      } else {
        showSnackBar(
            context, 'Something went wrong please try again.', Colors.red, Colors.white);
      }
    }else{
      showSnackBar(
          context, 'Something went wrong please try again.', Colors.red, Colors.white);
    }
  }
  updateRequestBody(ImageUploadModel imageUpload){
    if(imageUpload.imageName!=null && imageUpload.imageName=="COMPLOGO"){
      documentReqBody['companyLogo']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="MSME"){
      documentReqBody['msmeCertificate']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="COMPPAN"){
      documentReqBody['companyPan']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="COMPAADHAR"){
      documentReqBody['companyAadhar']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="COMPAADHARBACK"){
      documentReqBody['companyAadharBack']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="GUMASTACERT"){
      documentReqBody['gumastaCertificate']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="ISOCERT"){
      documentReqBody['isoCertificate']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="GSTCERT"){
      documentReqBody['gstCertificate']='Y';
    }
    if(imageUpload.imageName!=null && imageUpload.imageName=="COMPLIANCECERT"){
      documentReqBody['complianceCertificate']='Y';
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
    if(imageUpload.imageName!=null && imageUpload.imageName=="PROFCERT"){
      documentReqBody['profCertificate']='Y';
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

  }
  void updateDocumentsdetails(BuildContext context, Map<String, dynamic> documentReqBody) async{
    debugPrint('before submitting='+documentReqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    SuccessModel successModel;
    try {
      final response = await _provider.post("/account/update-doctor-document", documentReqBody);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Scaffold.of(context).hideCurrentSnackBar();
      successModel = SuccessModel.fromJson(response);
    } catch (e) {
      setState(() {
        isDataProcessed = false;
      });
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    setState(() {
      isDataProcessed = false;
    });
    if (successModel != null) {
      if (successModel.status == CommonConstant.STATUS_SUCCESS) {
        _formKey.currentState.reset();
        showSnackBar(context, 'Account Updated Successfully, Please Login', Colors.green, Colors.white);
        Navigator.of(context).pop(true);
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
  }

  Future<List<BusinessDocumentUploadModel>> getBusinessDocumentsDetails(BuildContext context) async{
    ApiProvider _provider = new ApiProvider();
    Map<String, dynamic> documentReqBody = new Map<String, String>();
    documentReqBody['id']=accountId;
    try {
      final response = await _provider.post("/account/get-busi-document-detail", documentReqBody);
      businessDocumentUploadModelList =
          (response as List).map((data) => BusinessDocumentUploadModel.fromJson(data)).toList();
      // items.addAll(DropdownMenuItem(ampamtTherapiesModelList));
    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
      // _scaffoldKey.currentState.ScaffoldMessenger.showSnackBar(snackBar);
    }
    return businessDocumentUploadModelList;
  }
  SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor) {
    return SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgcolor);
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