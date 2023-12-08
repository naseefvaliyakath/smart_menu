import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smart_menu/core/binding/create_offer_binding.dart';
import 'package:smart_menu/core/binding/offer_binding.dart';
import 'package:smart_menu/core/binding/setup_qr_stand_binding.dart';
import 'package:smart_menu/core/binding/web_menu_binding.dart';
import 'package:smart_menu/presentation/view/add_food_page.dart';
import 'package:smart_menu/presentation/view/create_offer_page.dart';
import 'package:smart_menu/presentation/view/payment_modes_page.dart';
import 'package:smart_menu/presentation/view/setup_qr_stand/customize_qr_stand.dart';
import 'package:smart_menu/presentation/view/offer_page.dart';
import 'package:smart_menu/presentation/view/setup_qr_stand/paper_purchase_page.dart';
import 'package:smart_menu/presentation/view/setup_qr_stand/stand_purchase_page.dart';
import 'package:smart_menu/presentation/view/web_menu_page.dart';
import '../../presentation/view/food_menu_page.dart';
import '../../presentation/view/home_page.dart';
import '../../presentation/view/login_screen.dart';
import '../../presentation/view/qr_code_screen.dart';
import '../binding/add_food_binding.dart';
import '../binding/food_menu_binding.dart';
import '../binding/home_binding.dart';
import '../binding/login_binding.dart';
import '../binding/payment_mode_binding.dart';

class AppPages {
  static const HOME = '/';
  static const LOGIN_PAGE = '/login_page';
  static const FOOD_MENU_PAGE = '/food-menu-page';
  static const ADD_FOOD_PAGE = '/add-food-page';
  static const OFFER_PAGE = '/offer-page';
  static const CREATEOFFER_PAGE = '/create-offer-page';
  static const QR_CODE_PAGE = '/qr-code-page';
  static const CUSTOMIZE_QR_STAND_PAGE = '/customize-qr-stand-page';
  static const STAND_PURCHASE_PAGE = '/stand-purchase-page';
  static const PAPER_PURCHASE_PAGE = '/paper-purchase-page';
  static const WEB_MENU_PAGE = '/web-menu-page';
  static const PAYMENT_MODE_PAGE = '/payment-mode-page';

  static final routes = [
    GetPage(
      name: HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: LOGIN_PAGE,
        page: () {
          return const LoginScreen();
        },
        binding: LoginBinding()),
    GetPage(
        name: FOOD_MENU_PAGE,
        page: () {
          return const FoodMenuPage();
        },
        binding: FoodMenuBinding()),
    GetPage(
        name: ADD_FOOD_PAGE,
        page: () {
          return const AddFoodPage();
        },
        binding: AddFoodBinding()),
    GetPage(
        name: OFFER_PAGE,
        page: () {
          return const OfferPage();
        },
        binding: OfferPageBinding()),
    GetPage(
        name: CREATEOFFER_PAGE,
        page: () {
          return const CreateOfferPage();
        },
        binding: CreateOfferPageBinding()),
    GetPage(
        name: QR_CODE_PAGE,
        page: () {
          return  QRCodeTableStand();
        },
        binding: CreateOfferPageBinding()),
    GetPage(
        name: CUSTOMIZE_QR_STAND_PAGE,
        page: () {
          return  const CustomizeQRStandCard();
        },
        binding: CustomizeQrStandBinding()),
    GetPage(
        name: STAND_PURCHASE_PAGE,
        page: () {
          return   StandPurchasePage();
        },
        binding: CustomizeQrStandBinding()),
    GetPage(
        name: PAPER_PURCHASE_PAGE,
        page: () {
          return   PaperPurchasePage();
        },
        binding: CustomizeQrStandBinding()),
    GetPage(
        name: WEB_MENU_PAGE,
        page: () {
          return   WebMenuPage();
        },
        binding: WebMenuBinding()),
    GetPage(
        name: PAYMENT_MODE_PAGE,
        page: () {
          return   PaymentModesPage();
        },
        binding: PaymentModeBinding()),
  ];
}
