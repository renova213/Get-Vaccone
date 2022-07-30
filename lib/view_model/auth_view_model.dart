import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/model/authentikasi/api/login_api.dart';
import 'package:vaccine_booking/model/authentikasi/login_model.dart';
import 'package:vaccine_booking/model/authentikasi/register_model.dart';

import '../model/authentikasi/api/register_api.dart';

class AuthViewModel extends ChangeNotifier {
  SharedPreferences? _prefs;
  final loginApi = LoginApi();
  final registerApi = RegisterApi();

  deleteToken() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs!.remove('token');
    notifyListeners();
  }

  postLogin(LoginModel login) async {
    await loginApi.postLogin(login: login);
    notifyListeners();
  }

  postRegister(RegisterModel register) async {
    await registerApi.postLogin(register: register);
    notifyListeners();
  }
}
