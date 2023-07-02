class SendQualityBody {
  String number;
  String trTime;
  List<QualityCheckBody> qualityCheck;
  List<String> verificators;

  SendQualityBody({this.number, this.trTime, this.qualityCheck});

  SendQualityBody.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    trTime = json['tr_time'];
    if (json['quality_check'] != null) {
      qualityCheck = [];
      json['quality_check'].forEach((v) {
        qualityCheck.add(QualityCheckBody.fromJson(v));
      });
    }
    verificators = json['verificators'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['number'] = this.number;
    data['tr_time'] = this.trTime;
    if (this.qualityCheck != null) {
      data['quality_check'] = this.qualityCheck.map((v) => v.toJson()).toList();
    }
    data['verificators'] = this.verificators;
    return data;
  }
}

class QualityCheckBody {
  String mProductId;
  String mProductCode;
  String number;
  String trTime;
  double ffa;
  double moist;
  double dirt;
  double dobi;
  double brokenKernel;

  QualityCheckBody(
      {this.mProductId,
      this.mProductCode,
      this.number,
      this.trTime,
      this.ffa,
      this.moist,
      this.dirt,
      this.dobi,
      this.brokenKernel});

  QualityCheckBody.fromJson(Map<String, dynamic> json) {
    mProductId = json['m_product_id'];
    mProductCode = json['m_product_code'];
    number = json['number'];
    trTime = json['tr_time'];
    ffa = json['ffa'];
    moist = json['moist'];
    dirt = json['dirt'];
    dobi = json['dobi'];
    brokenKernel = json['broken_kernel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['m_product_id'] = this.mProductId;
    data['m_product_code'] = this.mProductCode;
    data['number'] = this.number;
    data['tr_time'] = this.trTime;
    data['ffa'] = this.ffa;
    data['moist'] = this.moist;
    data['dirt'] = this.dirt;
    data['dobi'] = this.dobi;
    data['broken_kernel'] = this.brokenKernel;
    return data;
  }
}
