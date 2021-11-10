import 'package:shared_preferences/shared_preferences.dart';
import 'package:spinchat/app/services/firebase_storage.dart';
import 'package:spinchat/view/chatView/chatViewScreen.dart';
import 'package:spinchat/view/chatscreen/chatScreen.dart';
import 'package:spinchat/view/landingPage/landingPage.dart';
import 'package:spinchat/view/loginScreen/loginScreen.dart';
import 'package:spinchat/view/registrationPage/registrationPage.dart';
import 'package:spinchat/view/searchScreen/searchScreen.dart';
import 'package:spinchat/app/services/firebse_auth_service.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/app/services/google_signin_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/view/settings/settings.dart';
import 'package:spinchat/widgets/bottom_nav_bar.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  CupertinoRoute(page: LandingPage, initial: true),
  CupertinoRoute(page: LoginScreen),
  CupertinoRoute(page: ChatScreen),
  CupertinoRoute(page: ChatView),
  CupertinoRoute(page: Regiistration),
  CupertinoRoute(page: SearchScreen),
  CupertinoRoute(page: IndexScreen),
  CupertinoRoute(page: SettingsPage),
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
  Presolve(
    classType: FirebaseDataStorage,
    presolveUsing: FirebaseDataStorage.getInstance,
  ),
  Presolve(
    classType: GoogleAuthService,
    presolveUsing: GoogleAuthService.getInstance,
  ),
])
class AppRouter {}
