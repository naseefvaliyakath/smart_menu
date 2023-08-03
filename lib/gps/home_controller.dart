import 'package:carp_background_location/carp_background_location.dart';
import 'package:get/get.dart';
import 'package:gps/snack_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dio_client.dart';
import 'model/api_response/api_response.dart';
import 'model/category/category.dart';

enum LocationStatus { UNKNOWN, INITIALIZED, RUNNING, STOPPED }

class LocationController extends GetxController {
  final DioClient _dioClient = Get.put(DioClient());

  //final DioClient _dioClient  = Get.find<DioClient>();
  final locationStatus = LocationStatus.INITIALIZED.obs;
  final currentLocation = Rxn<LocationDto>();

  @override
  void onInit() {
    super.onInit();

    LocationManager().interval = 1;
    LocationManager().distanceFilter = 0;
    LocationManager().notificationTitle = 'CARP Location Example';
    LocationManager().notificationMsg = 'CARP is tracking your location';

    locationStatus.value = LocationStatus.INITIALIZED;
  }

  void getCurrentLocation() async {
    currentLocation.value = await LocationManager().getCurrentLocation();
  }

  Future<bool> isLocationAlwaysGranted() async => await Permission.locationAlways.isGranted;

  Future<bool> askForLocationAlwaysPermission() async {
    bool granted = await Permission.locationAlways.isGranted;

    if (!granted) {
      granted = await Permission.locationAlways.request() == PermissionStatus.granted;
    }

    return granted;
  }

  void start() async {
    if (!await isLocationAlwaysGranted()) {
      await askForLocationAlwaysPermission();
    }

    LocationManager().locationStream.listen((location) {
      currentLocation.value = location;
      print('my col ${location.latitude}');
      Category caat =
          Category(0, location.latitude.toString(), 1, DateTime.now().toString(), DateTime.now().toString());
      addCategory(caat);
    });

    await LocationManager().start();
    locationStatus.value = LocationStatus.RUNNING;
  }

  void stop() {
    LocationManager().stop();
    locationStatus.value = LocationStatus.STOPPED;
  }

  @override
  void dispose() {
    super.dispose();
    LocationManager().stop();
  }

  Future<ApiResponse<Category>?> addCategory(Category category) async {
    try {
      final Map<String, dynamic> formDataMap = category.toJson();

      final response = await _dioClient.insertWithBody('category', formDataMap);

      final ApiResponse<Category> apiResponse = ApiResponse<Category>.fromJson(
        response.data,
        (json) => Category.fromJson(json as Map<String, dynamic>),
      );
      print('success');
    } catch (e) {
      print(e.toString());
    }
  }
}
