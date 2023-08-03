import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smart_menu/core/binding/create_offer_binding.dart';
import 'package:smart_menu/core/binding/offer_binding.dart';
import 'package:smart_menu/presentation/view/add_food_page.dart';
import 'package:smart_menu/presentation/view/create_offer_page.dart';
import 'package:smart_menu/presentation/view/offer_page.dart';
import '../../presentation/view/food_menu_page.dart';
import '../../presentation/view/home_page.dart';
import '../../presentation/view/login_screen.dart';
import '../binding/add_food_binding.dart';
import '../binding/food_menu_binding.dart';
import '../binding/home_binding.dart';
import '../binding/login_binding.dart';

class AppPages {
  static const HOME = '/';
  static const LOGIN_PAGE = '/login_page';
  static const FOOD_MENU_PAGE = '/food-menu-page';
  static const ADD_FOOD_PAGE = '/add-food-page';
  static const OFFER_PAGE = '/offer-page';
  static const CREATEOFFER_PAGE = '/create-offer-page';

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
  ];
}
