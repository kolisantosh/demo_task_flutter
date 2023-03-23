class UsersModel {
  final String name;
  final String email, mobile, token;

  UsersModel(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.token});

  factory UsersModel.fromRTDB(Map<String, dynamic> data) {
    return UsersModel(
        name: data['name'],
        email: data['email'],
        mobile: data['mobile'],
        token: data['token']);
  }
}
