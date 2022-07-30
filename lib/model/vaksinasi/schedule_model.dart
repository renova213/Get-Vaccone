class ScheduleModel {
  int id;
  String vaccinationDate;
  String operationalHourStart;
  String operationalHourEnd;
  int quota;
  String dose;
  Map<String, dynamic> facility;
  Map<String, dynamic> vaccine;

  ScheduleModel(
      {required this.id,
      required this.vaccinationDate,
      required this.operationalHourStart,
      required this.operationalHourEnd,
      required this.quota,
      required this.dose,
      required this.facility,
      required this.vaccine});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json['id'],
        vaccinationDate: json['vaccination_date'],
        operationalHourStart: json['operational_hour_start'],
        operationalHourEnd: json['operational_hour_end'],
        quota: json['quota'],
        dose: json['dose'],
        facility: json['facility'],
        vaccine: json['vaccine'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vaccination_date": vaccinationDate,
        "operational_hour_start": operationalHourStart,
        "operational_hour_end": operationalHourEnd,
        "quota": quota,
        "dose": dose,
        "facility": facility,
        "vaccine": vaccine
      };
}
