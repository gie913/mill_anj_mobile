
class DataVerifier {
  String mUserId;
  String name;
  String levelLabel;
  String idForm;

  DataVerifier({this.mUserId, this.name, this.levelLabel});

  DataVerifier.fromJson(Map<String, dynamic> json) {
    mUserId = json['m_user_id'];
    name = json['name'];
    levelLabel = json['level_label'];
    idForm = json['id_form'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m_user_id'] = this.mUserId;
    data['name'] = this.name;
    data['level_label'] = this.levelLabel;
    data['id_form'] = this.idForm;
    return data;
  }
}