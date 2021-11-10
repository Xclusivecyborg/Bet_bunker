// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../view/chatView/chatViewScreen.dart';
import '../view/chatscreen/chatScreen.dart';
import '../view/landingPage/landingPage.dart';
import '../view/loginScreen/loginScreen.dart';
import '../view/registrationPage/registrationPage.dart';
import '../view/searchScreen/searchScreen.dart';
import '../view/settings/settings.dart';
import '../widgets/bottom_nav_bar.dart';

class Routes {
  static const String landingPage = '/';
  static const String loginScreen = '/login-screen';
  static const String chatScreen = '/chat-screen';
  static const String chatView = '/chat-view';
  static const String regiistration = '/Regiistration';
  static const String searchScreen = '/search-screen';
  static const String indexScreen = '/index-screen';
  static const String settingsPage = '/settings-page';
  static const all = <String>{
    landingPage,
    loginScreen,
    chatScreen,
    chatView,
    regiistration,
    searchScreen,
    indexScreen,
    settingsPage,
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
    RouteDef(Routes.regiistration, page: Regiistration),
    RouteDef(Routes.searchScreen, page: SearchScreen),
    RouteDef(Routes.indexScreen, page: IndexScreen),
    RouteDef(Routes.settingsPage, page: SettingsPage),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LandingPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => LandingPage(),
        settings: data,
      );
    },
    LoginScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => LoginScreen(),
        settings: data,
      );
    },
    ChatScreen: (data) {
      var args = data.getArgs<ChatScreenArguments>(
        orElse: () => ChatScreenArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ChatScreen(key: args.key),
        settings: data,
      );
    },
    ChatView: (data) {
      var args = data.getArgs<ChatViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ChatView(
          key: args.key,
          username: args.username,
        ),
        settings: data,
      );
    },
    Regiistration: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => Regiistration(),
        settings: data,
      );
    },
    SearchScreen: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SearchScreen(),
        settings: data,
      );
    },
    IndexScreen: (data) {
      var args = data.getArgs<IndexScreenArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => IndexScreen(
          key: args.key,
          username: args.username,
        ),
        settings: data,
      );
    },
    SettingsPage: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const SettingsPage(),
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
  ChatScreenArguments({this.key});
}

/// ChatView arguments holder class
class ChatViewArguments {
  final Key? key;
  final String username;
  ChatViewArguments({this.key, required this.username});
}

/// IndexScreen arguments holder class
class IndexScreenArguments {
  final Key? key;
  final String username;
  IndexScreenArguments({this.key, required this.username});
}
