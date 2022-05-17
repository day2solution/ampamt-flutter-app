import 'dart:async';
import 'package:ampamt/CustomResponseModel.dart';
import 'package:ampamt/dashboard/repository/DoctorRepository.dart';
import 'package:ampamt/model/doctor/DoctorDocumentsModel.dart';

import 'package:ampamt/model/doctor/DoctorsAccountDetailsModel.dart';

class DoctorBloc {
  DoctorRepository _doctorRepository;
  StreamController _doctorDataController;


  StreamController _doctorDocumentController;

  StreamSink<CustomResponseModel<List<DoctorsAccountDetailsModel>>> get doctorDataSink =>
      _doctorDataController.sink;

  Stream<CustomResponseModel<List<DoctorsAccountDetailsModel>>> get doctorDataStream =>
      _doctorDataController.stream;

  StreamSink<CustomResponseModel<List<DoctorDocumentsModel>>> get doctorDocumentSink =>
      _doctorDocumentController.sink;

  Stream<CustomResponseModel<List<DoctorDocumentsModel>>> get doctorDocumentStream =>
      _doctorDocumentController.stream;

  DoctorBloc() {
    _doctorDataController = StreamController<CustomResponseModel<List<DoctorsAccountDetailsModel>>>();
    _doctorDocumentController=StreamController<CustomResponseModel<List<DoctorDocumentsModel>>>();
    _doctorRepository = DoctorRepository();

  }

  Future<List<DoctorsAccountDetailsModel>> getDoctorAccountById(dynamic _data) async {
    doctorDataSink.add(CustomResponseModel.loading('Getting User Count'));
    List<DoctorsAccountDetailsModel> doctorList;
    try {
     doctorList = await _doctorRepository.getDoctorAccountDetailById(_data);
      doctorDataSink.add(CustomResponseModel.completed(doctorList));

    } catch (e) {
      doctorDataSink.add(CustomResponseModel.error(e.toString()));
      print(e);
    }
    return doctorList;
  }
  Future<List<DoctorDocumentsModel>> getDoctorDocumentsDetails(dynamic _data) async {
    doctorDocumentSink.add(CustomResponseModel.loading('Getting User Count'));
    List<DoctorDocumentsModel> doctorList;
    try {
     doctorList = await _doctorRepository.getDoctorDocumentsDetails(_data);
      doctorDocumentSink.add(CustomResponseModel.completed(doctorList));

    } catch (e) {
      doctorDocumentSink.add(CustomResponseModel.error(e.toString()));
      print(e);
    }

    return doctorList;
  }
  dispose() {
    _doctorDataController?.close();
  }

  void getBusinessAccountById(Map<String, dynamic> reqBody) {

  }
}