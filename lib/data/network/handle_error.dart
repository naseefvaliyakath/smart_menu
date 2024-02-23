import 'dart:developer';
import 'package:get/get.dart';
import 'package:smart_menu/data/network/report_error.dart';
import '../../presentation/check_internet/check_internet.dart';
import '../../presentation/controller/login_controller.dart';
import '../../presentation/widget/snack_bar.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  static const String environment = 'development'; // or 'production' 'development

  static Future<void> handleError(dynamic error,
      {bool isDioError = false, String? page, String? method, showSnack = true}) async {
    String userId = Get.find<LoginController>().myShop.shopId.toString() ?? '0';

    bool hasInternet = await checkInternetConnection(showSnack: showSnack);
    if (hasInternet) {
      if (environment == 'development') {
        String? errorMessage =
            isDioError && error is DioException ? getUserFriendlyMessage(error.type.toString()) : error.toString();
        if (hasInternet) {
          if (showSnack) {
            AppSnackBar.errorSnackBar('Error', errorMessage);
          }
        }

        log('Error in $page  from $method : $error');
        throw error;
      } else {
        // In production, show an error snack-bar with an appropriate message
        String? errorMessage =
            isDioError && error is DioException ? getUserFriendlyMessage(error.type.toString()) : error.toString();
        if (hasInternet) {
          if (showSnack) {
            AppSnackBar.errorSnackBar('Error', errorMessage);
          }
        }
        // Additionally, report the error to the database
        ErrorReporting.reportError(
          page: page,
          method: method,
          userId: userId,
          errorMessage: errorMessage,
        );
      }
    }
  }

  static String getUserFriendlyMessage(dynamic errorType) {
    switch (errorType) {
      case 'connectionTimeout':
        return 'Connection timeout. Please check your internet connection.';
      case 'sendTimeout':
        return 'Send timeout. Please try again later.';
      case 'receiveTimeout':
        return 'Receive timeout. Please check your network settings.';
      case 'badCertificate':
        return 'Security error: bad certificate. Please contact support.';
      case 'badResponse':
        return 'Received an invalid response from the server.';
      case 'cancel':
        return 'Request was cancelled.';
      case 'connectionError':
        return 'Connection error. Unable to connect to the server.';
      case 'unknown':
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }
}
