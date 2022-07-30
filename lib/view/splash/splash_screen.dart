import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/components/botnavbar.dart';

import '../welcome/welcome_screen.dart';
import '../../components/constants.dart';
import '../../components/navigator_fade_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AssetImage? assetImage;
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        prefs.getString('token') != null
            ? Navigator.of(context).pushReplacement(
                NavigatorFadeTransition(
                  child: const BotNavBar(),
                ),
              )
            : Navigator.of(context).pushReplacement(
                NavigatorFadeTransition(
                  child: const WelcomeScreen(),
                ),
              );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    assetImage = const AssetImage('assets/images/logo.png');
    startTime();
  }

  @override
  void didChangeDependencies() {
    precacheImage(assetImage!, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: gradientVertical),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              defaultPadding,
            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: assetImage!,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
