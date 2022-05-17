import 'package:ampamt/config/BaseConfig.dart';
import 'package:ampamt/config/dev-config.dart';
import 'package:ampamt/config/prod-config.dart';
import 'package:ampamt/config/test-config.dart';
import 'package:flutter/cupertino.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }
  static const apiurl = '/ampamt-moduler/rest' ;
  static const production=true;
  static bool isProduction = bool.fromEnvironment('dart.vm.product');
  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  static const String TEST = 'TEST';
  static const String PROD = 'PROD';

  BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    debugPrint('environment='+environment);
    if(isProduction){
      return ProdConfig();
    }
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      case Environment.TEST:
        return TestConfig();
      default:
        return DevConfig();
    }

  }
}