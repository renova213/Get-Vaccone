import 'package:flutter/material.dart';
import 'package:vaccine_booking/components/navigator_fade_transition.dart';
import 'package:vaccine_booking/view/authentikasi/login_screen.dart';
import 'package:vaccine_booking/view/authentikasi/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: maxWidth * 0.8,
              child: Column(
                children: [
                  SizedBox(
                    height: maxHeight * 0.30,
                    width: maxWidth,
                    child: vaccineImage(),
                  ),
                  headlineText(),
                  const SizedBox(
                    height: 8,
                  ),
                  subtitleText()
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 55,
              width: maxWidth * 0.85,
              child: registerButton(),
            ),
            const SizedBox(
              height: 32,
            ),
            loginTextButton()
          ],
        ),
      ),
    );
  }

  Widget loginTextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Sudah punya akun?", style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(
          width: 8,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              NavigatorFadeTransition(
                child: const LoginScreen(),
              ),
            );
          },
          child: Text("Login", style: Theme.of(context).textTheme.headline4),
        ),
      ],
    );
  }

  Widget registerButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          NavigatorFadeTransition(
            child: const RegisterScreen(),
          ),
        );
      },
      child: const Text(
        "Register",
      ),
    );
  }

  Widget subtitleText() {
    return Text("Dapat dilakukan di mana pun dan kapan pun dengan mudah",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1);
  }

  Widget headlineText() {
    return Column(
      children: [
        Text(
          "Alternatif",
          style: Theme.of(context).textTheme.headline1,
        ),
        Text("Pesan Vaksinasi", style: Theme.of(context).textTheme.headline1),
      ],
    );
  }

  Widget vaccineImage() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Image.asset("assets/images/vaccine.png"),
      ),
    );
  }
}
