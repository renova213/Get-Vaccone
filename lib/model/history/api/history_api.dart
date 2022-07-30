import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/model/history/history_model.dart';

import '../../../components/constants.dart';

class HistoryApi {
  getDetailBooking() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      final response = await Dio().get(
        "$baseUrl/api/v1/detail",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final detailBookingList = (response.data['data'] as List)
            .map((e) => HistoryModel.fromJson(e))
            .toList();
        return detailBookingList;
      }
    } catch (_) {}
  }
}
