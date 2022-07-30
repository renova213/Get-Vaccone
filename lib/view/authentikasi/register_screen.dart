import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vaccine_booking/model/authentikasi/register_model.dart';
import 'package:vaccine_booking/view/authentikasi/login_screen.dart';

import '../../components/constants.dart';
import '../../components/navigator_fade_transition.dart';
import '../../view_model/auth_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  var obscureText = true;
  bool isLoading = false;
  String? name;
  String? nik;
  String? email;
  String? password;
  final _nameEditingController = TextEditingController();
  final _nikEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  @override
  void dispose() {
    _nameEditingController.dispose();
    _nikEditingController.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final register = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
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
                    "Register",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textFieldName("Nama Lengkap"),
                        const SizedBox(height: 4),
                        fieldNamaLengkap(),
                        const SizedBox(height: 8),
                        textFieldName("NIK"),
                        const SizedBox(height: 4),
                        fieldNIK(),
                        const SizedBox(height: 8),
                        textFieldName("Email"),
                        const SizedBox(height: 4),
                        textFieldEmail(),
                        const SizedBox(height: 8),
                        textFieldName("Password"),
                        const SizedBox(height: 4),
                        passwordFieldPassword(),
                        const SizedBox(height: 30),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: name == null ||
                                    password == null ||
                                    nik == null ||
                                    email == null ||
                                    name!.isEmpty ||
                                    password!.isEmpty ||
                                    nik!.isEmpty ||
                                    email!.isEmpty
                                ? ElevatedButton(
                                    onPressed: null,
                                    child: Text("Register",
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
                                            "REGISTER",
                                          ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        if (isLoading) return;
                                        setState(() => isLoading = true);
                                        try {
                                          await Future.delayed(
                                            const Duration(seconds: 2),
                                          )
                                              .then(
                                                (_) => setState(
                                                    () => isLoading = false),
                                              )
                                              .then(
                                                (_) async =>
                                                    await register.postRegister(
                                                  RegisterModel(
                                                    nik: _nikEditingController
                                                        .text,
                                                    email:
                                                        _emailEditingController
                                                            .text,
                                                    password:
                                                        _passwordEditingController
                                                            .text,
                                                    name: _nameEditingController
                                                        .text,
                                                    profile: {"role": "USER"},
                                                  ),
                                                ),
                                              )
                                              .then(
                                                (value) =>
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Berhasil Register'),
                                              )
                                              .then(
                                                (value) async =>
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                  NavigatorFadeTransition(
                                                    child: const LoginScreen(),
                                                  ),
                                                ),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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

  Widget fieldNamaLengkap() {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
        FilteringTextInputFormatter.allow(
          RegExp("[a-zA-Z ]"),
        ),
      ],
      onChanged: (value) => setState(
        () {
          name = value;
        },
      ),
      cursorColor: Colors.white,
      keyboardType: TextInputType.name,
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
      controller: _nameEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
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
        if (value!.isEmpty) {
          return "Required";
        } else if (value.length < 16) {
          return "use valid nik";
        }
        return null;
      },
    );
  }

  Widget passwordFieldPassword() {
    return TextFormField(
      onChanged: (value) => setState(
        () {
          password = value;
        },
      ),
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
      inputFormatters: [
        LengthLimitingTextInputFormatter(13),
        FilteringTextInputFormatter.allow(
          RegExp("[a-zA-Z0-9 ]"),
        ),
      ],
      controller: _passwordEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])');
        if (value!.isEmpty) {
          return "Required";
        } else if (!regex.hasMatch(value)) {
          return "password should contain at least one upper case\n, lower case & number";
        } else if (value.length < 8) {
          return "Minimum password 8 character";
        }
        return null;
      },
    );
  }

  Widget textFieldEmail() {
    return TextFormField(
      onChanged: (value) => setState(
        () {
          email = value;
        },
      ),
      cursorColor: Colors.white,
      keyboardType: TextInputType.emailAddress,
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
      controller: _emailEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return "Use valid email";
        }
        return null;
      },
    );
  }
}
