class LoginModel {
  String? nik;
  String? password;

  LoginModel({this.nik, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        nik: json['username'],
        password: json['password'],
      );
  Map<String, dynamic> toJson() => {
        'username': nik,
        'password': password,
      };
}
