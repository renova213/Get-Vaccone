import 'package:flutter/material.dart';
import 'package:vaccine_booking/view/history/history_screen.dart';
import 'package:vaccine_booking/view/home/home_screen.dart';
import 'package:vaccine_booking/view/vaksinasi/vaksinasi_screen.dart';

import '../view/profile/profile_screen.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (tabItem == "Screen1") {
      child = const HomeScreen();
    } else if (tabItem == "Screen2") {
      child = const VaksinasiScreen();
    } else if (tabItem == "Screen3") {
      child = const HistoryScreen();
    } else if (tabItem == "Screen4") {
      child = const ProfileScreen();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child!);
      },
    );
  }
}
