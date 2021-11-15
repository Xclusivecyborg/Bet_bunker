import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LandingPageViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();

  void navigateToLogin() {
    _navigation.navigateTo(Routes.loginScreen);
  }

   void navigateToRegistrationPage() {
    _navigation.navigateTo(Routes.registration);
  }
}
