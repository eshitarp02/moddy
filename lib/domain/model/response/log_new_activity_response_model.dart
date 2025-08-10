class LogNewActivityResponseModel {
  String? message;
  String? activityId;
  String? error;

  LogNewActivityResponseModel({
    this.message,
    this.activityId,
    this.error,
  });

  LogNewActivityResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    activityId = json['activityId'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['activityId'] = activityId;
    data['error'] = error;
    return data;
  }
}
