import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_booking/view/profile/edit_profile.dart';

import '../../components/constants.dart';
import '../../components/navigator_fade_transition.dart';
import '../../view_model/profile_view_model.dart';
import 'edit_family_screen.dart';
import 'register_family_screen.dart';

class FamilyMemberScreen extends StatefulWidget {
  const FamilyMemberScreen({Key? key}) : super(key: key);

  @override
  State<FamilyMemberScreen> createState() => _FamilyMemberScreenState();
}

class _FamilyMemberScreenState extends State<FamilyMemberScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileViewModel>(context);
    if (user.familyList.isEmpty) {
      Provider.of<ProfileViewModel>(context).getAllFamilies();
    }
    if (user.userFamily.isEmpty) {
      Provider.of<ProfileViewModel>(context).filterUserFamily();
    }

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
              headline(context, user),
              const SizedBox(
                height: 16,
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
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 108 * user.userFamily.length.toDouble(),
                        child: listDaftarAnggota(user),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      addFamilyButton(),
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

  Widget addFamilyButton() {
    return Center(
      child: SizedBox(
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/adduser.svg',
                color: Colors.white,
                height: 22,
                width: 22,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                "Tambah Keluarga",
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              NavigatorFadeTransition(
                child: const RegisterFamilyScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget listDaftarAnggota(ProfileViewModel user) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.white,
        );
      },
      itemCount: user.userFamily.length,
      itemBuilder: (context, index) {
        return Container(
          height: 78,
          decoration: BoxDecoration(
            color: secondColorLow,
            border: Border.all(color: secondColorLow, width: 0),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user.userFamily[index].name!,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          user.userFamily[index].name == user.name
                              ? "Saya"
                              : user.userFamily[index].statusFamily!
                                  .toLowerCase()
                                  .replaceFirst(
                                    user.userFamily[index].statusFamily!
                                        .toLowerCase()[0],
                                    user.userFamily[index].statusFamily!
                                        .toUpperCase()[0],
                                  ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "NIK :",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.grey.shade900),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          user.userFamily[index].nik!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.grey.shade900),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => user.userFamily[index].name == user.name
                          ? Navigator.of(context, rootNavigator: true).push(
                              NavigatorFadeTransition(
                                child: const EditProfileScreen(),
                              ),
                            )
                          : Navigator.of(context, rootNavigator: true).push(
                              NavigatorFadeTransition(
                                child: EditFamilyScreen(
                                  family: user.userFamily[index],
                                ),
                              ),
                            ),
                      child: SvgPicture.asset(
                        'assets/icons/edit2.svg',
                        color: Colors.black,
                        width: 25,
                        height: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    user.userFamily[index].name == user.name
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return modalDataAlert(context, index, user);
                                },
                              );
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/delete.svg',
                              color: Colors.black,
                              width: 25,
                              height: 25,
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget headline(context, ProfileViewModel user) {
    return Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height * 0.10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          "Anggota Keluarga",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget modalDataAlert(context, index, ProfileViewModel user) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 330,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child:
                      Icon(Icons.close, color: Colors.grey.shade500, size: 32),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.135,
                child: Image.asset('assets/images/warning.png'),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Jika tekan ya, operasi tidak dapat dibatalkan",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () async {
                      await Future.delayed(
                        const Duration(seconds: 0),
                      )
                          .then(
                            (_) async => await user.deleteFamily(
                                id: user.userFamily[index].id),
                          )
                          .then(
                            (_) => user.familyList.clear(),
                          )
                          .then(
                            (_) => user.getAllFamilies(),
                          )
                          .then(
                            (_) => Future.delayed(
                              const Duration(milliseconds: 500),
                            ),
                          )
                          .then(
                            (_) => user.userFamily.clear(),
                          )
                          .then(
                            (_) => user.filterUserFamily(),
                          )
                          .then(
                            (_) => Future.delayed(
                              const Duration(milliseconds: 500),
                            ),
                          )
                          .then(
                        (_) {
                          Fluttertoast.showToast(
                              toastLength: Toast.LENGTH_SHORT,
                              msg: "Family Member Berhasil Dihapus");
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Text(
                      "Ya",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Tidak",
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
