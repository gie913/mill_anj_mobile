
class Verifier {
  String id;
  String name;
  String levelLabel;
  String idForm;

  Verifier({this.id, this.name, this.levelLabel});

  Verifier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    levelLabel = json['level_label'];
    idForm = json['id_form'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['level_label'] = this.levelLabel;
    data['id_form'] = this.idForm;
    return data;
  }
}