// ignore: camel_case_types
class categorie_menu_model {
  int? status;
  String? message;
  Data? data;

  categorie_menu_model({this.status, this.message, this.data});

  categorie_menu_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Subcategory>? subcategory;

  Data({this.subcategory});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subcategory != null) {
      data['subcategory'] = subcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  int? subcatId;
  String? subcategoryName;
  List<Innersubcategory>? innersubcategory;

  Subcategory({this.subcatId, this.subcategoryName, this.innersubcategory});

  Subcategory.fromJson(Map<String, dynamic> json) {
    subcatId = json['subcat_id'];
    subcategoryName = json['subcategory_name'];
    if (json['innersubcategory'] != null) {
      innersubcategory = <Innersubcategory>[];
      json['innersubcategory'].forEach((v) {
        innersubcategory!.add(Innersubcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subcat_id'] = subcatId;
    data['subcategory_name'] = subcategoryName;
    if (innersubcategory != null) {
      data['innersubcategory'] =
          innersubcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Innersubcategory {
  int? id;
  String? innersubcategoryName;

  Innersubcategory({this.id, this.innersubcategoryName});

  Innersubcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    innersubcategoryName = json['innersubcategory_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['innersubcategory_name'] = innersubcategoryName;
    return data;
  }
}
