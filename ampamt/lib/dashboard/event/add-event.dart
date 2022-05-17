import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/model/CityModel.dart';
import 'package:ampamt/model/StateModel.dart';
import 'package:ampamt/model/image-upload-model.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  final String accountId;
  AddEvent({this.accountId}) : super();
  @override
  _AddEventState createState() => _AddEventState(accountId: accountId);
}

class _AddEventState extends State<AddEvent> {
  final String accountId;
  _AddEventState({this.accountId}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  // static double screenHeight;
  bool isDataProcessed=false;
  final eventTitle = TextEditingController();
  final eventDescription = TextEditingController();
  final eventDate=TextEditingController();
  Future<List<StateModel>> stateModelFutureList;
  Future<List<CityModel>> cityModelFutureList;

  List<StateModel> stateModelList = [];
  List<CityModel> cityModellList = [];

  bool isLoadingCity=false;
  String selectedStateCode;
  String selectedCityCode;
  String selectedStateName;
  String selectedCityName;
  final _formKey = GlobalKey<FormState>();
  ImageUploadModel imageUploadModel=new ImageUploadModel();
  Future<XFile> _imageFile;
  final ImagePicker _picker = ImagePicker();
  DateTime nowdate =new DateTime.now();

  DateTime maxDateTime=new DateTime.now().add(Duration(days: 365));
  int maxMonth=1;
  int maxYear=new DateTime.now().year+1;
  int maxDate=new DateTime.now().day;

  int selYear=new DateTime.now().year;
  int selMonth=new DateTime.now().month;
  int selDay=new DateTime.now().day;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");


  @override
  void initState() {
    debugPrint('getting event list');
    super.initState();
    maxMonth=maxDateTime.month;
    maxYear=maxDateTime.year;
    maxDate=maxDateTime.day;

    imageUploadModel.imageTitle="Select event image *";
    debugPrint('accountId=$accountId');
    stateModelFutureList = getStateList(context);
  }

  getDate() async{
    await DatePicker.showDatePicker(context,
      showTitleActions: true,
      minTime: DateTime(selYear, selMonth, selDay),
      maxTime: DateTime(maxYear, maxMonth, maxDate),
      onChanged: (date) {
        debugPrint('change $date');
        nowdate=date;
      },
      onConfirm: (date) {
        debugPrint('confirm $date');
        nowdate=date;
        setState(() {
          nowdate = date;
          eventDate.text=dateFormat.format(nowdate);
        });
      },
      currentTime: DateTime(selYear, selMonth, selDay, 0, 0), locale: LocaleType.en,
      theme: DatePickerTheme(
          backgroundColor: CompanyStyle.primaryColor,
          headerColor:CompanyStyle.primaryColor,
          cancelStyle:TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
          doneStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
          itemStyle: TextStyle(
              color: Colors.white,
              fontSize: 20
          )
      ),
    );
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
                'assets/images/dashboard/app/41.png',
                width: 40,
                height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Create Event',
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
                  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: FutureBuilder(
                      future: stateModelFutureList,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return CommonUtil.showLinearProgressLoading('Loading State List...',context);
                        } else if (snapshot.hasError) {
                          print('error at haserror');
                          return Text('Error');
                        } else {
                          return buildStateList(snapshot.data);
                        }
                      }),
                ),
                  CompanyStyle.getInputElementGap(),
                  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: isLoadingCity?CommonUtil.showLinearProgressLoading('Loading City List...',context):buildCityList(cityModellList),
              ),
                  CompanyStyle.getInputElementGap(),
                  TextFormField(
                    controller: eventTitle,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter event title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.apartment, color: Colors.white),
                      labelText: "Event Title *",
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
                  TextFormField(
                    controller: eventDescription,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter event description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.apartment, color: Colors.white),
                      labelText: "Event Description *",
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
                  TextFormField(
                    controller: eventDate,
                    validator: (value) {
                      debugPrint('eventDate='+value);
                      if (value.isEmpty) {
                        return 'Please select event date';
                      }
                      return null;
                    },
                    cursorColor: CompanyStyle.primaryColor[400],
                    readOnly: true,
                    onTap: () {
                      setState(() {
                        getDate();
                      });
                    },
                    decoration: InputDecoration(
                      labelStyle: getInputFieldStyle(),
                      prefixIcon: Icon(Icons.calendar_today_rounded,color: Colors.white),
                      labelText: 'Select Event Date *',
                      hintText: dateFormat.format(nowdate),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                      ),
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
                      child: Text('Create Event', style: TextStyle(fontSize: screenWidth/25,letterSpacing: 2),),
                      width: double.infinity,
                    ),
                    onPressed: isDataProcessed?null:() {
                      _formKey.currentState.save();
                      if(CommonUtil.isBlank(imageUploadModel.imageBase64)){
                        List<String> errorList=[];
                        errorList.add("Please select event image *");
                        _showDialog(errorList);
                      }else{
                        Map<String, dynamic> eventReqBody = new Map<String, String>();
                        eventReqBody['accountId']=accountId;
                        eventReqBody['eventTitle']=eventTitle.text;
                        eventReqBody['eventDescription']=eventDescription.text;
                        eventReqBody['eventState']=selectedStateName;
                        eventReqBody['eventCity']=selectedCityName;
                        eventReqBody['eventImg']=CommonConstant.FLAG_Y;
                        eventReqBody['activeFlag']=CommonConstant.FLAG_Y;
                        eventReqBody['eventDate']=eventDate.text;

                        if (_formKey.currentState.validate()) {
                          debugPrint('now submiting form data='+_formKey.currentState.toString());
                          createEvent(eventReqBody);
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

  void uploadImageOnServer(ImageUploadModel imageUploadModel,String eventId) async{
    Map<String, dynamic> uploadForm = new Map<String, String>();
    uploadForm={
      'eventImgName':"EVENT_"+eventId,
      'eventImgBase64':CommonConstant.START_OF_IMAGE_BASE64+imageUploadModel.imageBase64,
      'accountId':accountId,
  };
    debugPrint('docuUploadForm='+uploadForm.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    // showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    showProgressIndicator("Processing...");
    SuccessModel responseModel;
    try {
      final response = await _provider.post("/upload/upload-event-image", uploadForm);
      responseModel = SuccessModel.fromJson(response);
      setState(() {
        isDataProcessed = false;
      });
      dismissProgressIndicator();
      if (responseModel != null) {
        if (responseModel.status == CommonConstant.STATUS_SUCCESS) {
          showSuccessIndicator("Success");
          Navigator.of(context).pop(true);
        } else if (responseModel.status == CommonConstant.STATUS_FAILED) {
          showSnackBar(context, 'Failed to create event, please try again.', Colors.red, Colors.white);
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

  Future<List<StateModel>> getStateList(BuildContext context) async {
    ApiProvider _provider = new ApiProvider();

    try {
      final response = await _provider.post("/location/get-state-list", {});
      stateModelList =
          (response as List).map((data) => StateModel.fromJson(data)).toList();
      // items.addAll(DropdownMenuItem(ampamtTherapiesModelList));
    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
      // _scaffoldKey.currentState.ScaffoldMessenger.showSnackBar(snackBar);
    }
    return stateModelList;
  }

  Future<List<CityModel>> getCityList(BuildContext context, String stateCode) async {
    ApiProvider _provider = new ApiProvider();
    Map<String, dynamic> locationForm = new Map<String, String>();
    locationForm = {
      'stateCode': stateCode,
    };
    try {
      final response =
      await _provider.post("/location/get-city-list", locationForm);
      cityModellList =
          (response as List).map((data) => CityModel.fromJson(data)).toList();
      setState(() => {cityModellList = cityModellList,isLoadingCity=false});
      // items.addAll(DropdownMenuItem(ampamtTherapiesModelList));
    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
      // _scaffoldKey.currentState.ScaffoldMessenger.showSnackBar(snackBar);
    }
    return cityModellList;
  }
  Widget buildCityList(List<CityModel> cityModelList) {

    return DropdownButtonFormField<CityModel>(
      itemHeight: 100,
      onSaved: (value) {
        debugPrint('values=$value');
      },
      validator: (value) => value == null ? 'Please select city' : null,
      style: TextStyle(
      ),
      dropdownColor: CompanyStyle.primaryColor,
      elevation: 9,
      items:
      cityModelList.map<DropdownMenuItem<CityModel>>((CityModel value) {
        return DropdownMenuItem<CityModel>(
          value: value,
          child: Text(value.cityName),
        );
      }).toList(),
      onChanged: (CityModel value) {
        debugPrint('StateModel=$value');
        debugPrint('cityCode=${value.cityCode}');
        debugPrint('cityName=${value.cityName}');
        setState(() => {
          selectedCityCode = value.cityCode,
          selectedCityName=value.cityName,

        });

      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.apartment, color: Colors.white),
        labelText: "Select City*",
        labelStyle: getInputFieldStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0),),
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
      ),
    );
  }
  Widget buildStateList(List<StateModel> stateModelList) {

    return DropdownButtonFormField<StateModel>(
      itemHeight: 100,
      onSaved: (value) {
        debugPrint('values=$value');
      },
      validator: (value) => value == null ? 'Please select state' : null,
      style: TextStyle(
      ),
      dropdownColor: CompanyStyle.primaryColor,
      elevation: 9,
      items:
      stateModelList.map<DropdownMenuItem<StateModel>>((StateModel value) {
        return DropdownMenuItem<StateModel>(
          value: value,
          child: Text(value.stateName),
        );
      }).toList(),
      onChanged: (StateModel value) {
        debugPrint('StateModel=$value');
        debugPrint('stateCode=${value.stateCode}');
        debugPrint('stateName=${value.stateName}');
        setState(() => {
          selectedStateCode = value.stateCode,
          selectedStateName=value.stateName,
          isLoadingCity=true
        });
        getCityList(context, value.stateCode);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.apartment, color: Colors.white),
        labelText: "Select State*",
        labelStyle: getInputFieldStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0),),
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
      ),
    );
  }
  static getInputFieldStyle() {
    return TextStyle(color: Colors.grey[350], fontSize: screenWidth / 25);
  }

  void createEvent(Map<String, dynamic> eventReqBody) async{
    debugPrint('before submitting='+eventReqBody.toString());
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    SuccessModel successModel;

    try {
      final response = await _provider.post("/event/create-event", eventReqBody);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      successModel = SuccessModel.fromJson(response);
      setState(() {
        isDataProcessed = false;
      });
      if (successModel != null) {
        if (successModel.status == CommonConstant.STATUS_SUCCESS && !CommonUtil.isBlank(successModel.id)) {
          _formKey.currentState.reset();
          // showSnackBar(context, 'Event Created Successfully, Please Login', Colors.green, Colors.white);
          uploadImageOnServer(imageUploadModel, successModel.id);

        } else if (successModel.status == CommonConstant.STATUS_FAILED) {
          showSnackBar(context, 'Failed To Create Event, please try again.', Colors.red, Colors.white);
        } else {
          showSnackBar(context, 'Something went wrong please try again.', Colors.red, Colors.white);
        }
      }else{
        showSnackBar(context, 'Something went wrong please try again.', Colors.red, Colors.white);
      }
    } catch (e) {
      setState(() {
        isDataProcessed = false;
      });
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
  }
}
