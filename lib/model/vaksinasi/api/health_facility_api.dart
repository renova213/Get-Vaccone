import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/components/constants.dart';
import 'package:vaccine_booking/model/vaksinasi/health_facility_model.dart';

class HealthFacilityApi {
  getAllHealthFacilities() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      final response = await Dio().get(
        '$baseUrl/api/v1/facility/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final healthFacilitiesList = (response.data['data'] as List)
            .map((e) => HealthFacilityModel.fromJson(e))
            .toList();
        return healthFacilitiesList;
      }
    } catch (_) {}
  }
}
