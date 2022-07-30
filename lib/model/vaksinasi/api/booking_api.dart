import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_booking/model/vaksinasi/booking_model.dart';
import 'package:vaccine_booking/model/vaksinasi/datail_booking_model.dart';

import '../../../components/constants.dart';

class BookingApi {
  postBooking({BookingModel? booking}) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      await Dio().post(
        "$baseUrl/api/v1/booking/",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: booking!.toJson(),
      );
    } on Exception catch (e) {
      if (e is DioError) {}
    }
  }

  getBooking() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      final response = await Dio().get(
        "$baseUrl/api/v1/booking/",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final bookingList = (response.data['data'] as List)
            .map((e) => BookingModel.fromJson(e))
            .toList();
        return bookingList;
      }
    } catch (_) {}
  }

  postDetailBooking({DetailBookingModel? booking}) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      await Dio().post(
        "$baseUrl/api/v1/detail/",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: booking!.toJson(),
      );
    } on Exception catch (e) {
      if (e is DioError) {}
    }
  }
}
