import 'package:sounding_storage/model/setup.dart';
import 'package:sounding_storage/model/user.dart';

class Data {
  String token;
  User user;
  Setup setup;

  Data({this.token, this.user, this.setup});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    setup = json['setup'] != null ? new Setup.fromJson(json['setup']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.setup != null) {
      data['setup'] = this.setup.toJson();
    }
    return data;
  }
}