import 'package:shared_preferences/shared_preferences.dart';
import 'package:spinchat/Screens/chatView/chatViewScreen.dart';
import 'package:spinchat/Screens/chatscreen/chatScreen.dart';
import 'package:spinchat/Screens/landingPage/landingPage.dart';
import 'package:spinchat/Screens/loginScreen/loginScreen.dart';
import 'package:spinchat/Screens/registrationPage/registrationPage.dart';
import 'package:spinchat/Screens/searchScreen/searchScreen.dart';
import 'package:spinchat/app/services/authService.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  CupertinoRoute(page: LandingPage, initial: true),
  CupertinoRoute(page: LoginScreen),
  CupertinoRoute(page: ChatScreen),
  CupertinoRoute(page: ChatView),
  CupertinoRoute(page: Regiistration),
  CupertinoRoute(page: SearchScreen),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: SnackbarService),
  Presolve(
    classType: SharedPreferenceLocalStorage,
    presolveUsing: SharedPreferences.getInstance,
  ),
  Presolve(
    classType: FirebaseAuthService,
    presolveUsing: FirebaseAuthService.getInstance,
  ),
  Presolve(
    classType: FirestoreService,
    presolveUsing: FirestoreService.getInstance,
  ),
])
class AppRouter {}
