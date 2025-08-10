class LogNewActivityRequestModel {
  String? userId;
  String? activityType;
  String? description;
  String? bookmark;
  String? mood;
  String? timestamp;

  LogNewActivityRequestModel({
    this.userId,
    this.activityType,
    this.description,
    this.bookmark,
    this.mood,
    this.timestamp,
  });

  LogNewActivityRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    activityType = json['activityType'];
    description = json['description'];
    bookmark = json['bookmark'];
    mood = json['mood'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['activityType'] = activityType;
    data['description'] = description;
    data['bookmark'] = bookmark;
    if ((mood ?? '').isNotEmpty) {
      data['mood'] = mood;
    }
    data['timestamp'] = timestamp;
    return data;
  }
}
