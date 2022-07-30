import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/model/profile/user_model.dart';

import '../../../components/constants.dart';
import '../family_model.dart';

class UserApi {
  getAllFamilies() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      final response = await Dio().get(
        '$baseUrl/api/v1/family/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final familyList = (response.data['data'] as List)
            .map(
              (e) => FamilyModel.fromJson(e),
            )
            .toList();
        return familyList;
      }
    } catch (_) {}
  }

  editUser({int? id, FamilyModel? profile}) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      await Dio().put(
        '$baseUrl/api/v1/family/$id',
        data: profile!.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      if (e is DioError) {
        throw e.response!.data['error'].toString();
      }
    }
  }

  addFamily({FamilyModel? profile}) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      await Dio().post(
        '$baseUrl/api/v1/family/',
        data: profile!.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      if (e is DioError) {
        throw e.response!.data['error'].toString();
      }
    }
  }

  editFamily({FamilyModel? profile, int? id}) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      await Dio().put(
        '$baseUrl/api/v1/family/$id',
        data: profile!.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      if (e is DioError) {
        throw e.response!.data['error'].toString();
      }
    }
  }

  deleteFamily({int? id}) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      await Dio().delete(
        '$baseUrl/api/v1/family/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      if (e is DioError) {
        throw e.response!.data['error'].toString();
      }
    }
  }

  getUserProfile() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      final response = await Dio().get(
        '$baseUrl/api/v1/user/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final usersProfile = (response.data['data'] as List)
            .map(
              (e) => UserModel.fromJson(e),
            )
            .toList();
        return usersProfile;
      }
    } catch (_) {}
  }

  editPasswordUser({UserModel? user, int? id}) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      await Dio().put(
        '$baseUrl/api/v1/user/$id',
        data: user!.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      if (e is DioError) {
        throw e.response!.data['error'].toString();
      }
    }
  }
}
