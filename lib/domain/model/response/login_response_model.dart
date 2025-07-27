class LoginResponseModel {
  int? status;
  String? message;
  String? token;
  ProfileData? profileData;

  LoginResponseModel({
    this.status,
    this.message,
    this.token,
    this.profileData,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    profileData = json['profileData'] != null
        ? ProfileData.fromJson(json['profileData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (profileData != null) {
      data['profileData'] = profileData!.toJson();
    }
    return data;
  }
}

class ProfileData {
  int? id;
  String? firstName;
  String? lastName;
  String? identityId;
  String? password;
  TimeZone? timeZone;

  ProfileData({
    this.id,
    this.firstName,
    this.lastName,
    this.identityId,
    this.password,
    this.timeZone,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    identityId = json['identityId'];
    password = json['password'];
    timeZone = json['timeZone'] != null
        ? TimeZone.fromJson(json['timeZone'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['identityId'] = identityId;
    data['password'] = password;
    if (timeZone != null) {
      data['timeZone'] = timeZone!.toJson();
    }
    return data;
  }
}

class TimeZone {
  String? name;
  String? abbreviation;
  String? utcOffset;

  TimeZone({
    this.name,
    this.abbreviation,
    this.utcOffset,
  });

  TimeZone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    abbreviation = json['abbreviation'];
    utcOffset = json['utcOffset'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['abbreviation'] = abbreviation;
    data['utcOffset'] = utcOffset;
    return data;
  }
}
