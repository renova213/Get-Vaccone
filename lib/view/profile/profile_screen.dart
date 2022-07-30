import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_booking/components/navigator_fade_transition.dart';
import 'package:vaccine_booking/view_model/profile_view_model.dart';

import '../../components/constants.dart';
import '../../view_model/auth_view_model.dart';
import '../welcome/welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileViewModel>(context);
    final deleteToken = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: gradientHorizontal),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              headline(context),
              Center(
                child: SvgPicture.asset(
                  'assets/icons/account.svg',
                  width: 96,
                  height: 96,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: Text(
                  user.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 188,
                          child: historyNameList(user, user.itemsProfile)),
                      logout(context, deleteToken, user),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headline(context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height * 0.10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          "Profil",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget historyNameList(ProfileViewModel user, List title) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.white,
          height: 0,
        );
      },
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Center(
          child: Container(
            height: 55,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  NavigatorFadeTransition(
                    child: user.wigetScreenDetailProfile[index],
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/${user.iconsSvgDetailProfile[index]}.svg',
                      height: 32,
                      width: 32,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            color: primaryColor,
                            size: 36,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: 3,
    );
  }

  Widget logout(context, AuthViewModel deleteToken, ProfileViewModel user) {
    return Center(
      child: Container(
        height: 55,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: TextButton(
          onPressed: () {
            deleteToken.deleteToken();
            user.userData.clear();
            user.familyList.clear();
            Navigator.of(context, rootNavigator: true).pushReplacement(
              NavigatorFadeTransition(
                child: const WelcomeScreen(),
              ),
            );
            Fluttertoast.showToast(msg: "Berhasil Keluar");
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/logout.svg',
                  height: 32,
                  width: 32,
                  color: primaryColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Logout",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: primaryColor,
                        size: 36,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
