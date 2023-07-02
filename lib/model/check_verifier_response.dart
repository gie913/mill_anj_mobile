import 'data_verifier.dart';

class CheckVerifierResponse {
  bool success;
  String message;
  DataVerifier data;

  CheckVerifierResponse({this.success, this.message, this.data});

  CheckVerifierResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new DataVerifier.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
