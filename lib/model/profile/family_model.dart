class FamilyModel {
  int? id;
  String? statusFamily;
  String? name;
  String? nik;
  String? email;
  String? phone;
  String? gender;
  String? dateBirth;
  String? address;
  String? idCardAddress;
  String? placeBirth;
  Map<String, dynamic>? profile;

  FamilyModel(
      {this.id,
      this.name,
      this.nik,
      this.profile,
      this.email,
      this.statusFamily,
      this.phone,
      this.gender,
      this.dateBirth,
      this.address,
      this.idCardAddress,
      this.placeBirth});

  factory FamilyModel.fromJson(Map<String, dynamic> json) => FamilyModel(
      id: json['id'],
      name: json['name'],
      nik: json['nik'],
      profile: json['profile'],
      email: json['email'],
      statusFamily: json['status_in_family'],
      phone: json['phone_number'],
      gender: json['gender'],
      dateBirth: json['date_of_birth'],
      address: json['residence_address'],
      idCardAddress: json['id_card_address'],
      placeBirth: json['place_of_birth']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "profile": profile,
        "email": email,
        "status_in_family": statusFamily,
        "phone_number": phone,
        "gender": gender,
        "date_of_birth": dateBirth,
        "residence_address": address,
        "id_card_address": idCardAddress,
        "place_of_birth": placeBirth
      };
}
