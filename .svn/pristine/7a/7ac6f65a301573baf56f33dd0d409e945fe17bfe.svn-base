import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/dashboard/admin/advertisement/add-advertisements.dart';
import 'package:ampamt/model/advertisement/advertisements-model.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ManageAdvertisements extends StatefulWidget {
  final String accountId;
  ManageAdvertisements({this.accountId}) : super();
  @override
  _ManageAdvertisementsState createState() => _ManageAdvertisementsState(accountId: accountId);
}

class _ManageAdvertisementsState extends State<ManageAdvertisements> {
  final String accountId;
  _ManageAdvertisementsState({this.accountId}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  Future<List<AdvertisementsModel>> futureAdvertisementsModelList;

  List<AdvertisementsModel> advertisementsModelList = [];

  @override
  void initState() {
    debugPrint('getting event list');
    super.initState();
    debugPrint('accountId=$accountId');
    futureAdvertisementsModelList=getAdvertisementsList();
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

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
                  'Manage Advertisements',
                  style: TextStyle(fontSize: screenWidth / 20),
                ))
          ],
        ),
      ),
      body: Container(
        child: Column(

          children: [
            Container(
              color: CompanyStyle.primaryColor[200],
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Advertisement(s)',  style: TextStyle(fontSize: screenWidth/25,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ElevatedButton(
                        style: CompanyStyle.getButtonStyle(),
                        child:Text(
                          'Refresh',
                          style:
                          TextStyle(fontSize: screenWidth / 30),
                        ),
                        onPressed: (){
                          setState(() {
                            futureAdvertisementsModelList=getAdvertisementsList();
                          });

                        },
                      ),
                      SizedBox(width: 5,),
                      ElevatedButton(
                        style: CompanyStyle.getButtonStyle(),
                        child:Text(
                          'Add Advertisement',
                          style:
                          TextStyle(fontSize: screenWidth / 30),
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAdvertisements(accountId: accountId)));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child:Container(
                padding:EdgeInsets.all(10),
                child:FutureBuilder(
                    future: futureAdvertisementsModelList,
                    builder: (context,AsyncSnapshot snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return CommonUtil.showLoading("Loading Advertisements...",context);
                      }else if(snapshot.hasError){
                        print('error at haserror');
                        return Text('Error occurred');
                      }
                      else{
                        if(snapshot.data!=null && snapshot.data.length>0){
                          return ListView.builder(
                              itemCount:snapshot.data.length ,
                              itemBuilder: (context,int index){
                                return buildAdvertisementsCards(snapshot.data[index]);
                              });
                        }else{
                          return CommonUtil.getEmptyMsg("Advertisements not found", context);
                        }
                      }
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<AdvertisementsModel>> getAdvertisementsList() async {
    ApiProvider _provider = new ApiProvider();
    Map<String, dynamic> eventMap = new Map<String, String>();

    try {
      final response = await _provider.post("/advertisement/get-advertisement-list", eventMap);
      advertisementsModelList = (response as List).map((data) => AdvertisementsModel.fromJson(data)).toList();
    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
    }
    return advertisementsModelList;
  }
  SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor) {
    return SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgcolor);
  }

  Widget buildAdvertisementsCards(AdvertisementsModel advertisementsModel) {
    return Container(

      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: CompanyStyle.primaryColor[1003].withOpacity(0.2),
              width: 2,
            )
        ),
        color: CompanyStyle.primaryColor,
        child: Column(

          children: [
            CommonUtil.getImageFromBase64CustSize(advertisementsModel.extras, screenWidth,screenHeight/5),
            Container(
              padding:EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start ,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 5,),
                        Text(CommonUtil.getDDMMMYYYYStringDate(advertisementsModel.createDate)),
                        SizedBox(width: 5,),
                        TextButton(
                          onPressed: (){
                            downloadFile(advertisementsModel.advId,advertisementsModel.extras,context);
                        },
                          child: Icon(Icons.file_download,color: Colors.blue,), ),
                        TextButton(
                          onPressed: (){
                          _onWillPop(advertisementsModel);
                        }, child: Icon(Icons.delete_forever,color: Colors.red,), ),
                      ],
                    ),
                  ),

                ],
              ),
            ),


          ],
        ),
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
  void deleteAdvertisements(AdvertisementsModel advertisementsModel) async{
    Map<String, dynamic> deleteForm = new Map<String, String>();
    deleteForm={
      'advId':advertisementsModel.advId,
      'extras':advertisementsModel.extras,
      'createDate':advertisementsModel.createDate,
      'accountId':advertisementsModel.accountId,
      'imageName':advertisementsModel.imageName,
      'displayFlag':advertisementsModel.displayFlag,
    };
    debugPrint('advertisements deleteForm='+deleteForm.toString());
    ApiProvider _provider = new ApiProvider();
    showProgressIndicator("Processing...");
    SuccessModel responseModel;
    try {
      final response = await _provider.post("/advertisement/delete-advertisement", deleteForm);
      responseModel = SuccessModel.fromJson(response);

      dismissProgressIndicator();
      if (responseModel != null) {
        if (responseModel.status == CommonConstant.STATUS_SUCCESS) {
          showSuccessIndicator("Success");
          setState(() {
            futureAdvertisementsModelList=getAdvertisementsList();
          });

        } else if (responseModel.status == CommonConstant.STATUS_FAILED) {
          showSnackBar(context, 'Failed to delete advertisement, please try again.', Colors.red, Colors.white,1000);
        } else {
          showSnackBar(context, 'Something went wrong please try again.', Colors.red, Colors.white,1000);
        }
      }else{
        showSnackBar(context, 'Something went wrong please try again.', Colors.red, Colors.white,1000);
      }
    } catch (e) {
      dismissProgressIndicator();
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white,1000);
    }
  }
Future<bool> _onWillPop(AdvertisementsModel advertisementsModel) async {
  return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          backgroundColor: CompanyStyle.primaryColor,
          title: new Text('Are you sure?'),
          content: new Text('Do you want to delete this advertisement ?'),
          actions: <Widget>[
            new TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('No',style: TextStyle(color: Colors.green)),
            ),
            new TextButton(
              onPressed: () {
                    Navigator.of(context).pop(false);
                    deleteAdvertisements(advertisementsModel);
              },
              child: new Text('Yes',style: TextStyle(color: Colors.red),),
            ),
          ],
        ),
      )) ??
      false;
}

  void downloadFile(String fileName,String base64ImgFile,BuildContext context) async{
   bool saveStatus= await CommonUtil.createFolderInAppDocDir(fileName,base64ImgFile,"ADVERTISEMENT",null,".jpg");

    debugPrint('file saved and saveStatus=$saveStatus');
    if(saveStatus){
      showSnackBar(context, 'Saved', Colors.green, Colors.white,200);
    }else{
      showSnackBar(context, 'Failed', Colors.red, Colors.white,200);
    }

  }
}