import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.router.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/utils/storage_keys.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LandingPageViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _storage = locator<SharedPreferenceLocalStorage>();

  void navigateToLogin() {
    _navigation.navigateTo(Routes.loginScreen);
  }

  void setTheme() async {
    await _storage.setBool(StorageKeys.themePref, false);
  }

  void navigateToRegistrationPage() {
    _navigation.navigateTo(Routes.registration);
  }
}
