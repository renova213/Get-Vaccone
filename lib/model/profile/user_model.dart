class UserModel {
  int id;
  String username;
  String name;
  String email;
  String password;
  Map<String, dynamic> profile;
  UserModel(
      {required this.profile,
      required this.username,
      required this.name,
      required this.email,
      required this.password,
      required this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        profile: json['profile'],
        username: json['username'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile,
        "username": username,
        "name": name,
        "email": email,
        "password": password,
        "id": id,
      };
}
