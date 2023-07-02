class StorageTank {
  String id;
  String code;
  String name;
  dynamic capacity;
  dynamic surfacePlate;
  dynamic standardTemperature;
  dynamic height;
  dynamic density;
  dynamic ring;
  dynamic expansionCoefficient;
  String mCompanyId;
  String mMillId;
  int isActive;
  String createdAt;
  String createdBy;
  String updatedAt;
  String updatedBy;

  StorageTank(
      {this.id,
        this.code,
        this.name,
        this.capacity,
        this.surfacePlate,
        this.standardTemperature,
        this.height,
        this.density,
        this.ring,
        this.expansionCoefficient,
        this.mCompanyId,
        this.mMillId,
        this.isActive,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  StorageTank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    capacity = json['capacity'];
    surfacePlate = json['surface_plate'];
    standardTemperature = json['standard_temperature'];
    height = json['height'];
    density = json['density_cpo'];
    ring = json['ring'];
    expansionCoefficient = json['expansion_coefficient'];
    mCompanyId = json['m_company_id'];
    mMillId = json['m_mill_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['capacity'] = this.capacity;
    data['surface_plate'] = this.surfacePlate;
    data['standard_temperature'] = this.standardTemperature;
    data['height'] = this.height;
    data['density_cpo'] = this.density;
    data['ring'] = this.ring;
    data['expansion_coefficient'] = this.expansionCoefficient;
    data['m_mill_id'] = this.mMillId;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    return data;
  }
}