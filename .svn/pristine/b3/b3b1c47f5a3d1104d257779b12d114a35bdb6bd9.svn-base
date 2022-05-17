import 'dart:async';
import 'package:ampamt/ChuckRepository.dart';
import 'package:ampamt/CustomResponseModel.dart';
import 'package:ampamt/SuccessModel.dart';

class ChuckBloc {
  ChuckRepository _chuckRepository;
  StreamController _chuckDataController;

  StreamSink<CustomResponseModel<SuccessModel>> get chuckDataSink =>
      _chuckDataController.sink;

  Stream<CustomResponseModel<SuccessModel>> get chuckDataStream =>
      _chuckDataController.stream;

  ChuckBloc() {
    _chuckDataController = StreamController<CustomResponseModel<SuccessModel>>();
    _chuckRepository = ChuckRepository();

  }

  getuserCount() async {
    chuckDataSink.add(CustomResponseModel.loading('Getting User Count'));
    try {
      SuccessModel successModel = await _chuckRepository.getuserCount();
      chuckDataSink.add(CustomResponseModel.completed(successModel));
    } catch (e) {
      chuckDataSink.add(CustomResponseModel.error(e.toString()));
      print(e);
    }
  }
  Future<SuccessModel> doctorAccountLogin(dynamic _loginData) async {
    chuckDataSink.add(CustomResponseModel.loading('Getting User Count'));
    try {
      SuccessModel successModel = await _chuckRepository.doctorAccountLogin(_loginData);
      chuckDataSink.add(CustomResponseModel.completed(successModel));
    } catch (e) {
      chuckDataSink.add(CustomResponseModel.error(e.toString()));
      print(e);
    }
  }
  dispose() {
    _chuckDataController?.close();
  }
}