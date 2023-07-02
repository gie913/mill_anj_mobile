import 'package:sounding_storage/model/quality_check.dart';

class Quality {
  String number;
  String trTime;
  String createdBy;
  String sent;
  List<QualityCheck> qualityCheck;

  Quality({this.number, this.trTime, this.qualityCheck});

  Quality.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    trTime = json['tr_time'];
    sent = json['sent'];
    createdBy = json['created_by'];
    if (json['quality_check'] != null) {
      qualityCheck = [];
      json['quality_check'].forEach((v) {
        qualityCheck.add(new QualityCheck.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['tr_time'] = this.trTime;
    data['sent'] = this.sent;
    data['created_by'] = this.createdBy;
    if (this.qualityCheck != null) {
      data['quality_check'] = this.qualityCheck.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
