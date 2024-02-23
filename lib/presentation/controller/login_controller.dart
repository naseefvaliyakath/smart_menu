import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smart_menu/core/routes/app_pages.dart';
import 'package:smart_menu/data/model/shop/shop.dart';
import 'package:smart_menu/data/network/dio_client.dart';
import 'package:smart_menu/domain/repository/network/contract/shop_repository.dart';
import 'package:smart_menu/presentation/widget/snack_bar.dart';
import '../../constants/app_constant_names.dart';
import '../../constants/dummy_models.dart';
import '../../constants/enums.dart';
import '../../data/model/api_response/api_response.dart';
import '../../data/model/app_update_model/app_update_model.dart';
import '../../data/network/handle_error.dart';
import '../alert/update_notice_alert.dart';

class LoginController extends GetxController {
  bool isAuthenticated = false;

  Shop myShop = dummyShop;

  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  ShopRepository shopRepository = Get.find<ShopRepository>();

  final LoadingButtonController btnController = LoadingButtonController();
  final LoadingButtonController loginBtnController = LoadingButtonController();

  TextEditingController registerMobileNumberController = TextEditingController();

  //? add shop Form controllers
  TextEditingController shopNameController = TextEditingController();
  TextEditingController phone1Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();

  //? update shop details in profile
  TextEditingController shopNameEditController = TextEditingController();
  TextEditingController shopPhoneEditController = TextEditingController();
  TextEditingController shopEmailEditController = TextEditingController();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  //?update shop details alert forms
  final GlobalKey<FormState> shopNameEditFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> shopPhoneEditFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> shopEmailEditFormKey = GlobalKey<FormState>();

  Rx<States> selectedState = Rx<States>(States.values.first);
  Rx<District> selectedDistrict = Rx<District>(District.values.first);
  String otp = '00000';

  RxBool showLoading = true.obs;
  RxString registeredPhoneNumber = ''.obs;

  RxBool isFormSubmitted = false.obs;

  @override
  void onReady() {
    Future.delayed(const Duration(milliseconds: 200), () async {
      if (isAuthenticated) {
        updateShopInfoEveryTime();
        checkAppUpdate();
      }
    });
    super.onReady();
  }

  @override
  Future<void> onInit() async {
    isAuthenticated = await checkIsAuthenticated();
    retrieveShopDataFromSecureStorage();
    super.onInit();
  }

  Future<void> initiateCreateShop({bool isResendOtp = false , String otpType = 'sms'}) async {
    try {
      if (registerFormKey.currentState!.validate()) {
        try {
          Shop shop = Shop(
            shopId: 0,
            // Assuming `shopId` is auto-generated and might not be needed as a named parameter if handled by the database
            shopName: shopNameController.text,
            phoneNumber: phone1Controller.text,
            email: emailController.text,
            state: enumToString(selectedState.value),
            district: enumToString(selectedDistrict.value),
            plan: 'Basic',
            expiryDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            //? set it in server side no use it
            status: 'active',
            //?  set it in server side no use it
            createdAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            updatedAt: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            token: 'token',
          );
          ApiResponse<Shop>? apiResponse = await shopRepository.initiateCreateShop(shop,otpType);
          if (apiResponse != null) {
            if (apiResponse.error) {
              btnController.error();
              AppSnackBar.errorSnackBar('Error', apiResponse.message);
            } else {
              AppSnackBar.successSnackBar('Success', apiResponse.message);
              //? check otp is send successfully
              if (apiResponse.message.contains('sent successfully')) {
                if (isResendOtp) {
                  otpController.clear();
                }
                btnController.success();
                isFormSubmitted.value = true;
              }
            }
          } else {
            btnController.error();
            //? AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
          }
        } catch (e) {
          btnController.error();
          AppSnackBar.errorSnackBar('Error', e.toString());
        }
      } else {
        btnController.error();
        AppSnackBar.errorSnackBar('Error', 'Form not validated');
      }
    } catch (e) {
      btnController.error();
      ErrorHandler.handleError(e, isDioError: false, page: 'login_controller', method: 'initiateCreateShop');
      return;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        btnController.reset();
      });
    }
  }

  Future<void> verifyOTPAndCreateShop() async {
    try {
      if (registerFormKey.currentState!.validate()) {
        try {
          Map<String, dynamic> otpData = {"phoneNumber": int.tryParse(phone1Controller.text), "otp": int.tryParse(otp)};
          ApiResponse<Shop>? apiResponse = await shopRepository.verifyOTPAndCreateShop(otpData);
          if (apiResponse != null) {
            if (apiResponse.error) {
              btnController.error();
              AppSnackBar.errorSnackBar('Error', apiResponse.message);
            } else {
              btnController.success();
              AppSnackBar.successSnackBar('Success', apiResponse.message);
              Future.delayed(const Duration(seconds: 1), () {
                btnController.reset();
                clearFormField();
                isFormSubmitted.value = false;
                Get.offAllNamed(AppPages.LOGIN_PAGE);
              });
            }
          } else {
            btnController.error();
            //? AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
          }
        } catch (e) {
          btnController.error();
          AppSnackBar.errorSnackBar('Error', e.toString());
        }
      } else {
        btnController.error();
        AppSnackBar.errorSnackBar('Error', 'Form not validated');
      }
    } catch (e) {
      btnController.error();
      ErrorHandler.handleError(e, isDioError: false, page: 'login_controller', method: 'verifyOTPAndCreateShop');
      return;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        btnController.reset();
      });
    }
  }

  Future<void> login() async {
    try {
      //?ll String? token = await storage.read(key: KEY_TOKEN);
      if (loginFormKey.currentState!.validate()) {
        try {
          String phoneNumber = registerMobileNumberController.text;
          ApiResponse<Shop>? apiResponse = await shopRepository.getShopByPhone(phoneNumber);
          if (apiResponse != null) {
            if (apiResponse.error) {
              loginBtnController.error();
              Future.delayed(const Duration(seconds: 1), () {
                loginBtnController.reset();
              });
              AppSnackBar.errorSnackBar('Error', apiResponse.message);
            } else {
              AppSnackBar.successSnackBar('Success', apiResponse.message);
              Shop? shop = apiResponse.data;
              saveLoginInfoAndRedirect(shop);
            }
          } else {
            loginBtnController.error();
            Future.delayed(const Duration(seconds: 1), () {
              loginBtnController.reset();
            });
            //? AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
          }
        } catch (e) {
          loginBtnController.error();
          Future.delayed(const Duration(seconds: 1), () {
            loginBtnController.reset();
          });
          AppSnackBar.errorSnackBar('Error', e.toString());
        }
      } else {
        loginBtnController.error();
        Future.delayed(const Duration(seconds: 1), () {
          loginBtnController.reset();
        });
        AppSnackBar.errorSnackBar('Error', 'Form not validated');
      }
    } catch (e) {
      loginBtnController.error();
      Future.delayed(const Duration(seconds: 1), () {
        loginBtnController.reset();
      });
      ErrorHandler.handleError(e, isDioError: false, page: 'login_controller', method: 'login');
      return;
    }
  }

  // validation for form fields
  String? validateInput(String value) {
    if (value.isEmpty) {
      return "This field cannot be empty";
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return "This field cannot be empty";
    }
    if (value.length != 10) {
      return "Phone number should be 10 digits";
    }
    return null;
  }

  void clearFormField() {
    shopNameController.clear();
    phone1Controller.clear();
    emailController.clear();
    otp = '00000';
  }

  saveLoginInfoAndRedirect(Shop? shop) async {
    try {
      if (shop != null) {
            storage.write(key: KEY_TOKEN, value: shop.token);
            storage.write(key: KEY_ID, value: shop.shopId.toString());
            storage.write(key: KEY_SHOP_PHONE, value: shop.phoneNumber.toString());
            storage.write(key: KEY_SHOP_NAME, value: shop.shopName);
            storage.write(key: KEY_SHOP_EXPAIRY, value: shop.expiryDate);
            storage.write(key: KEY_SHOP_STATUS, value: shop.status);
            storage.write(key: KEY_SHOP_PLAN, value: shop.plan);
            //?update myShop to get globally data
            myShop = shop;
            //? update token in Dio Clint
            Get.find<DioClient>().updatingToken(shop.token ?? '');
            registerMobileNumberController.clear();
            Get.offAllNamed(AppPages.HOME);
          }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'login_controller', method: 'saveLoginInfoAndRedirect');
      return;
    }
  }

  checkIsAuthenticated() async {
    String? token = await storage.read(key: KEY_TOKEN);
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  retrieveShopDataFromSecureStorage() async {
    try {
      String shopId = await storage.read(key: KEY_ID) ?? '0';
      String shopName = await storage.read(key: KEY_SHOP_NAME) ?? 'No Name';
      String shopNumber = await storage.read(key: KEY_SHOP_PHONE) ?? '1234567890';
      String shopEmail = await storage.read(key: KEY_SHOP_EMAIL) ?? 'dummy@gmail.com';
      String shopPlan = await storage.read(key: KEY_SHOP_PLAN) ?? 'Trial';
      String expiryDate = await storage.read(key: KEY_SHOP_EXPAIRY) ?? '2023-12-31';
      String status = await storage.read(key: KEY_SHOP_STATUS) ?? 'deactivated';
      //? updating to myShop variable
      myShop.shopId = int.tryParse(shopId);
      myShop.shopName = shopName;
      myShop.phoneNumber = shopNumber;
      myShop.email = shopEmail;
      myShop.plan = shopPlan;
      myShop.expiryDate = expiryDate;
      myShop.status = status;
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'login_controller', method: 'retrieveShopDataFromSecureStorage');
      return;
    } finally {
      update();
    }
  }

  updateShopInfoEveryTime() async {
    try {
      String shopId = await storage.read(key: KEY_ID) ?? '0';
      ApiResponse<Shop>? apiResponse = await shopRepository.getShopById(int.tryParse(shopId) ?? 0);
      if (apiResponse != null) {
        if (!apiResponse.error) {
          Shop? shop = apiResponse.data;
          if (shop != null) {
            myShop = shop;
            storage.write(key: KEY_SHOP_PHONE, value: shop.phoneNumber.toString());
            storage.write(key: KEY_SHOP_EMAIL, value: shop.email);
            storage.write(key: KEY_SHOP_NAME, value: shop.shopName);
            storage.write(key: KEY_SHOP_EXPAIRY, value: shop.expiryDate);
            storage.write(key: KEY_SHOP_STATUS, value: shop.status);
            storage.write(key: KEY_SHOP_PLAN, value: shop.plan);
            if (shop.status?.trim().toLowerCase() == 'deactivated' ||
                (daysUntilExpiry(shop.expiryDate ?? DateTime.now().toString())) == 0) {
              showNoticeUpdateAlert(
                  message: 'Your plan has deactivated \n Renew or contact \ncustomer care',
                  context: Get.context!,
                  type: 'notice',
                  forced: false);
            }
          }
        }
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'login_controller', method: 'updateShopInfoEveryTime');
      return;
    } finally {
      update();
    }
  }

  //? checking for update
  checkAppUpdate() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      int currentVersion = int.tryParse(packageInfo.buildNumber) ?? 1;
      ApiResponse? appUpdate = await shopRepository.getAppUpdate();
      if (appUpdate != null) {
        AppUpdateModel? newUpdate = appUpdate.data;
        if (newUpdate != null) {
          int newVersion = int.tryParse(newUpdate.version) ?? 0;
          if (newVersion > currentVersion) {
            showNoticeUpdateAlert(
              message: newUpdate.message.replaceAll('\\n', '\n'),
              context: Get.context!,
              type: 'update',
              forced: newUpdate.forced == 'yes' ? false : true,
            );
          }
        }
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'login_controller', method: 'checkAppUpdate');
      return;
    }
  }

  logOutApp() {
    try {
      storage.deleteAll(
              aOptions: const AndroidOptions(
            encryptedSharedPreferences: true,
          ));
      Get.offAllNamed(AppPages.LOGIN_PAGE);
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'login_controller', method: 'logOutApp');
      return;
    }
  }

  Future updateShopDetails(String updateField) async {
    try {
      String updateFieldValue = updateField == 'shopName'
          ? shopNameEditController.text
          : updateField == 'phoneNumber'
              ? shopPhoneEditController.text
              : updateField == 'email'
                  ? shopEmailEditController.text
                  : '';

      Map<String, dynamic> updateBody = {updateField: updateFieldValue};

      bool isFormValid = updateField == 'shopName'
          ? shopNameEditFormKey.currentState!.validate()
          : updateField == 'phoneNumber'
              ? shopPhoneEditFormKey.currentState!.validate()
              : updateField == 'email'
                  ? shopEmailEditFormKey.currentState!.validate()
                  : false;
      if (!isFormValid && updateFieldValue.isNotEmpty) {
        AppSnackBar.errorSnackBar('Error', 'Pleas enter valid input');
        return;
      }
      Navigator.pop(Get.context!);
      ApiResponse<Shop>? apiResponse = await shopRepository.updateShop(updateBody);
      if (apiResponse != null) {
        if (apiResponse.error) {
          AppSnackBar.errorSnackBar('Error', apiResponse.message);
          return false;
        } else {
          shopEmailEditController.clear();
          shopPhoneEditController.clear();
          shopNameEditController.clear();
          AppSnackBar.successSnackBar('Success', apiResponse.message);
          updateShopInfoEveryTime();
          return true;
        }
      } else {
        //?  AppSnackBar.errorSnackBar('Error', 'Something went to  wrong !');
        return false;
      }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'login_controller', method: 'updateShopDetails');
      return;
    } finally {
      update();
    }
  }

  int daysUntilExpiry(String dateString) {
    DateTime serverDate = DateTime.parse(dateString);
    DateTime currentDate = DateTime.now().toUtc();

    // Calculate the difference in days
    int difference = serverDate.difference(currentDate).inDays;

    // Check if the date is already expired
    if (difference < 0) {
      return 0; // Expired
    } else {
      return difference; // Days remaining
    }
  }

  String enumToString(Object o) => o.toString().split('.').last;
}
