class BookingModel {
  int? id;
  int? bookingPass;
  String bookingDate;
  Map<String, dynamic> schedule;
  Map<String, dynamic> user;

  BookingModel(
      {required this.bookingDate,
      required this.schedule,
      required this.user,
      this.id,
      this.bookingPass});

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
      bookingDate: json['booking_date'],
      schedule: json['schedule'],
      user: json['user'],
      id: json['id'],
      bookingPass: json['booking_pass']);

  Map<String, dynamic> toJson() =>
      {'booking_date': bookingDate, 'schedule': schedule, 'user': user};
}
