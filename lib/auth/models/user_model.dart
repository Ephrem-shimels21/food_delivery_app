class UserModel {
  final String userid;
  final String phone;
  final String? email;
  final String password;

  UserModel(
      {required this.userid,
      required this.email,
      required this.password,
      required this.phone});

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data['userid'] = user.userid;
    data['email'] = user.email;
    data['phone'] = user.phone;
    data['password'] = user.password;
    return data;
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> mapData) {
    return UserModel(
      userid: mapData['userid'],
      email: mapData['email'],
      phone: mapData['phone'],
      password: mapData['password'],
    );
  }
}
