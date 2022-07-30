import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/components/constants.dart';

import '../schedule_model.dart';

class ScheduleApi {
  getAllSchedules() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      final response = await Dio().get(
        '$baseUrl/api/v1/schedule',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final schedules = (response.data['data'] as List)
            .map((e) => ScheduleModel.fromJson(e))
            .toList();
        return schedules;
      }
    } catch (_) {}
  }
}
