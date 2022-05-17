import 'package:ampamt/CustomException.dart';
import 'package:ampamt/config/environment.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http_interceptor/http_interceptor.dart';

class ApiProvider {

  final String _baseUrl = Environment.apiurl;
  final String apiHost = Environment().config.apiHost;
  final bool useHttps = Environment().config.useHttps;

  Future<dynamic> post(String url,dynamic body) async {
    debugPrint('apiHost=$apiHost useHttps=$useHttps');
    var responseJson;
    try {
      final response = await http.post(useHttps?Uri.https(apiHost,_baseUrl+ url):Uri.http(apiHost,_baseUrl+ url),
          headers: {
                    'Authorization': 'token',
                    'Ip':'Ip',
                    'Application':'AMPAMT',
                    'Platform':'ANDROID',
                    "content-type" : "application/json",
                    "accept" : "application/json",
                  },
          body: jsonEncode(body)
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }catch(e){
      throw FetchDataException(e);
    }
    return responseJson;
  }
  Future<dynamic> postAppUpdateData(String url,dynamic body) async {
    var responseJson;
    try {
      final response = await http.post(Uri.https('www.ampamt.com',"/assets/update/ampamt-app-update.json"),
          headers: {
            'Authorization': 'token',
            'Ip':'Ip',
            'Application':'AMPAMT',
            'Platform':'ANDROID',
            "content-type" : "application/json",
            "accept" : "application/json",
          },
          body: jsonEncode(body)
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }catch(e){
      throw FetchDataException(e);
    }
    return responseJson;
  }
  dynamic _response(http.Response response) {
    http.Request request=response.request;
    debugPrint('request Body *******************> '+ request.body);
    debugPrint('request URL *******************> '+ response.request.url.toString());
    debugPrint('request headers *******************> '+response.request.headers.toString());
    debugPrint('response Body *******************> '+response.body.toString());
    debugPrint('statusCode *******************> '+response.statusCode.toString());
    String error='Server Error : '+response.statusCode.toString();
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(error);
      case 401:

      case 403:
        throw UnauthorisedException(error);
      case 500:
        throw InternalServerError(error);
      case 404:
        throw NotFound(error);

      default:
        throw FetchDataException(
            'Error : ${response.statusCode}');
    }
  }


}

class WeatherApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    try {

      data.params['units'] = 'metric';
      data.headers[HttpHeaders.contentTypeHeader] = "application/json";
    } catch (e) {
      debugPrint(e);
    }
    // print(data.params.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async => data;
}