
class QualityCheck {
  String mProductId;
  String mProductCode;
  String idQualityDocCheck;
  String number;
  String trTime;
  double ffa;
  double moist;
  double dirt;
  String createdBy;
  double dobi;
  double brokenPk;

  QualityCheck(
      {this.mProductId,
        this.mProductCode,
        this.idQualityDocCheck,
        this.number,
        this.trTime,
        this.ffa,
        this.moist,
        this.dirt,
        this.createdBy,
        this.dobi,
        this.brokenPk});

  QualityCheck.fromJson(Map<String, dynamic> json) {
    mProductId = json['m_product_id'];
    mProductCode = json['m_product_code'];
    number = json['number'];
    idQualityDocCheck = json['id_quality_doc'];
    trTime = json['tr_time'];
    ffa = json['ffa'];
    createdBy = json['created_by'];
    moist = json['moist'];
    dirt = json['dirt'];
    dobi = json['dobi'];
    brokenPk = json['broken_kernel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m_product_id'] = this.mProductId;
    data['m_product_code'] = this.mProductCode;
    data['id_quality_doc'] = this.idQualityDocCheck;
    data['number'] = this.number;
    data['tr_time'] = this.trTime;
    data['ffa'] = this.ffa;
    data['moist'] = this.moist;
    data['created_by'] = this.createdBy;
    data['dirt'] = this.dirt;
    data['dobi'] = this.dobi;
    data['broken_kernel'] = this.brokenPk;
    return data;
  }
}