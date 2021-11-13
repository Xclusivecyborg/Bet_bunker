import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/widgets/custom_snackbar.dart';
import 'package:spinchat/widgets/setup_ui_dialog.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.router.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: Routes.landingPage,
    );
  }
}
