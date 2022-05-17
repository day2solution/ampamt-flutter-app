import 'package:ampamt/config/BaseConfig.dart';

class ProdConfig implements BaseConfig {
  String get apiHost => "www.ampamt.com";
  bool get reportErrors => true;
  bool get trackEvents => true;
  bool get useHttps => true;
}