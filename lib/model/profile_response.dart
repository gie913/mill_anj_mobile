import 'package:sounding_storage/model/user.dart';

class ProfileResponse {
  bool success;
  String message;
  User user;

  ProfileResponse({this.success, this.message, this.user});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['data'] != null ? new User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}