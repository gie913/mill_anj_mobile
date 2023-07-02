
class SoundingCpo {
  String number;
  String trTime;
  double sounding1;
  double sounding2;
  double sounding3;
  double sounding4;
  double sounding5;
  int maxSounding;
  double avgSounding;
  String mStorageTankId;
  String mStorageTankCode;
  double temperature;
  double volumeCm;
  double volumeMm;
  double totalVolume;
  double size;
  double roundingVolume;
  double constantaExpansion;
  double density;
  bool isManual;
  bool usingCopyData;
  String soundingId;
  double weightStorage;
  String createdBy;
  double roundingTonnage;
  SoundingCpo(
      {this.number,
        this.trTime,
        this.soundingId,
        this.sounding1,
        this.sounding2,
        this.sounding3,
        this.sounding4,
        this.sounding5,
        this.maxSounding,
        this.avgSounding,
        this.mStorageTankId,
        this.mStorageTankCode,
        this.temperature,
        this.volumeCm,
        this.volumeMm,
        this.size,
        this.totalVolume,
        this.roundingVolume,
        this.constantaExpansion,
        this.density,
        this.isManual,
        this.usingCopyData,
        this.weightStorage,
        this.createdBy,
        this.roundingTonnage});

  SoundingCpo.fromJson(Map<String, dynamic> json) {
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
    temperature = json['temperature'];
    volumeCm = json['volume_cm'];
    volumeMm = json['volume_mm'];
    totalVolume = json['total_volume'];
    roundingVolume = json['rounding_volume'];
    constantaExpansion = json['constanta_expansion'];
    density = json['density'];
    if (json['is_manual'] == 1) {
      isManual = true;
    } else {
      isManual = false;
    }
    if (json['using_copy_data'] == 1) {
      usingCopyData = true;
    } else {
      usingCopyData = false;
    }
    weightStorage = json['weight_storage'];
    createdBy = json['created_by'];
    roundingTonnage = json['rounding_tonnage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['tr_time'] = this.trTime;
    data['size'] = this.size;
    data['id_sounding_tank'] = this.soundingId;
    data['sounding_1'] = this.sounding1;
    data['sounding_2'] = this.sounding2;
    data['sounding_3'] = this.sounding3;
    data['sounding_4'] = this.sounding4;
    data['sounding_5'] = this.sounding5;
    data['max_sounding'] = this.maxSounding;
    data['avg_sounding'] = this.avgSounding;
    data['m_storage_tank_id'] = this.mStorageTankId;
    data['m_storage_tank_code'] = this.mStorageTankCode;
    data['temperature'] = this.temperature;
    data['volume_cm'] = this.volumeCm;
    data['volume_mm'] = this.volumeMm;
    data['total_volume'] = this.totalVolume;
    data['rounding_volume'] = this.roundingVolume;
    data['constanta_expansion'] = this.constantaExpansion;
    data['density'] = this.density;
    data['weight_storage'] = this.weightStorage;
    data['is_manual'] = this.isManual;
    data['using_copy_data'] = this.usingCopyData;
    data['created_by'] = this.createdBy;
    data['rounding_tonnage'] = this.roundingTonnage;
    return data;
  }
}