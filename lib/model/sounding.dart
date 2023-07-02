import 'package:sounding_storage/model/sounding_cpo.dart';

class Sounding {
  String number;
  String trTime;
  int totalStock;
  int additional;
  String note;
  String createdBy;
  String sent;
  double clarifierPureOil;
  double clarifier1;
  double clarifier2;
  String production;
  List<SoundingCpo> soundingCpo;

  Sounding(
      {this.number,
      this.trTime,
      this.totalStock,
      this.additional,
      this.note,
      this.sent,
      this.production,
      this.clarifierPureOil,
      this.clarifier1,
      this.clarifier2,
      this.createdBy,
      this.soundingCpo});

  Sounding.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    trTime = json['tr_time'];
    totalStock = json['total_stock'];
    additional = json['additional'];
    note = json['note'];
    production = json['production'];
    sent = json['sounding_sent'];
    clarifierPureOil = json['clarifier_pure_oil'];
    clarifier1 = json['clarifier_tank_1'];
    clarifier2 = json['clarifier_tank_2'];
    createdBy = json['created_by'];
    if (json['sounding_cpo'] != null) {
      soundingCpo = [];
      json['sounding_cpo'].forEach((v) {
        soundingCpo.add(new SoundingCpo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['tr_time'] = this.trTime;
    data['total_stock'] = this.totalStock;
    data['additional'] = this.additional;
    data['note'] = this.note;
    data['clarifier_pure_oil'] = this.clarifierPureOil;
    data['clarifier_tank_1'] = this.clarifier1;
    data['clarifier_tank_2'] = this.clarifier2;
    data['production'] = this.production;
    data['sounding_sent'] = this.sent;
    data['created_by'] = this.createdBy;
    if (this.soundingCpo != null) {
      data['sounding_cpo'] = this.soundingCpo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
