import 'package:dio/dio.dart';

import '../../../components/constants.dart';
import '../register_model.dart';

class RegisterApi {
  postLogin({RegisterModel? register}) async {
    try {
      await Dio().post(
        "$baseUrl/api/v1/auth/register",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: register!.toJson(),
      );
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 409) {
          throw 'NIK Sudah Digunakan';
        } else {
          throw 'Ada masalah dengan koneksi ke server';
        }
      }
    }
  }
}
