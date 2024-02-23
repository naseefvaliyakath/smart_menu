import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smart_menu/constants/app_constant_names.dart';
import '../../constants/url.dart';

class ErrorReporting {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin(); // Uncommented this line

  static Future<void> reportError({
    String? page,
    String? method,
    String? userId,
    String? errorMessage,
  }) async {
    //? Collect device and app information
    String appVersion = '';
    String deviceOs = '';
    String deviceBrand = '';
    String deviceModel = '';
    String? androidVersion;
    String? iosVersion;

    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;

      if (GetPlatform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceOs = 'Android';
        deviceBrand = androidInfo.brand ?? '';
        deviceModel = androidInfo.model ?? '';
        androidVersion = androidInfo.version.release;
      } else if (GetPlatform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceOs = 'iOS';
        deviceBrand = 'Apple';
        deviceModel = iosInfo.utsname.machine ?? '';
        iosVersion = iosInfo.systemVersion;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching device or app info: $e');
      }
    }

    // Prepare the body
    final body = {
      'page': page,
      'method': method,
      'userId': userId,
      'errorMessage': errorMessage,
      'appVersion': appVersion,
      'androidVersion': androidVersion ?? '',
      'iosVersion': iosVersion ?? '',
      'deviceOs': deviceOs,
      'deviceBrand': deviceBrand,
      'deviceModel': deviceModel,
    };

    //? Sending to server
    try {
      final response = await GetConnect().post('${BASE_URL}error', body,headers: {"Authorization": "Bearer $STATIC_TOKEN"});
      if (kDebugMode) {
        print('Error report sent successfully: ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to send error report: $e');
      }
    }
  }
}
