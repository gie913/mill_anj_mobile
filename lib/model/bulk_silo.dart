class BulkSilo {
  String id;
  String code;
  String name;
  int capacity;
  String mCompanyId;
  String mMillId;
  int isActive;
  String createdAt;
  String createdBy;
  String updatedAt;
  String updatedBy;

  BulkSilo(
      {this.id,
        this.code,
        this.name,
        this.capacity,
        this.mCompanyId,
        this.mMillId,
        this.isActive,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  BulkSilo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    capacity = json['capacity'];
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
    data['m_company_id'] = this.mCompanyId;
    data['m_mill_id'] = this.mMillId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}