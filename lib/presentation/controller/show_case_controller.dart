import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../constants/app_constant_names.dart';
import '../../data/network/handle_error.dart';

class ShowcaseController extends GetxController {
  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));

  //? add category , multi price toggle
  bool showcaseAddFoodPage = false;
  bool showcaseAddFoodPagePriceNameCard = false;
  bool showcaseAddFoodPageBottomSheet = false;
  bool showcaseFoodMenuPageItem = false;
  bool showcaseOfferFoodPageItem = false;
  bool showcaseQrCodeDesignPageCard = false;
  bool showcaseWebMenuPage = false;
  bool showcaseHomePage = false;

  @override
  Future<void> onInit() async {
    await loadShowcases();
    super.onInit();
  }

  Future<void> loadShowcases() async {
    try {
      final showcaseAddFoodPageBool = await storage.read(key: KEY_SHOWCASE_ADD_FOOD_SCREEN) ?? 'false';
      showcaseAddFoodPage = stringToBool(showcaseAddFoodPageBool);

      final showCaseAddFoodPagPriceCardBool =
              await storage.read(key: KEY_SHOWCASE_ADD_FOOD_SCREEN_PRICE_NAME_CARD) ?? 'false';
      showcaseAddFoodPagePriceNameCard = stringToBool(showCaseAddFoodPagPriceCardBool);

      final showcaseAddFoodPageBottomSheetBool =
              await storage.read(key: KEY_SHOWCASE_ADD_FOOD_SCREEN_BOTTOM_SHEET) ?? 'false';
      showcaseAddFoodPageBottomSheet = stringToBool(showcaseAddFoodPageBottomSheetBool);

      final showcaseFoodMenuPageItemBool = await storage.read(key: KEY_SHOWCASE_FOOD_MENU_SCREEN_ITEM) ?? 'false';
      showcaseFoodMenuPageItem = stringToBool(showcaseFoodMenuPageItemBool);

      final showcaseOfferFoodPageItemBool = await storage.read(key: KEY_SHOWCASE_OFFER_FOOD_SCREEN_ITEM) ?? 'false';
      showcaseOfferFoodPageItem = stringToBool(showcaseOfferFoodPageItemBool);

      final showcaseQrCodeDesignCardBool = await storage.read(key: KEY_SHOWCASE_QR_CODE_DEESIGN_PAGE_CARD) ?? 'false';
      showcaseQrCodeDesignPageCard = stringToBool(showcaseQrCodeDesignCardBool);

      final showcaseWebMenuPageBool = await storage.read(key: KEY_SHOWCASE_WEB_MENU_PAGE) ?? 'false';
      showcaseWebMenuPage = stringToBool(showcaseWebMenuPageBool);

      final showcaseHomePageBool = await storage.read(key: KEY_SHOWCASE_HOME_PAGE) ?? 'false';
      showcaseHomePage = stringToBool(showcaseHomePageBool);
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'show_case_controller', method: 'loadShowcases');
      return;
    }
  }

  Future<void> setShowcase(String key) async {
    try {
      if (key == KEY_SHOWCASE_ADD_FOOD_SCREEN) {
            await storage.write(key: KEY_SHOWCASE_ADD_FOOD_SCREEN, value: 'true');
            showcaseAddFoodPage = true;
          }

      if (key == KEY_SHOWCASE_ADD_FOOD_SCREEN_PRICE_NAME_CARD) {
            await storage.write(key: KEY_SHOWCASE_ADD_FOOD_SCREEN_PRICE_NAME_CARD, value: 'true');
            showcaseAddFoodPagePriceNameCard = true;
          }

      if (key == KEY_SHOWCASE_ADD_FOOD_SCREEN_BOTTOM_SHEET) {
            await storage.write(key: KEY_SHOWCASE_ADD_FOOD_SCREEN_BOTTOM_SHEET, value: 'true');
            showcaseAddFoodPageBottomSheet = true;
          }
      if (key == KEY_SHOWCASE_FOOD_MENU_SCREEN_ITEM) {
            await storage.write(key: KEY_SHOWCASE_FOOD_MENU_SCREEN_ITEM, value: 'true');
            showcaseFoodMenuPageItem = true;
          }
      if (key == KEY_SHOWCASE_OFFER_FOOD_SCREEN_ITEM) {
            await storage.write(key: KEY_SHOWCASE_OFFER_FOOD_SCREEN_ITEM, value: 'true');
            showcaseOfferFoodPageItem = true;
          }

      if (key == KEY_SHOWCASE_QR_CODE_DEESIGN_PAGE_CARD) {
            await storage.write(key: KEY_SHOWCASE_QR_CODE_DEESIGN_PAGE_CARD, value: 'true');
            showcaseQrCodeDesignPageCard = true;
          }

      if (key == KEY_SHOWCASE_WEB_MENU_PAGE) {
            await storage.write(key: KEY_SHOWCASE_WEB_MENU_PAGE, value: 'true');
            showcaseWebMenuPage = true;
          }

      if (key == KEY_SHOWCASE_HOME_PAGE) {
            await storage.write(key: KEY_SHOWCASE_HOME_PAGE, value: 'true');
            showcaseHomePage = true;
          }
    } catch (e) {
      ErrorHandler.handleError(e, isDioError: false, page: 'show_case_controller', method: 'setShowcase');
      return;
    }
  }

  bool stringToBool(String str) {
    return str.toLowerCase() == 'true';
  }
}
