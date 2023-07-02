import 'data.dart';

class Response {
  bool success;
  String message;
  Data data;

  Response({this.success, this.message, this.data});

  Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null || json[data] == [] ? Data.fromJson(json['data']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
