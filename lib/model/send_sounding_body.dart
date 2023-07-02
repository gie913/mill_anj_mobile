class SendSoundingBody {
  String number;
  String trTime;
  String note;
  double clarifierPureOil;
  double clarifier1;
  double clarifier2;
  List<SoundingCpoBody> soundingCpo;
  List<String> verificators;

  SendSoundingBody(
      {this.number,
      this.trTime,
      this.note,
      this.clarifierPureOil,
      this.clarifier1,
      this.clarifier2,
      this.soundingCpo});

  SendSoundingBody.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    trTime = json['tr_time'];
    note = json['note'];
    clarifierPureOil = json['clarifier_pure_oil'];
    clarifier1 = json['clarifier_tank_1'];
    clarifier2 = json['clarifier_tank_2'];
    if (json['sounding_cpo'] != null) {
      soundingCpo = [];
      json['sounding_cpo'].forEach((v) {
        soundingCpo.add(SoundingCpoBody.fromJson(v));
      });
    }
    verificators = json['verificators'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['number'] = this.number;
    data['tr_time'] = this.trTime;
    data['note'] = this.note;
    data['clarifier_pure_oil'] = this.clarifierPureOil;
    data['clarifier_tank_1'] = this.clarifier1;
    data['clarifier_tank_2'] = this.clarifier2;
    if (this.soundingCpo != null) {
      data['sounding_cpo'] = this.soundingCpo.map((v) => v.toJson()).toList();
    }
    data['verificators'] = this.verificators;
    return data;
  }
}

class SoundingCpoBody {
  String number;
  String trTime;
  double size;
  double sounding1;
  double sounding2;
  double sounding3;
  double sounding4;
  double sounding5;
  int maxSounding;
  double avgSounding;
  String mStorageTankId;
  String mStorageTankCode;
  bool isManual;
  bool usingCopyData;
  double roundingTonnage;
  double temperature;

  SoundingCpoBody(
      {this.number,
      this.trTime,
      this.size,
      this.sounding1,
      this.sounding2,
      this.sounding3,
      this.sounding4,
      this.sounding5,
      this.maxSounding,
      this.avgSounding,
      this.mStorageTankId,
      this.mStorageTankCode,
      this.isManual,
      this.usingCopyData,
      this.roundingTonnage,
      this.temperature});

  SoundingCpoBody.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    trTime = json['tr_time'];
    size = json['size'];
    sounding1 = json['sounding_1'];
    sounding2 = json['sounding_2'];
    sounding3 = json['sounding_3'];
    sounding4 = json['sounding_4'];
    sounding5 = json['sounding_5'];
    maxSounding = json['max_sounding'];
    avgSounding = json['avg_sounding'];
    mStorageTankId = json['m_storage_tank_id'];
    mStorageTankCode = json['m_storage_tank_code'];
    isManual = json["is_manual"];
    usingCopyData = json['using_copy_data'];
    temperature = json['temperature'];
    roundingTonnage = json['rounding_tonnage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['number'] = this.number;
    data['tr_time'] = this.trTime;
    data['size'] = this.size;
    data['sounding_1'] = this.sounding1;
    data['sounding_2'] = this.sounding2;
    data['sounding_3'] = this.sounding3;
    data['sounding_4'] = this.sounding4;
    data['sounding_5'] = this.sounding5;
    data['max_sounding'] = this.maxSounding;
    data['avg_sounding'] = this.avgSounding;
    data['m_storage_tank_id'] = this.mStorageTankId;
    data['m_storage_tank_code'] = this.mStorageTankCode;
    data["is_manual"] = this.isManual;
    data['using_copy_data'] = this.usingCopyData;
    data['rounding_tonnage'] = this.roundingTonnage;
    data['temperature'] = this.temperature;
    return data;
  }
}
