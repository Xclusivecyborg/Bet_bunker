// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../view/chatView/chat_view_screen.dart';
import '../view/chatView/chat_view_search_screen.dart';
import '../view/chatscreen/chat_screen.dart';
import '../view/homescreen/home_screen.dart';
import '../view/landingPage/landing_page.dart';
import '../view/loginScreen/login_screen.dart';
import '../view/posts/posts.dart';
import '../view/profile/profile.dart';
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
  static const String profile = '/Profile';
  static const String posts = '/Posts';
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
    profile,
    posts,
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
    RouteDef(Routes.profile, page: Profile),
    RouteDef(Routes.posts, page: Posts),
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
      var args = data.getArgs<ChatScreenArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ChatScreen(
          key: args.key,
          usernameChattingWith: args.usernameChattingWith,
          networkUrl: args.networkUrl,
          isOnline: args.isOnline,
          aboutMe: args.aboutMe,
          uid: args.uid,
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
    Profile: (data) {
      var args = data.getArgs<ProfileArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => Profile(
          key: args.key,
          networkUrl: args.networkUrl,
          username: args.username,
          aboutMe: args.aboutMe,
          uid: args.uid,
        ),
        settings: data,
      );
    },
    Posts: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const Posts(),
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
  final String? aboutMe;
  final String uid;
  ChatScreenArguments(
      {this.key,
      this.usernameChattingWith,
      this.networkUrl,
      this.isOnline,
      this.aboutMe,
      required this.uid});
}

/// Profile arguments holder class
class ProfileArguments {
  final Key? key;
  final String networkUrl;
  final String username;
  final String aboutMe;
  final String uid;
  ProfileArguments(
      {this.key,
      required this.networkUrl,
      required this.username,
      required this.aboutMe,
      required this.uid});
}
