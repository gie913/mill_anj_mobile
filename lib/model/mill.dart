class Mill {
  String id;
  String name;
  String code;
  String address;
  String gpsLat;
  String gpsLong;
  String mCompanyId;
  int totalSampleSoundingCpo;
  int totalSampleQuality;
  String labelSampleQuality;
  int totalSampleSoundingKernel;
  int isActive;
  String createdAt;
  String createdBy;
  String updatedAt;
  String updatedBy;

  Mill(
      {this.id,
        this.name,
        this.code,
        this.address,
        this.gpsLat,
        this.gpsLong,
        this.mCompanyId,
        this.totalSampleSoundingCpo,
        this.totalSampleQuality,
        this.labelSampleQuality,
        this.totalSampleSoundingKernel,
        this.isActive,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  Mill.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    address = json['address'];
    gpsLat = json['gps_lat'];
    gpsLong = json['gps_long'];
    mCompanyId = json['m_company_id'];
    totalSampleSoundingCpo = json['total_sample_sounding_cpo'];
    totalSampleQuality = json['total_sample_quality'];
    labelSampleQuality = json['label_sample_quality'];
    totalSampleSoundingKernel = json['total_sample_sounding_kernel'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['address'] = this.address;
    data['total_sample_sounding_cpo'] = this.totalSampleSoundingCpo;
    data['total_sample_quality'] = this.totalSampleQuality;
    data['label_sample_quality'] = this.labelSampleQuality;
    data['total_sample_sounding_kernel'] = this.totalSampleSoundingKernel;
    data['m_company_id'] = this.mCompanyId;
    return data;
  }
}