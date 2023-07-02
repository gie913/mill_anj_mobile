import 'package:sounding_storage/model/verifier.dart';

class VerifierResponse {
  bool success;
  String message;
  List<Verifier> verifier;

  VerifierResponse({this.success, this.message, this.verifier});

  VerifierResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      verifier = [];
      json['data'].forEach((v) {
        verifier.add(Verifier.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.verifier != null) {
      data['data'] = this.verifier.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
