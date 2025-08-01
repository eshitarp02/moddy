class LoginRequestModel {
  String? username;
  String? password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
