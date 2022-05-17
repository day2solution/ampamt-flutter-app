import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomException implements Exception {
  final _message;
  final _description;
  BuildContext context;

  CustomException([this._message, this._description]);

  String toString() {
    print('_description=$_description _message=$_message');
    return ("$_message $_description".toString());
  }
}


class FetchDataException extends CustomException {
  FetchDataException([String message])
      : super(message, "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid/Bad Request");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String message]) : super(message, "Invalid Input");
}

class InternalServerError extends CustomException {
  InternalServerError([String message]) : super(message, "Internal Server Error");
}
class NotFound extends CustomException {
  NotFound([String message]) : super(message, "Not Found");
}
class MethodNotAllowed extends CustomException {
  MethodNotAllowed([String message]) : super(message, "Method Not Allowed");
}