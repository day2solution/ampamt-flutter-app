// import 'dart:convert';

import 'package:ampamt/ApiProvider.dart';
// import 'package:ampamt/SuccessModel.dart';

import 'dart:async';

import 'package:ampamt/model/doctor/DoctorAccountStatusModel.dart';
import 'package:ampamt/model/doctor/DoctorDocumentsModel.dart';
import 'package:ampamt/model/doctor/DoctorsAccountDetailsModel.dart';

class DoctorRepository {
  ApiProvider _provider = ApiProvider();

  Future<List<DoctorAccountStatusModel>> getDoctorsAccListByStatus() async {
    final response = await _provider.post("/account/get-doctor-acc-list-status2",{});
    List<DoctorAccountStatusModel> doctorAccountStatusModelList = (response as List).map((data) => DoctorAccountStatusModel.fromJson(data)).toList();
    print('length='+doctorAccountStatusModelList.length.toString());
    return doctorAccountStatusModelList;
  }

  Future<List<DoctorsAccountDetailsModel>> getDoctorAccountDetailById(dynamic _data) async {
    final response = await _provider.post("/account/get-doctor-detail",_data);
    List<DoctorsAccountDetailsModel> doctorsAccountDetailsModelList = (response as List).map((data) => DoctorsAccountDetailsModel.fromJson(data)).toList();
    print('length='+doctorsAccountDetailsModelList.length.toString());
    return doctorsAccountDetailsModelList;
  }

  Future<List<DoctorDocumentsModel>> getDoctorDocumentsDetails(dynamic _data) async {
    final response = await _provider.post("/account/get-doc-document-detail",_data);
    List<DoctorDocumentsModel> doctorDocumentsModelList = (response as List).map((data) => DoctorDocumentsModel.fromJson(data)).toList();
    print('length='+doctorDocumentsModelList.length.toString());
    return doctorDocumentsModelList;
  }
}