class SignUpRequestModel {
  String? action;
  String? name;
  String? email;
  String? password;
  String? provider;

  SignUpRequestModel({
    this.action,
    this.name,
    this.email,
    this.password,
    this.provider,
  });

  SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] = action;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['provider'] = provider;
    return data;
  }
}
