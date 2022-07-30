import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_booking/components/navigator_fade_transition.dart';
import 'package:vaccine_booking/view/profile/edit_profile.dart';
import 'package:vaccine_booking/view/welcome/welcome_screen.dart';
import 'package:vaccine_booking/view_model/auth_view_model.dart';
import 'package:vaccine_booking/view_model/profile_view_model.dart';

import '../../components/constants.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final deleteToken = Provider.of<AuthViewModel>(context);
    final user = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(gradient: gradientHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * 0.12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "Profile",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/icons/account.svg',
                          width: 96,
                          height: 96,
                          color: secondColor,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      detailProfile(context, user),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                            child: const Text(
                              "Edit Profile",
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).push(
                                NavigatorFadeTransition(
                                  child: const EditProfileScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/logout.svg',
                            color: primaryColor,
                            height: 28,
                            width: 28,
                          ),
                          TextButton(
                            onPressed: () {
                              deleteToken.deleteToken();
                              user.userData.clear();
                              user.familyList.clear();
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacement(
                                NavigatorFadeTransition(
                                  child: const WelcomeScreen(),
                                ),
                              );
                              Fluttertoast.showToast(msg: "Berhasil Keluar");
                            },
                            child: Text(
                              "keluar akun",
                              style: Theme.of(context).textTheme.subtitle1!,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
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

  Widget customProfile({String? icon, String? title, context}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset(
              icon!,
              width: 28,
              height: 28,
              color: primaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "$title",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
        Divider(
          thickness: 2,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }

  Widget detailProfile(context, ProfileViewModel profile) {
    return Column(
      children: [
        SizedBox(
          height: 45,
          child: customProfile(
              icon: 'assets/icons/user.svg',
              title: profile.name.isEmpty ? "Nama Lengkap" : profile.name,
              context: context),
        ),
        SizedBox(
          height: 45,
          child: customProfile(
              icon: 'assets/icons/badge.svg',
              title: profile.nik.isEmpty ? 'Nomor NIK' : profile.nik,
              context: context),
        ),
        SizedBox(
          height: 45,
          child: customProfile(
              icon: 'assets/icons/address.svg',
              title: profile.placeBirth.isEmpty
                  ? "Kota Lahir"
                  : profile.placeBirth,
              context: context),
        ),
        SizedBox(
          height: 45,
          child: customProfile(
              icon: 'assets/icons/datetime.svg',
              title: profile.dateBirth.isEmpty
                  ? "Tanggal Lahir"
                  : profile.dateBirth,
              context: context),
        ),
        SizedBox(
          height: 45,
          child: customProfile(
              icon: 'assets/icons/gender.svg',
              title: profile.gender.isEmpty
                  ? "Gender"
                  : profile.gender
                      .toLowerCase()
                      .replaceFirst(
                        profile.gender.toLowerCase()[0],
                        profile.gender.toUpperCase()[0],
                      )
                      .replaceAll('_', ' - '),
              context: context),
        ),
        SizedBox(
          height: 45,
          child: customProfile(
              icon: 'assets/icons/envelop.svg',
              title: profile.email.isEmpty ? "Alamat Email" : profile.email,
              context: context),
        ),
        SizedBox(
          height: 45,
          child: customProfile(
              icon: 'assets/icons/phone.svg',
              title: profile.phone.isEmpty ? "No hp" : profile.phone,
              context: context),
        ),
        SizedBox(
          height: 45,
          child: customProfile(
              icon: 'assets/icons/status.svg',
              title: profile.status.isEmpty
                  ? "Hubungan dalam keluarga"
                  : profile.status.toLowerCase().replaceFirst(
                        profile.status.toLowerCase()[0],
                        profile.status.toUpperCase()[0],
                      ),
              context: context),
        ),
        SizedBox(
          height: 45,
          child: customProfile(
              icon: 'assets/icons/address.svg',
              title: profile.idCardAddress.isEmpty
                  ? "Alamat berdasarkan KTP"
                  : profile.idCardAddress,
              context: context),
        ),
        SizedBox(
          height: 45,
          child: customProfile(
              icon: 'assets/icons/address.svg',
              title:
                  profile.address.isEmpty ? "Alamat domisili" : profile.address,
              context: context),
        ),
      ],
    );
  }
}
