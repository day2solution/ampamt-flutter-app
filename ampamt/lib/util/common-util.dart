import 'dart:convert';
import 'dart:typed_data';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/loadingindicator/BarProgressIndicator.dart';
import 'package:ampamt/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
class CommonUtil{
  static double screenWidth;
  static double screenHeight;
  static MediaQueryData _mediaQueryData;

  // static DateTime intToDate(int number){
  //   return new DateTime.fromMicrosecondsSinceEpoch(number*1000);
  // }
  static DateTime stringToDate(String date){
    return new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date);
  }
  static getTimeStampToStringDate(int number){
    var date=new DateTime.fromMicrosecondsSinceEpoch(number*1000);
    return new DateFormat('dd MMM yyyy').format(date);
  }
  static getYYYYMMDDStringDate(String date){
    DateTime dateTime=DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date);
    DateFormat outputFormat =new DateFormat('yyyy-MM-dd');
    String outputDate = outputFormat.format(dateTime);
    return  outputDate;
  }
  static getYYYYMMMDDStringDate(String date){
    DateTime dateTime=DateFormat("yyyy-MM-dd").parse(date);
    DateFormat outputFormat =new DateFormat('dd-MMM-yyyy');
    String outputDate = outputFormat.format(dateTime);
    return  outputDate;
  }
  static getDDMMMYYYYStringDate(String date){
    if(isBlank(date)){
      return "-";
    }
    DateTime dateTime=DateFormat("yyyy-MM-dd").parse(date);
    DateFormat outputFormat =new DateFormat('dd-MMM-yyyy');
    String outputDate = outputFormat.format(dateTime);
    return  outputDate;
  }
  static String convertToTitleCase(String text) {

      debugPrint('text to capitalize=$text');
      if (isBlank(text)) {
        return "";
      }else{
        if (text.length <= 1) {
          return text.toUpperCase();
        }
      }
      text=text.trim().replaceAll(RegExp(' +'), ' ');
      final List<String> words = text.split(' ');
      final capitalizedWords = words.map((word) {
      final String firstLetter = word.substring(0, 1).toUpperCase();
      final String remainingLetters = word.substring(1).toLowerCase();
      return '$firstLetter$remainingLetters';
    });

    return capitalizedWords.join(' ');
  }

  static String convertToTitleCaseReturnDash(String text) {

    debugPrint('text to capitalize=$text');
    if (text == null) {
      return "-";
    }

    if (text.length <= 1) {
      return text.toUpperCase();
    }
    text=text.trim().replaceAll(RegExp(' +'), ' ');
    final List<String> words = text.split(' ');
    debugPrint('words=$words');
    final capitalizedWords = words.map((word) {
      final String firstLetter = word.substring(0, 1).toUpperCase();
      final String remainingLetters = word.substring(1).toLowerCase();
      return '$firstLetter$remainingLetters';
    });

    return capitalizedWords.join(' ');
  }

  static Future<String> convertImgToBase64Str(XFile pfile) async{
    String base64Image="";
    File file=File (pfile.path);
    File futureFile= await testCompressAndGetFile(file);
    base64Image = base64Encode(futureFile.readAsBytesSync());
   return base64Image;
  }
  static Future<File> testCompressAndGetFile(File file) async {
    int imgQuality=100;
    double ogFileSize=file.lengthSync()/1024;
    debugPrint("image original size in KB="+ogFileSize.toString()+" KB");

    if(ogFileSize>100 && ogFileSize<200){
      imgQuality=90;
    }
    if(ogFileSize>200 && ogFileSize<300){
      imgQuality=80;
    }
    if(ogFileSize>300 && ogFileSize<400){
      imgQuality=70;
    }
    if(ogFileSize>400){
      imgQuality=30;
    }
    ogFileSize=ogFileSize/1024;
    debugPrint("image original size in MB="+ogFileSize.toString()+" MB");
    debugPrint('imgQuality=$imgQuality');
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: imgQuality, percentage: 100);

    ogFileSize=compressedFile.lengthSync()/1024;
    debugPrint("image compressed size in KB="+ogFileSize.toString()+" KB");
    ogFileSize=ogFileSize/1024;
    debugPrint("image compressed size in MB="+ogFileSize.toString()+" MB");
    return compressedFile;
  }

  static Widget getImage(String base64String,BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    var image;
    if(base64String!=null && base64String!=""){
      String finalImg=base64String.split(",")[1];
      image = Base64Decoder().convert(finalImg);
      return Container(
        alignment: Alignment.center,
        height: screenWidth/4,
        width: screenWidth/4,
        child: Image.memory(
          image,
          alignment : Alignment.center,
          repeat: ImageRepeat.noRepeat,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      );
      // Image.memory(image, width: screenWidth/4, height: screenWidth/4,fit: BoxFit.contain,)

    }else {
      return Image.asset('assets/images/dashboard/other/no_image.jpg',width: screenWidth/4,height: screenWidth/4,);
    }
  }

  static Widget getImageFromBase64FillSize(String base64String,BuildContext context){
    // debugPrint('in getImageFromBase64FillSize base64String='+base64String);
    // _mediaQueryData = MediaQuery.of(context);
    // screenWidth = _mediaQueryData.size.width;
    // screenHeight = _mediaQueryData.size.height;
    var image;
    if(base64String!=null && base64String!=""){
      String finalImg=base64String.split(",")[1];
      image = Base64Decoder().convert(finalImg);
      return Image.memory(
        image,
        alignment : Alignment.center,
        repeat: ImageRepeat.noRepeat,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      );
    }else{
      return Image.asset(
        'assets/images/dashboard/other/no_image.jpg',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      );
    }
  }

  static Widget getImageFromBase64CustSize(String base64String,double screenWidth,double screenHeight){

    var image;
    if(base64String!=null && base64String!=""){
      String finalImg=base64String.split(",")[1];
      image = Base64Decoder().convert(finalImg);
      return Image.memory(
        image,
        alignment : Alignment.center,
        repeat: ImageRepeat.noRepeat,
        height: screenHeight,
        width: screenWidth,
        fit: BoxFit.fill,
      );
    }else{
      return Image.asset(
        'assets/images/dashboard/other/no_image.jpg',
        height: screenHeight,
        width: screenWidth,
        fit: BoxFit.fill,
      );
    }
  }
  static bool isValidEmail(String input) {
    debugPrint("validating");
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
  }

  static bool isEqualBothString(String input1,String input2) {
    debugPrint('input1=$input1 input2=$input2');
    if(!isBlank(input1) && !isBlank(input2)){
      if(input1.toLowerCase().trim()==input2.toLowerCase().trim()){
        debugPrint('true found');
        return true;
      }else{
        return false;
      }
    }
    else{
      return false;
    }
  }
  static Widget getImgFromBase64OriginalSizeNoSplit(String base64String,BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    var image;
    if(base64String!=null && base64String!=""){


      image = Base64Decoder().convert(base64String);

      return Image.memory(
        image,
        alignment : Alignment.center,
        repeat: ImageRepeat.noRepeat,

        // fit: BoxFit.fill,
      );
      // Image.memory(image, width: screenWidth/4, height: screenWidth/4,fit: BoxFit.contain,)

    }else{
      return Image.asset('assets/images/dashboard/other/no_image.jpg',width: screenWidth/4,height: screenWidth/4,);
    }
  }

  static Widget getImgFromBase64FillSizeNoSplit(String base64String,BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    var image;
    if(base64String!=null && base64String!=""){


      image = Base64Decoder().convert(base64String);

      return Image.memory(
        image,
        alignment : Alignment.center,
        repeat: ImageRepeat.noRepeat,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.fill,
      );
      // Image.memory(image, width: screenWidth/4, height: screenWidth/4,fit: BoxFit.contain,)

    }else{
      return Image.asset('assets/images/dashboard/other/no_image.jpg',width: screenWidth/4,height: screenWidth/4,);
    }
  }
  static Widget getImageFromBase64OriginalSize(String base64String,BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    var image;
    if(base64String!=null && base64String!=""){
      List<String> list=base64String.split(",");
      debugPrint(list.toString());
      String finalImg="";
      if(list[0].startsWith("data:image/jpeg;")){
        finalImg=list[1];
      }else{
        finalImg=list[0];
      }

      image = Base64Decoder().convert(finalImg);

      return Image.memory(
        image,
        alignment : Alignment.center,
        repeat: ImageRepeat.noRepeat,

        // fit: BoxFit.fill,
      );
      // Image.memory(image, width: screenWidth/4, height: screenWidth/4,fit: BoxFit.contain,)

    }else{
      return Image.asset('assets/images/dashboard/other/no_image.jpg',width: screenWidth/4,height: screenWidth/4,);
    }
  }
  static Widget getEmptyMsg(String msg,BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 5,),
        SvgPicture.asset('assets/svg/empty_box.svg',width: screenWidth/4,height: screenWidth/4),
        SizedBox(height: 5,),
        Text(msg),
    ],);
  }

  static Widget getExcelSvgImg(String msg,BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/svg/excel_img.svg',width: screenWidth/4,height: screenWidth/4),
      ],);
  }
  static Future<String> getVersionCode() async{
    String projectVersion="";
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      debugPrint('packageName=${packageInfo.packageName}');
      debugPrint('buildNumber=${packageInfo.buildNumber}');
      debugPrint('projectVersion=${packageInfo.version}');
      projectVersion=await packageInfo.version;
      debugPrint('appName=${packageInfo.appName}');
    } on PlatformException {
      projectVersion = 'Failed to get build number.';
    }
    return projectVersion;
  }

  static Future<String> getProjectCode() async{
    String buildNumber="2052";
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // projectCode = await GetVersion.projectCode;
      buildNumber = packageInfo.buildNumber;
      debugPrint('buildNumber=${buildNumber}');

    } on PlatformException {
      debugPrint('Failed to get build number.');
      buildNumber = '2052';
    }
    return buildNumber;
  }
  static bool isNumericOnly(String text){
    if(isBlank(text)) {
      return false;
    }
    return double.tryParse(text)!=null;
  }
  static Widget showLoading(String msg,BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    if(isBlank(msg)){
      msg="Loading Details..";
    }
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
          Text(msg,style: TextStyle(fontSize: screenWidth/20),),
        ],
      ),
    );
  }
  static Widget showLinearProgressLoading(String msg,BuildContext context) {
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
static bool isBlank(String text){
  debugPrint("text=$text");
    if(text==null || text==""){
      return true;
    }
    return false;
}
  static bool isAlphaNumericOnly(String text){
    debugPrint("text=$text");
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text);
  }
  static Future<bool> createFolderInAppDocDir(String fileName,String base64ImgFile,String path,String accountId,String extension) async {
    //Get this App Document Directory
    bool saveStatus=true;
    String finalPath=CommonConstant.AMPAMT;
    if(!isBlank(path)){
      finalPath=finalPath+'/$path';
    }
  if(isBlank(extension)){
    extension=".jpg";
  }
    if(!isBlank(accountId)){
      finalPath=finalPath+'/$accountId';
    }
    debugPrint('createFolderInAppDocDir called='+finalPath);
    final List<Directory> result = await getExternalStorageDirectories();

    debugPrint('result length='+result.length.toString());
    debugPrint('final path='+result[0].path);

    Directory _appDocDirFolder =  Directory('${result[0].path}/$finalPath/');
    Uint8List bytes = base64.decode(base64ImgFile.split(",")[1]);
    if(await _appDocDirFolder.exists()){
      File file = File("${_appDocDirFolder.path}/${fileName+extension}");
      await file.writeAsBytes(bytes);
    }else{
      Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
      File file = File("${_appDocDirNewFolder.path}/${fileName+extension}");
      await file.writeAsBytes(bytes);
    }

    return saveStatus;
  }

  static Future<String> createFolderInAppDocDirStr(String fileName,String base64ImgFile,String path,String accountId,String extension) async {
    //Get this App Document Directory
    // bool saveStatus=true;
    String finalPath=CommonConstant.AMPAMT;
    if(!isBlank(path)){
      finalPath=finalPath+'/$path';
    }
    if(isBlank(extension)){
      extension=".jpg";
    }
    if(!isBlank(accountId)){
      finalPath=finalPath+'/$accountId';
    }
    debugPrint('createFolderInAppDocDir called='+finalPath);
    final List<Directory> result = await getExternalStorageDirectories();

    debugPrint('result length='+result.length.toString());
    debugPrint('final path='+result[0].path);

    Directory _appDocDirFolder =  Directory('${result[0].path}/$finalPath');
    Uint8List bytes = base64.decode(base64ImgFile.split(",")[1]);

    if(await _appDocDirFolder.exists()){
      File file = File("${_appDocDirFolder.path}/${fileName+extension}");
      await file.writeAsBytes(bytes);
      debugPrint('_appDocDirFolder path='+_appDocDirFolder.path);
      debugPrint('_appDocDirFolder path='+file.path);
      return file.path;
    }else{
      Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
      File file = File("${_appDocDirNewFolder.path}/${fileName+extension}");
      await file.writeAsBytes(bytes);
      debugPrint('_appDocDirNewFolder path='+_appDocDirNewFolder.path);
      return file.path;
    }
  }

  static String convertToIndianCurrency(double amount){
    NumberFormat format = NumberFormat.currency(locale: 'HI',symbol: '₹ ');
    return format.format(amount);
  }
}