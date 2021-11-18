// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../view/chatView/chat_view_screen.dart';
import '../view/chatView/chat_view_search_screen.dart';
import '../view/chatscreen/chat_screen.dart';
import '../view/homescreen/home_screen.dart';
import '../view/landingPage/landing_page.dart';
import '../view/loginScreen/login_screen.dart';
import '../view/registrationPage/registration_page.dart';
import '../view/settings/settings.dart';
import '../widgets/bottom_nav_bar.dart';

class Routes {
  static const String landingPage = '/';
  static const String loginScreen = '/login-screen';
  static const String chatScreen = '/chat-screen';
  static const String chatView = '/chat-view';
  static const String registration = '/Registration';
  static const String searchScreen = '/search-screen';
  static const String indexScreen = '/index-screen';
  static const String settingsPage = '/settings-page';
  static const String homeScreen = '/home-screen';
  static const all = <String>{
    landingPage,
    loginScreen,
    chatScreen,
    chatView,
    registration,
    searchScreen,
    indexScreen,
    settingsPage,
    homeScreen,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.landingPage, page: LandingPage),
    RouteDef(Routes.loginScreen, page: LoginScreen),
    RouteDef(Routes.chatScreen, page: ChatScreen),
    RouteDef(Routes.chatView, page: ChatView),
    RouteDef(Routes.registration, page: Registration),
    RouteDef(Routes.searchScreen, page: SearchScreen),
    RouteDef(Routes.indexScreen, page: IndexScreen),
    RouteDef(Routes.settingsPage, page: SettingsPage),
    RouteDef(Routes.homeScreen, page: HomeScreen),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LandingPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const LandingPage(),
        settings: data,
      );
    },
    LoginScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const LoginScreen(),
        settings: data,
      );
    },
    ChatScreen: (data) {
      var args = data.getArgs<ChatScreenArguments>(
        orElse: () => ChatScreenArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ChatScreen(
          key: args.key,
          usernameChattingWith: args.usernameChattingWith,
          networkUrl: args.networkUrl,
          isOnline: args.isOnline,
        ),
        settings: data,
      );
    },
    ChatView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const ChatView(),
        settings: data,
      );
    },
    Registration: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const Registration(),
        settings: data,
      );
    },
    SearchScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const SearchScreen(),
        settings: data,
      );
    },
    IndexScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const IndexScreen(),
        settings: data,
      );
    },
    SettingsPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const SettingsPage(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const HomeScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ChatScreen arguments holder class
class ChatScreenArguments {
  final Key? key;
  final String? usernameChattingWith;
  final String? networkUrl;
  final bool? isOnline;
  ChatScreenArguments(
      {this.key, this.usernameChattingWith, this.networkUrl, this.isOnline});
}
