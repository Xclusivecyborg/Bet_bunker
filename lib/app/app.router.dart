// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../Screens/chatView/chatViewScreen.dart';
import '../Screens/chatscreen/chatScreen.dart';
import '../Screens/landingPage/landingPage.dart';
import '../Screens/loginScreen/loginScreen.dart';
import '../Screens/registrationPage/registrationPage.dart';
import '../Screens/searchScreen/searchScreen.dart';

class Routes {
  static const String landingPage = '/';
  static const String loginScreen = '/login-screen';
  static const String chatScreen = '/chat-screen';
  static const String chatView = '/chat-view';
  static const String regiistration = '/Regiistration';
  static const String searchScreen = '/search-screen';
  static const all = <String>{
    landingPage,
    loginScreen,
    chatScreen,
    chatView,
    regiistration,
    searchScreen,
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
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const ChatView(),
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
        builder: (context) =>  SearchScreen(),
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
