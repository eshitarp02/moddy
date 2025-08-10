class SignUpResponseModel {
  String? message;
  String? userId;

  SignUpResponseModel({
    this.message,
    this.userId,
  });

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['userId'] = userId;
    return data;
  }
}
