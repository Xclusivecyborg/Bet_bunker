import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/widgets/custom_snackbar.dart';
import 'package:spinchat/widgets/setup_ui_dialog.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.logger.dart';
import 'app/app.router.dart';
import 'app/services/localdatabase.dart';
import 'utils/storage_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  setupDialogUi();
  AppSnackBar.setupSnackbarUi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final log = getLogger('Main.dart');
    final _storage = locator<SharedPreferenceLocalStorage>();
    final registered = _storage.getBool(StorageKeys.registered);
    log.e(registered);
    if (registered == true) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        initialRoute: Routes.loginScreen,
      );
    } else if (registered == null ) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        initialRoute: Routes.landingPage,
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        initialRoute: Routes.indexScreen,
      );
    }
  }
}
