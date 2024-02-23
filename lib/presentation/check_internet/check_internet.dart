import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_menu/presentation/widget/snack_bar.dart';

Future<bool> checkInternetConnection({bool showSnack = true}) async {
  try {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
    showSnack ?  AppSnackBar.errorSnackBar('Error','Pleas check your internet connection'): null;
      return false;
    }else{
      return true;
    }
  } catch (e) {
    return false;
  }
}
