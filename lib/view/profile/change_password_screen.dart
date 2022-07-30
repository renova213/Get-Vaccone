import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/view_model/profile_view_model.dart';

import '../../components/constants.dart';
import '../../components/navigator_fade_transition.dart';
import '../../model/profile/user_model.dart';
import '../authentikasi/login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String getOldPassword = '';
  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  bool obscureText = true;
  bool obscureText2 = true;
  bool obscureText3 = true;
  bool isLoading = false;
  bool isInvalid = false;
  bool isInvalid2 = false;
  bool isInvalid2Long = false;
  bool isInvalid3 = false;

  int heightTextField = 0;

  final TextEditingController oldPasswordEditingController =
      TextEditingController();
  final TextEditingController newPasswordEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordEditingController =
      TextEditingController();

  @override
  void dispose() {
    oldPasswordEditingController.dispose();
    newPasswordEditingController.dispose();
    confirmPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    oldPasswordSave();
    super.initState();
  }

  oldPasswordSave() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    getOldPassword = prefs.getString('password')!;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileViewModel>(context);

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        oldPasswordField(context),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        newPasswordField(context),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        confirmPasswordField(context),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        confirmButton(context, user),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget oldPasswordField(
    context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 28),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/lock.svg',
            color: primaryColor,
            height: 32,
            width: 32,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: SizedBox(
              height: isInvalid ? 60 : 40,
              child: TextFormField(
                obscureText: obscureText,
                onChanged: (value) => setState(() => oldPassword = value),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade700),
                cursorColor: Colors.white,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(13),
                  FilteringTextInputFormatter.allow(
                    RegExp("[a-zA-Z0-9 ]"),
                  ),
                ],
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          obscureText = !obscureText;
                        },
                      );
                    },
                    child: obscureText
                        ? const Icon(
                            Icons.visibility_off_rounded,
                            color: Colors.grey,
                          )
                        : const Icon(Icons.visibility_rounded,
                            color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.only(
                      top: 8, left: 16, bottom: 8, right: 8),
                  hintText: "Masukan password lama",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey.shade500),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: pressedColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: pressedColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                textInputAction: TextInputAction.next,
                controller: oldPasswordEditingController,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      isInvalid = true;
                    });
                    return "Required";
                  } else if (value.length < 8) {
                    setState(() {
                      isInvalid = true;
                    });
                    return "Minimum password 8 character";
                  } else if (getOldPassword != oldPassword) {
                    setState(() {
                      isInvalid = true;
                    });
                    return "Password lamamu tidak sama";
                  }
                  setState(() {
                    isInvalid = false;
                  });
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget newPasswordField(
    context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 28),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/lock.svg',
            color: primaryColor,
            height: 32,
            width: 32,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: SizedBox(
              height: isInvalid2Long
                  ? 75
                  : isInvalid2
                      ? 60
                      : 40,
              child: TextFormField(
                obscureText: obscureText2,
                onChanged: (value) => setState(() => newPassword = value),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade700),
                cursorColor: Colors.white,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(13),
                  FilteringTextInputFormatter.allow(
                    RegExp("[a-zA-Z0-9 ]"),
                  ),
                ],
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          obscureText2 = !obscureText2;
                        },
                      );
                    },
                    child: obscureText2
                        ? const Icon(
                            Icons.visibility_off_rounded,
                            color: Colors.grey,
                          )
                        : const Icon(Icons.visibility_rounded,
                            color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.only(
                      top: 8, left: 16, bottom: 8, right: 8),
                  hintText: "Masukan password baru",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey.shade500),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: pressedColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: pressedColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                textInputAction: TextInputAction.next,
                controller: newPasswordEditingController,
                validator: (value) {
                  RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])');
                  if (value!.isEmpty) {
                    setState(() {
                      isInvalid2 = true;
                    });
                    return "Required";
                  } else if (value.length < 8) {
                    setState(() {
                      isInvalid2 = true;
                      isInvalid2Long = false;
                    });
                    return "Minimum password 8 character";
                  } else if (!regex.hasMatch(value)) {
                    setState(() {
                      isInvalid2Long = true;
                      isInvalid2 = false;
                    });
                    return "password harus mempunyai 1 huruf kapital\n, huruf kecil & angka";
                  }
                  setState(() {
                    isInvalid2 = false;
                    isInvalid2Long = false;
                  });
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget confirmPasswordField(
    context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 28),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/lock.svg',
            color: primaryColor,
            height: 32,
            width: 32,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: SizedBox(
              height: isInvalid3 ? 60 : 40,
              child: TextFormField(
                obscureText: obscureText3,
                onChanged: (value) => setState(() => confirmPassword = value),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey.shade700),
                cursorColor: Colors.white,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(13),
                  FilteringTextInputFormatter.allow(
                    RegExp("[a-zA-Z0-9 ]"),
                  ),
                ],
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          obscureText3 = !obscureText3;
                        },
                      );
                    },
                    child: obscureText3
                        ? const Icon(
                            Icons.visibility_off_rounded,
                            color: Colors.grey,
                          )
                        : const Icon(Icons.visibility_rounded,
                            color: Colors.grey),
                  ),
                  contentPadding: const EdgeInsets.only(
                      top: 8, left: 16, bottom: 8, right: 8),
                  hintText: "Masukan password baru",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey.shade500),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: pressedColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: pressedColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                textInputAction: TextInputAction.next,
                controller: confirmPasswordEditingController,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      isInvalid3 = true;
                    });
                    return "Required";
                  } else if (value.length < 8) {
                    setState(() {
                      isInvalid3 = true;
                    });
                    return "Minimum password 8 character";
                  } else if (newPassword != confirmPassword) {
                    setState(() {
                      isInvalid3 = true;
                    });
                    return "Password tidak sama";
                  }
                  setState(() {
                    isInvalid3 = false;
                  });
                  return null;
                },
              ),
            ),
          ),
        ],
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
          "Ubah Password",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget confirmButton(context, ProfileViewModel user) {
    return Center(
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.85,
        child: oldPassword.isEmpty ||
                newPassword.isEmpty ||
                confirmPassword.isEmpty
            ? ElevatedButton(
                onPressed: null,
                child: Text("Simpan",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
              )
            : ElevatedButton(
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Simpan",
                      ),
                onPressed: () async {
                  if (isLoading) return;

                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() => isLoading = true);
                    await Future.delayed(
                      const Duration(seconds: 1),
                    );
                    setState(() => isLoading = false);
                    try {
                      await user.editPassword(
                          user: UserModel(
                              id: user.filterUserProfile[0].id,
                              profile: user.filterUserProfile[0].profile,
                              username: user.filterUserProfile[0].username,
                              name: user.filterUserProfile[0].name,
                              email: user.filterUserProfile[0].email,
                              password: newPasswordEditingController.text),
                          id: user.filterUserProfile[0].id);
                      Fluttertoast.showToast(
                          msg:
                              "Berhasil mengubah password, silahkan login kembali");
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                        NavigatorFadeTransition(
                          child: const LoginScreen(),
                        ),
                        ModalRoute.withName('/home'),
                      );
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: e.toString(),
                      );
                    }
                  }
                },
              ),
      ),
    );
  }
}
