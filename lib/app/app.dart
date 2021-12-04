import 'package:shared_preferences/shared_preferences.dart';
import 'package:spinchat/app/services/firebase_storage.dart';
import 'package:spinchat/view/chatView/chat_view_screen.dart';
import 'package:spinchat/view/chatscreen/chat_screen.dart';
import 'package:spinchat/view/homescreen/home_screen.dart';
import 'package:spinchat/view/landingPage/landing_page.dart';
import 'package:spinchat/view/loginScreen/login_screen.dart';
import 'package:spinchat/view/posts/posts.dart';
import 'package:spinchat/view/profile/profile.dart';
import 'package:spinchat/view/registrationPage/registration_page.dart';
import 'package:spinchat/view/chatView/chat_view_search_screen.dart';
import 'package:spinchat/app/services/firebse_auth_service.dart';
import 'package:spinchat/app/services/firestore_service.dart';
import 'package:spinchat/app/services/google_signin_service.dart';
import 'package:spinchat/app/services/localdatabase.dart';
import 'package:spinchat/view/settings/settings.dart';
import 'package:spinchat/widgets/app_wide_widgets/bottom_nav_bar.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: LandingPage, initial: true),
    CupertinoRoute(page: LoginScreen),
    CupertinoRoute(page: ChatScreen),
    CupertinoRoute(page: ChatView),
    CupertinoRoute(page: Registration),
    CupertinoRoute(page: SearchScreen),
    CupertinoRoute(page: IndexScreen),
    CupertinoRoute(page: SettingsPage),
    CupertinoRoute(page: HomeScreen),
    CupertinoRoute(page: Profile),
    CupertinoRoute(page: Posts),
  ],
  dependencies: [
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
  ],
  logger: StackedLogger(),
)
class AppRouter {}
