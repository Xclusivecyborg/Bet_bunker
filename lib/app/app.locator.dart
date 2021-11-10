// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'services/firebase_storage.dart';
import 'services/firebse_auth_service.dart';
import 'services/firestore_service.dart';
import 'services/google_signin_service.dart';
import 'services/localdatabase.dart';

final locator = StackedLocator.instance;

Future setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  final sharedPreferenceLocalStorage =
      await SharedPreferenceLocalStorage.getInstance();
  locator.registerSingleton(sharedPreferenceLocalStorage);

  final firebaseAuthService = await FirebaseAuthService.getInstance();
  locator.registerSingleton(firebaseAuthService);

  final firestoreService = await FirestoreService.getInstance();
  locator.registerSingleton(firestoreService);

  final firebaseDataStorage = await FirebaseDataStorage.getInstance();
  locator.registerSingleton(firebaseDataStorage);

  final googleAuthService = await GoogleAuthService.getInstance();
  locator.registerSingleton(googleAuthService);
}
