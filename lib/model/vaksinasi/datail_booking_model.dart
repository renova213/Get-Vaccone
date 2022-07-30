class DetailBookingModel {
  int? bookingId;
  int? familyId;
  String? bookingStatus;
  Map<String, dynamic>? family;
  Map<String, dynamic>? booking;
  DetailBookingModel(
      {this.bookingId,
      this.familyId,
      this.bookingStatus,
      this.booking,
      this.family});

  factory DetailBookingModel.fromJson(Map<String, dynamic> json) =>
      DetailBookingModel(
          bookingId: json['booking_id'],
          familyId: json['family_id'],
          bookingStatus: json['booking_status'],
          family: json['family'],
          booking: json['booking']);

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "family_id": familyId,
        "booking_status": bookingStatus,
        "family": family,
        "booking": booking
      };
}
