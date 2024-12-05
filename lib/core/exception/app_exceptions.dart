import 'package:dio/dio.dart';
import 'package:sportRex/core/data/serverRespond.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/core/util/appUtil/logger.dart';


///App exception exception handle custom exception from the server

final logger = getLogger("AppException");

class AppException implements Exception {
  final String? _message;

  AppException([this._message]);

  @override
  String toString() {
    return "$_message";
  }

  ///Handle dio error and throw App exception
  static Future<ServerResponse?> handleError(DioException e) async {
    if (!isObjectEmpty(e.response)) {
      if (e.response!.data is Map<String, dynamic>) {
        ServerResponse response = ServerResponse.fromJson(e.response!.data);
        return response;
      }

      throw AppException('Please try again');
    }
    throw AppException(handleExceptionError(e.type));
  }
}

class ErrorOtpException extends AppException {
  ErrorOtpException([String? message]) : super(message);
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message);
}

String handleExceptionError(DioExceptionType errorType) {
  switch (errorType) {
    case DioExceptionType.connectionTimeout:
      return "Please check your internet connection.";

    case DioExceptionType.sendTimeout:
      return "Sending timeout -Please try again";

    case DioExceptionType.receiveTimeout:
      return "Receiving timeout -Please try again";

    case DioExceptionType.badCertificate:
      return "Error Please Try again";

    case DioExceptionType.badResponse:
      return "Error please try again";

    case DioExceptionType.cancel:
      return " please try again";

    case DioExceptionType.connectionError:
      return "Please check your internet connection.";

    case DioExceptionType.unknown:
      return "Oops! Something went wrong, please try again later.";

    default:
      return "Oops! Something went wrong, please try again later.";
  }
}
