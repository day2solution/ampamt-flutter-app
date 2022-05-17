import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/model/image-upload-model.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class AddAdvertisements extends StatefulWidget {
  final String accountId;
  AddAdvertisements({this.accountId}) : super();
  @override
  _AddAdvertisementsState createState() => _AddAdvertisementsState(accountId: accountId);
}

class _AddAdvertisementsState extends State<AddAdvertisements> {
  final String accountId;
  _AddAdvertisementsState({this.accountId}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  // static double screenHeight;
  bool isDataProcessed=false;
  final imageName = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  ImageUploadModel imageUploadModel=new ImageUploadModel();
  Future<XFile> _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    debugPrint('getting event list');
    super.initState();
    imageUploadModel.imageTitle="Select Advertisement image *";
    debugPrint('accountId=$accountId');
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
                'assets/images/dashboard/app/57.png',
                width: 40,
                height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Add Advertisements',
                  style: TextStyle(fontSize: screenWidth / 20),
                ))
          ],
        ),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children:<Widget> [
            Container(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
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
                                    if(imageUploadModel.imageBase64!=null && imageUploadModel.imageBase64.length>10) {
                                      showDialog(
                                          context: context,
                                          builder: (_) => viewBase64StrImage(imageUploadModel.imageBase64)
                                      );
                                    }
                                  },
                                    child:CommonUtil.getImgFromBase64FillSizeNoSplit(imageUploadModel.imageBase64,context),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.photo_library,color: Colors.green,),
                                  tooltip: 'Photo Library',
                                  onPressed: () =>{
                                    _onAddImageClick()
                                  },
                                  iconSize: screenWidth/12,
                                ),
                                IconButton(
                                  icon: Icon(Icons.photo_camera),
                                  tooltip: 'Camera',
                                  onPressed: () {
                                    _imgFromCamera();
                                  },
                                  iconSize: screenWidth/12,
                                ),

                                Flexible(child: Text(imageUploadModel.imageTitle)),
                              ]
                          )
                      ),
                    ),

                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      controller: imageName,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.image, color: Colors.white),
                        labelText: "Image name (Optional)",
                        labelStyle: getInputFieldStyle(),
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

                    CompanyStyle.getInputElementGap(),
                    ElevatedButton(
                      style: CompanyStyle.getButtonStyle(),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(2),
                        child: Text('Create Advertisement', style: TextStyle(fontSize: screenWidth/25,letterSpacing: 2),),
                        width: double.infinity,
                      ),
                      onPressed: isDataProcessed?null:() {
                        _formKey.currentState.save();
                        if(CommonUtil.isBlank(imageUploadModel.imageBase64)){
                          List<String> errorList=[];
                          errorList.add("Please select advertisement image *");
                          _showDialog(errorList);
                        }else{
                          Map<String, dynamic> eventReqBody = new Map<String, String>();
                          eventReqBody['accountId']=accountId;
                          eventReqBody['imageName']=imageName.text;
                          eventReqBody['extras']=CommonConstant.START_OF_IMAGE_BASE64+imageUploadModel.imageBase64;
                          if (_formKey.currentState.validate()) {
                            debugPrint('now submiting form data='+_formKey.currentState.toString());
                            createAdvertisement(eventReqBody);
                          }else{
                            debugPrint('please fill all the required details');
                            showSnackBar(context,'Please fill the required details marked as (*)',Colors.red,Colors.white);
                          }
                        }

                      },
                    ),
                  ]),
                ),
              ),
            ),

          ],
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
  Future _onAddImageClick() async {
    try{
      _imageFile = _picker.pickImage(source: ImageSource.gallery);
      getFileImage();
    }on PlatformException catch (err) {
      showSnackBar(context,'Error $err',Colors.red,Colors.white);
    }catch(e){
      showSnackBar(context,'Error $e',Colors.red,Colors.white);
    }
  }
  _imgFromCamera() async {
    try{
      _imageFile =  _picker.pickImage(source: ImageSource.camera);
      getFileImage();
    }on PlatformException catch (err) {
      showSnackBar(context,'Error $err',Colors.red,Colors.white);
    }catch( e){
      showSnackBar(context,'Error $e',Colors.red,Colors.white);
    }

  }
  void getFileImage() async {
    _imageFile.then((file) async {
      debugPrint('adding image in model look here');
      String base64Image=await CommonUtil.convertImgToBase64Str(file);
      debugPrint('base64Image='+base64Image);
      setState(() {
        imageUploadModel.isUploaded = false;
        imageUploadModel.uploading = false;
        imageUploadModel.imageFile = file;
        imageUploadModel.imageBase64=base64Image;
        imageUploadModel.isImageReq=true;
      });
    });
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

  showProgressIndicator(String msg){
    EasyLoading.show(status: msg);
  }
  showSuccessIndicator(String msg){
    EasyLoading.showSuccess(msg,duration: Duration(milliseconds: 700));
  }
  dismissProgressIndicator(){
    EasyLoading.dismiss(animation: true);
  }

  SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor) {
    return SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgcolor);
  }

  viewBase64StrImage(String imageBase64) {
    return Dialog(
        child:InteractiveViewer(
          // alignPanAxis : false,
          panEnabled: false,
          minScale: 0.5,
          maxScale: 10,
          child: CommonUtil.getImgFromBase64OriginalSizeNoSplit(imageBase64,context),
        ));
  }

  static getInputFieldStyle() {
    return TextStyle(color: Colors.grey[350], fontSize: screenWidth / 25);
  }

  void createAdvertisement(Map<String, dynamic> eventReqBody) async{
    debugPrint('before submitting='+eventReqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showProgressIndicator("Processing...");
    SuccessModel successModel;

    try {
      final response = await _provider.post("/advertisement/create-advertisement", eventReqBody);
      successModel = SuccessModel.fromJson(response);
      dismissProgressIndicator();
      setState(() {
        isDataProcessed = false;
      });
      if (successModel != null && !CommonUtil.isBlank(successModel.status)) {
        if ( successModel.status == CommonConstant.STATUS_SUCCESS) {
          _formKey.currentState.reset();
          showSuccessIndicator("Success");
          Navigator.of(context).pop(true);
        } else if (successModel.status == CommonConstant.STATUS_FAILED) {
          showSnackBar(context, 'Failed To Add Advertisement, please try again.', Colors.red, Colors.white);
        } else {
          showSnackBar(context, 'Something went wrong please try again.', Colors.red, Colors.white);
        }
      }else{
        showSnackBar(context, 'Something went wrong please try again.', Colors.red, Colors.white);
      }
    } catch (e) {
      dismissProgressIndicator();
      setState(() {
        isDataProcessed = false;
      });
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
  }
}
