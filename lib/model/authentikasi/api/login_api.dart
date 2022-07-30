import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/model/authentikasi/login_model.dart';

import '../../../components/constants.dart';

class LoginApi {
  Future<String> postLogin({LoginModel? login}) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String? token;
    try {
      final response = await Dio().post(
        "$baseUrl/api/v1/auth/login/",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: login!.toJson(),
      );
      if (response.statusCode == 200) {
        await prefs.setString("token", response.data['data']["token"]);

        token = response.data['data']['token'];
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 400) {
          throw 'NIK Atau Password Salah';
        }
      } else {
        throw 'Ada masalah dengan koneksi ke server';
      }
    }
    return token!;
  }
}
