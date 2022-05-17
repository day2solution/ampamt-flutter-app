import 'package:ampamt/config/BaseConfig.dart';

class DevConfig implements BaseConfig {
  String get apiHost => "192.168.0.151";

  bool get reportErrors => false;

  bool get trackEvents => false;

  bool get useHttps => false;
}