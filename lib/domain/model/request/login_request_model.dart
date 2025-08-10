class LoginRequestModel {
  String? name;
  String? password;

  LoginRequestModel({
    this.name,
    this.password,
  });

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['password'] = password;
    return data;
  }
}
