class User {
  String id;
  String name;
  String email;
  String mRoleId;
  String username;
  String address;
  String gender;
  String rememberToken;
  String mCompanyId;
  String mMillId;
  String phoneNumber;
  String companyName;
  String companyAlias;
  String profilePicture;

  User({this.id,
    this.name,
    this.email,
    this.mRoleId,
    this.username,
    this.address,
    this.gender,
    this.mCompanyId,
    this.mMillId,
    this.phoneNumber,
    this.companyName,
    this.companyAlias,
    this.profilePicture});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mRoleId = json['m_role_id'];
    username = json['username'];
    address = json['address'];
    gender = json['gender'];
    mCompanyId = json['m_company_id'];
    mMillId = json['m_mill_id'];
    phoneNumber = json['phone_number'];
    companyName = json['company_name'];
    companyAlias = json['company_alias'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['m_role_id'] = this.mRoleId;
    data['username'] = this.username;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['m_company_id'] = this.mCompanyId;
    data['m_mill_id'] = this.mMillId;
    data['phone_number'] = this.phoneNumber;
    data['company_name'] = this.companyName;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}