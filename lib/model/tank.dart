class Tank{
  String idTank;
  String idSoundingTank;
  String soundingFirst;
  String soundingSecond;
  String soundingThird;
  String soundingAverage;
  String soundingTemperature;
  String soundingHighTable;
  String soundingMeasure;
  String soundingRoundingVolume;
  String soundingRoundingTonnage;

  Tank({
    this.idTank,
    this.idSoundingTank,
    this.soundingFirst,
    this.soundingSecond,
    this.soundingThird,
    this.soundingAverage,
    this.soundingTemperature,
    this.soundingHighTable,
    this.soundingMeasure,
    this.soundingRoundingVolume,
    this.soundingRoundingTonnage
  });

  Tank.fromJson(Map<String, dynamic> map) {
    this.idTank = map['id_tank'];
    this.idSoundingTank = map['date_sounding'];
    this.soundingFirst = map['sounding_first'];
    this.soundingSecond = map['sounding_second'];
    this.soundingThird = map['sounding_third'];
    this.soundingAverage = map['sounding_average'];
    this.soundingTemperature = map['sounding_temperature'];
    this.soundingHighTable = map['sounding_high_table'];
    this.soundingMeasure = map['sounding_measure'];
    this.soundingRoundingVolume = map['sounding_rounding_volume'];
    this.soundingRoundingTonnage = map['sounding_rounding_tonnage'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id_tank'] = this.idTank;
    map['date_sounding'] = this.idSoundingTank;
    map['sounding_first'] = this.soundingFirst;
    map['sounding_second'] = this.soundingSecond;
    map['sounding_third'] = this.soundingThird;
    map['sounding_average'] = this.soundingAverage;
    map['sounding_temperature'] = this.soundingTemperature;
    map['sounding_high_table'] = this.soundingHighTable;
    map['sounding_measure'] = this.soundingMeasure;
    map['sounding_rounding_volume'] = this.soundingRoundingVolume;
    map['sounding_rounding_tonnage'] = this.soundingRoundingTonnage ;
    return map;
  }
}