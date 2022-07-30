import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vaccine_booking/model/vaksinasi/api/booking_api.dart';
import 'package:vaccine_booking/model/vaksinasi/api/schedule_api.dart';
import 'package:vaccine_booking/model/vaksinasi/datail_booking_model.dart';
import 'package:vaccine_booking/model/vaksinasi/health_facility_model.dart';
import 'package:vaccine_booking/model/vaksinasi/schedule_model.dart';

import '../model/profile/family_model.dart';
import '../model/vaksinasi/api/health_facility_api.dart';
import '../model/vaksinasi/booking_model.dart';

class VaksinasiViewModel extends ChangeNotifier {
  final vaksinasiApi = HealthFacilityApi();
  final scheduleApi = ScheduleApi();
  final bookingApi = BookingApi();
  List<HealthFacilityModel> facilityList = [];
  List<HealthFacilityModel> result = [];
  List<HealthFacilityModel> moreResult = [];
  List<ScheduleModel> scheduleList = [];
  List<ScheduleModel> filterScheduleList = [];
  List<ScheduleModel> filterScheduleSessionList = [];
  List<FamilyModel> selectBookingVaksinasiList = [];
  List<BookingModel> bookingList = [];
  List<BookingModel> filterBookingList = [];

  int scheduleIdBooking = 0;

  int scheduleId1 = 0;
  int scheduleId2 = 0;
  int scheduleId3 = 0;
  int scheduleId4 = 0;
  String vaccine1 = '-';
  String vaccine2 = '-';
  String vaccine3 = '-';
  String vaccine4 = '-';
  String timeStart1 = '00:00';
  String timeStart2 = '00:00';
  String timeStart3 = '00:00';
  String timeStart4 = '00:00';
  String timeEnd1 = '00:00';
  String timeEnd2 = '00:00';
  String timeEnd3 = '00:00';
  String timeEnd4 = '00:00';
  String dosis1 = 'Dosis_0';
  String dosis2 = 'Dosis_0';
  String dosis3 = 'Dosis_0';
  String dosis4 = 'Dosis_0';
  int stock1 = 0;
  int stock2 = 0;
  int stock3 = 0;
  int stock4 = 0;

  addSelectBookingVaksinasi(FamilyModel? family) {
    if (family != null) {
      selectBookingVaksinasiList.add(family);
    }
    notifyListeners();
  }

  deleteSelectBookingVaksinasi(FamilyModel? family) {
    if (family != null) {
      selectBookingVaksinasiList.removeWhere(
        (element) => element.name!.toLowerCase().contains(
              family.name!.toLowerCase(),
            ),
      );
    }
    notifyListeners();
  }

  postBooking({BookingModel? booking}) async {
    await bookingApi.postBooking(booking: booking);
    notifyListeners();
  }

  postDetailBooking(DetailBookingModel? booking) async {
    await bookingApi.postDetailBooking(booking: booking);
    notifyListeners();
  }

  getAllHealthFacilities() async {
    final getAllFacilities = await vaksinasiApi.getAllHealthFacilities();

    if (getAllFacilities != null) {
      facilityList = getAllFacilities;
    }

    notifyListeners();
  }

  getBookingList() async {
    final bookings = await bookingApi.getBooking();
    bookingList = bookings;
    notifyListeners();
  }

  filterBooking(int? userId, int? scheduleId) {
    filterBookingList = bookingList
        .where(
          (element) =>
              element.user.containsValue(userId) &&
              element.schedule.containsValue(scheduleId),
        )
        .toList();
    filterBookingList.sort(
      (a, b) => a.bookingPass!.compareTo(b.bookingPass!),
    );
  }

  searchFacility({String? query}) async {
    if (query == "") {
      return result = facilityList;
    } else if (query != null) {
      result = facilityList
          .where(
            (element) =>
                element.province!.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                element.city!.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                element.postalCode!.toString().contains(query) ||
                element.facilityName!.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
          )
          .toList();
      if (result.isEmpty) {
        Fluttertoast.showToast(msg: "Pencarian Tidak Ditemukan");
      }
    }
    notifyListeners();
  }

  searchMoreFacility({String? query, String? query2}) async {
    if (query2 == "") {
      result = facilityList;
    } else if (query == "") {
      moreResult = result;
    } else if (query != null) {
      moreResult = result
          .where(
            (element) =>
                element.province!.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                element.city!.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                element.postalCode!.toString().contains(query) ||
                element.facilityName!.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
          )
          .toList();
      if (moreResult.isEmpty) {
        Fluttertoast.showToast(msg: "Pencarian Tidak Ditemukan");
      }
    }
  }

  getAllSchedule() async {
    final getAllSchedule = await scheduleApi.getAllSchedules();
    if (getAllSchedule != null) {
      scheduleList = getAllSchedule;
    }
    notifyListeners();
  }

  filterSchedule(int id) {
    filterScheduleList = scheduleList
        .where((element) => element.facility.containsValue(id))
        .toList();
  }

  filterScheduleSession(String date, int id) {
    filterScheduleSessionList = filterScheduleList
        .where(
          (element) =>
              element.vaccinationDate.contains(date) &&
              element.facility['id'] == id,
        )
        .toList();
  }

  filterSelectVaccine() {
    if (filterScheduleSessionList.length == 1) {
      vaccine1 = filterScheduleSessionList[0].vaccine['vaccine_name'];
      dosis1 = filterScheduleSessionList[0].dose;
      timeStart1 = filterScheduleSessionList[0].operationalHourStart;
      timeEnd1 = filterScheduleSessionList[0].operationalHourEnd;
      stock1 = filterScheduleSessionList[0].quota;
      scheduleId1 = filterScheduleSessionList[0].id;
    }
    if (filterScheduleSessionList.length == 2) {
      vaccine1 = filterScheduleSessionList[0].vaccine['vaccine_name'];
      dosis1 = filterScheduleSessionList[0].dose;
      timeStart1 = filterScheduleSessionList[0].operationalHourStart;
      timeEnd1 = filterScheduleSessionList[0].operationalHourEnd;
      stock1 = filterScheduleSessionList[0].quota;
      scheduleId1 = filterScheduleSessionList[0].id;

      vaccine2 = filterScheduleSessionList[1].vaccine['vaccine_name'];
      dosis2 = filterScheduleSessionList[1].dose;
      timeStart2 = filterScheduleSessionList[1].operationalHourStart;
      timeEnd2 = filterScheduleSessionList[1].operationalHourEnd;
      stock2 = filterScheduleSessionList[1].quota;
      scheduleId2 = filterScheduleSessionList[1].id;
    }
    if (filterScheduleSessionList.length == 3) {
      vaccine1 = filterScheduleSessionList[0].vaccine['vaccine_name'];
      dosis1 = filterScheduleSessionList[0].dose;
      timeStart1 = filterScheduleSessionList[0].operationalHourStart;
      timeEnd1 = filterScheduleSessionList[0].operationalHourEnd;
      stock1 = filterScheduleSessionList[0].quota;
      scheduleId1 = filterScheduleSessionList[0].id;

      vaccine2 = filterScheduleSessionList[1].vaccine['vaccine_name'];
      dosis2 = filterScheduleSessionList[1].dose;
      timeStart2 = filterScheduleSessionList[1].operationalHourStart;
      timeEnd2 = filterScheduleSessionList[1].operationalHourEnd;
      stock2 = filterScheduleSessionList[1].quota;
      scheduleId2 = filterScheduleSessionList[1].id;

      vaccine3 = filterScheduleSessionList[2].vaccine['vaccine_name'];
      dosis3 = filterScheduleSessionList[2].dose;
      timeStart3 = filterScheduleSessionList[2].operationalHourStart;
      timeEnd3 = filterScheduleSessionList[2].operationalHourEnd;
      stock3 = filterScheduleSessionList[2].quota;
      scheduleId3 = filterScheduleSessionList[2].id;
    }

    if (filterScheduleSessionList.length == 4) {
      vaccine1 = filterScheduleSessionList[0].vaccine['vaccine_name'];
      dosis1 = filterScheduleSessionList[0].dose;
      timeStart1 = filterScheduleSessionList[0].operationalHourStart;
      timeEnd1 = filterScheduleSessionList[0].operationalHourEnd;
      stock1 = filterScheduleSessionList[0].quota;
      scheduleId1 = filterScheduleSessionList[0].id;

      vaccine2 = filterScheduleSessionList[1].vaccine['vaccine_name'];
      dosis2 = filterScheduleSessionList[1].dose;
      timeStart2 = filterScheduleSessionList[1].operationalHourStart;
      timeEnd2 = filterScheduleSessionList[1].operationalHourEnd;
      stock2 = filterScheduleSessionList[1].quota;
      scheduleId2 = filterScheduleSessionList[1].id;

      vaccine3 = filterScheduleSessionList[2].vaccine['vaccine_name'];
      dosis3 = filterScheduleSessionList[2].dose;
      timeStart3 = filterScheduleSessionList[2].operationalHourStart;
      timeEnd3 = filterScheduleSessionList[2].operationalHourEnd;
      stock3 = filterScheduleSessionList[2].quota;
      scheduleId3 = filterScheduleSessionList[2].id;

      vaccine4 = filterScheduleSessionList[3].vaccine['vaccine_name'];
      dosis4 = filterScheduleSessionList[3].dose;
      timeStart4 = filterScheduleSessionList[3].operationalHourStart;
      timeEnd4 = filterScheduleSessionList[3].operationalHourEnd;
      stock4 = filterScheduleSessionList[3].quota;
      scheduleId4 = filterScheduleSessionList[3].id;
    }
  }
}
