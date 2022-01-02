import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'app/services/localdatabase.dart';
import 'utils/constants/color_constants.dart';
import 'utils/storage_keys.dart';

final _storage = locator<SharedPreferenceLocalStorage>();
bool? get themePref => _storage.getBool(StorageKeys.themePref);
ThemeBuilder getMaterialApp(registered) {
  if (registered == true) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: AppColors.black,
        colorScheme: const ColorScheme.dark(),
      ),
      lightTheme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: AppColors.white,
        colorScheme: const ColorScheme.light(),
      ),
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        theme: regularTheme,
        themeMode: themeMode,
        darkTheme: darkTheme,
        title: 'BetBunker',
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        initialRoute: Routes.loginScreen,
      ),
    );
  } else if (registered == null) {
    return ThemeBuilder(
      defaultThemeMode: themePref == false  ? ThemeMode.light : ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: AppColors.black,
        colorScheme: const ColorScheme.dark(),
      ),
      lightTheme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: AppColors.white,
        colorScheme: const ColorScheme.light(),
      ),
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        theme: regularTheme,
        themeMode: themeMode,
        darkTheme: darkTheme,
        title: 'BetBunker',
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        initialRoute: Routes.landingPage,
      ),
    );
  } else {
    return ThemeBuilder(
      defaultThemeMode: themePref == false  ? ThemeMode.light : ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: AppColors.black,
        colorScheme: const ColorScheme.dark(),
      ),
      lightTheme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: AppColors.white,
        colorScheme: const ColorScheme.light(),
      ),
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        theme: regularTheme,
        themeMode: themeMode,
        darkTheme: darkTheme,
        title: 'BetBunker',
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        initialRoute: Routes.indexScreen,
      ),
    );
  }
}
