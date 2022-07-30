import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/components/botnavbar.dart';
import 'package:vaccine_booking/components/navigator_fade_transition.dart';
import 'package:vaccine_booking/view/authentikasi/register_screen.dart';
import 'package:vaccine_booking/view_model/auth_view_model.dart';

import '../../components/constants.dart';
// import '../../model/authentikasi/login_model.dart';
import '../../view_model/history_view_model.dart';
import '../../view_model/profile_view_model.dart';
import '../../view_model/vaksinasi_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _RegisterState();
}

class _RegisterState extends State<LoginScreen> {
  String? nik;
  String? password;
  var obscureText = true;
  bool isLoading = false;
  final _passwordEditingController = TextEditingController();
  final _nikEditingController = TextEditingController();

  @override
  void dispose() {
    _passwordEditingController.dispose();
    _nikEditingController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<AuthViewModel>(context);
    final user = Provider.of<ProfileViewModel>(context);
    final schedule = Provider.of<VaksinasiViewModel>(context);
    final history = Provider.of<HistoryViewModel>(context);
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    'assets/icons/arrow_back.svg',
                    width: 36,
                    height: 36,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textFieldName("NIK"),
                      const SizedBox(height: 4),
                      fieldNIK(),
                      const SizedBox(height: 8),
                      textFieldName("Password"),
                      const SizedBox(height: 4),
                      fieldPassowrd()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                loginButton(login, user, schedule, history),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Belum punya akun?",
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          NavigatorFadeTransition(
                            child: const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text("Register",
                          style: Theme.of(context).textTheme.headline4),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(login, ProfileViewModel user, VaksinasiViewModel schedule,
      HistoryViewModel history) {
    return Center(
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: nik == null ||
                password == null ||
                nik!.isEmpty ||
                password!.isEmpty
            ? ElevatedButton(
                onPressed: null,
                child: Text("Login",
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
                        "LOGIN",
                      ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (isLoading) return;
                    setState(() => isLoading = true);
                    SharedPreferences? prefs =
                        await SharedPreferences.getInstance();

                    try {
                      await Future.delayed(
                        const Duration(seconds: 2),
                      )
                          .then(
                            (_) async => await prefs.remove('password'),
                          )
                          .then((_) async => await prefs.remove('userId'))
                          .then(
                            (_) => prefs.setString(
                                'password', _passwordEditingController.text),
                          )
                          .then(
                            (value) async => await prefs.remove('token'),
                          )
                          .then(
                            (_) async => await prefs.remove('nik'),
                          )
                          .then(
                            (_) async => await prefs.setString(
                                'nik', _nikEditingController.text),
                          )
                          .then(
                            (_) async => await prefs
                                .setString(
                                    'password', _passwordEditingController.text)
                                .then(
                                  (_) => setState(() => isLoading = false),
                                ),
                          )
                          // .then(
                          //   (value) async => await login.postLogin(
                          //     LoginModel(
                          //       nik: _nikEditingController.text,
                          //       password: _passwordEditingController.text,
                          //     ),
                          //   ),
                          // )
                          .then(
                            (_) =>
                                Fluttertoast.showToast(msg: "Berhasil Login"),
                          )
                          .then((_) {
                            user.familyList.clear();
                            user.userFamily.clear();
                            user.userData.clear();
                            user.usersProfile.clear();
                            user.filterUserProfile.clear();
                            history.detailBookingList.clear();
                            history.filterDetailBookingList.clear();
                            history.filterNameBooking.clear();
                          })
                          .then((_) => isTrue = true)
                          .then(
                            (_) => Navigator.of(context).pushAndRemoveUntil(
                              NavigatorFadeTransition(
                                child: const BotNavBar(),
                              ),
                              ModalRoute.withName('/home'),
                            ),
                          );
                    } catch (e) {
                      Fluttertoast.showToast(
                        toastLength: Toast.LENGTH_SHORT,
                        msg: e.toString(),
                      );
                    }
                  }
                },
              ),
      ),
    );
  }

  Widget fieldPassowrd() {
    return TextFormField(
      onChanged: (value) => setState(
        () {
          password = value;
        },
      ),
      style: Theme.of(context).textTheme.bodyText1,
      obscureText: obscureText,
      cursorColor: Colors.white,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
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
              : const Icon(Icons.visibility_rounded, color: Colors.grey),
        ),
        hintText: 'input',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: buttonColorSecondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
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
      inputFormatters: [
        LengthLimitingTextInputFormatter(13),
        FilteringTextInputFormatter.allow(
          RegExp("[a-zA-Z0-9 ]"),
        ),
      ],
      controller: _passwordEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
        } else if (value.length < 8) {
          return "Minimum password 8 character";
        }
        return null;
      },
    );
  }

  Widget fieldNIK() {
    return TextFormField(
      onChanged: (value) => setState(
        () {
          nik = value;
        },
      ),
      style: Theme.of(context).textTheme.bodyText1,
      cursorColor: Colors.white,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
      ],
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
        hintText: 'input',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey.shade400),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: pressedColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: buttonColorSecondary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      textInputAction: TextInputAction.next,
      controller: _nikEditingController,
      validator: (value) {
        if (value!.length < 16) {
          return "use valid nik";
        }
        return null;
      },
    );
  }

  Widget textFieldName(label) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: defaultPadding / 3,
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.grey.shade700),
      ),
    );
  }
}
