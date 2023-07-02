import 'package:sounding_storage/model/product.dart';
import 'package:sounding_storage/model/storage_tank.dart';

import 'bulk_silo.dart';
import 'clarifier_tank.dart';
import 'mill.dart';

class Setup {
  Mill mill;
  List<StorageTank> storageTank;
  List<ClarifierTank> clarifierTank;
  List<BulkSilo> bulkSilo;
  List<Product> product;

  Setup(
      {this.mill,
      this.storageTank,
      this.clarifierTank,
      this.bulkSilo,
      this.product});

  Setup.fromJson(Map<String, dynamic> json) {
    mill = json['mill'] != null ? Mill.fromJson(json['mill']) : [];
    if (json['storage_tank'] != null) {
      storageTank = [];
      json['storage_tank'].forEach((v) {
        storageTank.add(StorageTank.fromJson(v));
      });
    }
    if (json['clarifier_tank'] != null) {
      clarifierTank = [];
      json['clarifier_tank'].forEach((v) {
        clarifierTank.add(ClarifierTank.fromJson(v));
      });
    }
    if (json['bulk_silo'] != null) {
      bulkSilo = [];
      json['bulk_silo'].forEach((v) {
        bulkSilo.add(BulkSilo.fromJson(v));
      });
    }
    if (json['product'] != null) {
      product = [];
      json['product'].forEach((v) {
        product.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.mill != null) {
      data['mill'] = this.mill.toJson();
    }
    if (this.storageTank != null) {
      data['storage_tank'] = this.storageTank.map((v) => v.toJson()).toList();
    }
    if (this.clarifierTank != null) {
      data['clarifier_tank'] =
          this.clarifierTank.map((v) => v.toJson()).toList();
    }
    if (this.bulkSilo != null) {
      data['bulk_silo'] = this.bulkSilo.map((v) => v.toJson()).toList();
    }
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
