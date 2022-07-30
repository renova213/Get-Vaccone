import 'package:flutter/cupertino.dart';
import 'package:vaccine_booking/model/history/api/history_api.dart';
import 'package:vaccine_booking/model/history/history_model.dart';

class HistoryViewModel extends ChangeNotifier {
  List<HistoryModel> detailBookingList = [];
  List<HistoryModel> filterDetailBookingList = [];
  List<HistoryModel> filterDetailVaksinasiOrder = [];
  List<HistoryModel> filterNameBooking = [];
  final historyApi = HistoryApi();

  getDetailBooking() async {
    final detailBooking = await historyApi.getDetailBooking();
    if (detailBooking != null) {
      detailBookingList = detailBooking;
    }
    notifyListeners();
  }

  filterDetailBooking(int id) {
    filterDetailBookingList = detailBookingList
        .where((element) => element.booking!['user']['id'] == id)
        .toList();
  }

  filterBookingName() {
    for (int i = 0; i < filterDetailBookingList.length; i++) {
      final contains = filterNameBooking.where(
        (element) =>
            element.family!['nik'] == filterDetailBookingList[i].family!['nik'],
      );
      if (contains.isEmpty) {
        filterNameBooking.add(filterDetailBookingList[i]);
      }
    }
  }

  filterVaksinasiOrder(String nik) {
    filterDetailVaksinasiOrder.clear();
    filterDetailVaksinasiOrder = filterDetailBookingList
        .where((element) => element.family!['nik'] == nik)
        .toList();
  }
}
