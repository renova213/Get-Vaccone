class HistoryModel {
  Map<String, dynamic>? family;
  Map<String, dynamic>? booking;
  HistoryModel({this.family, this.booking});

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        family: json['family'],
        booking: json['booking'],
      );
}
