import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vaccine_booking/components/constants.dart';

import 'tab_navigator.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key}) : super(key: key);

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  String _currentPage = "Screen1";
  List<String> pageKeys = ["Screen1", "Screen2", "Screen3", "Screen4"];
  int _selectedIndex = 0;
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Screen1": GlobalKey<NavigatorState>(),
    "Screen2": GlobalKey<NavigatorState>(),
    "Screen3": GlobalKey<NavigatorState>(),
    "Screen4": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    setState(() {
      _currentPage = pageKeys[index];
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
      },
      child: DoubleBack(
        message: "Press back again to exit",
        child: Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildOffstageNavigator("Screen1"),
              _buildOffstageNavigator("Screen2"),
              _buildOffstageNavigator("Screen3"),
              _buildOffstageNavigator("Screen4"),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 1.00),
                        blurRadius: 15,
                        color: Colors.grey,
                        spreadRadius: 1.00),
                  ],
                ),
                height: 65,
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  child: BottomNavigationBar(
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 50),
                    selectedItemColor: primaryColor,
                    unselectedItemColor: Colors.grey,
                    onTap: (int index) {
                      _selectTab(pageKeys[index], index);
                    },
                    currentIndex: _selectedIndex,
                    items: [
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/icons/home.svg',
                          height: 18,
                          width: 18,
                          color: primaryColor,
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/home.svg',
                          height: 18,
                          width: 18,
                          color: Colors.grey,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/icons/syringe.svg',
                          height: 18,
                          width: 18,
                          color: primaryColor,
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/syringe.svg',
                          height: 18,
                          width: 18,
                          color: Colors.grey,
                        ),
                        label: 'Vaksinasi',
                      ),
                      const BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.receipt_long,
                          color: primaryColor,
                          size: 18,
                        ),
                        icon: Icon(
                          Icons.receipt_long_outlined,
                          color: Colors.grey,
                          size: 18,
                        ),
                        label: 'History',
                      ),
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/icons/user.svg',
                          color: primaryColor,
                          width: 18,
                          height: 18,
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/user.svg',
                          color: Colors.grey,
                          width: 18,
                          height: 18,
                        ),
                        label: 'Profile',
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
