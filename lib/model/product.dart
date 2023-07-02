class Product {
  String id;
  String name;
  String code;
  int isActive;
  String createdAt;
  String createdBy;
  String updatedAt;
  String updatedBy;

  Product(
      {this.id,
        this.name,
        this.code,
        this.isActive,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
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
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}