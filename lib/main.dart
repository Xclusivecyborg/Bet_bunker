import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/main_material_app.dart';
import 'package:spinchat/widgets/package_widgets/custom_snackbar.dart';
import 'package:spinchat/widgets/package_widgets/setup_ui_dialog.dart';
import 'app/app.logger.dart';
import 'app/services/localdatabase.dart';
import 'utils/storage_keys.dart';
import 'package:stacked_themes/stacked_themes.dart';

Future main() async {
  await ThemeManager.initialise();
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
    return getMaterialApp(registered);
  }
}
