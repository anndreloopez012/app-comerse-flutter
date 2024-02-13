// ignore: camel_case_types
class cart_model {
  int? status;
  String? message;
  List<Data>? data;

  cart_model({this.status, this.message, this.data});

  cart_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? productId;
  String? productName;
  String? qty;
  String? price;
  String? variation;
  String? attribute;
  String? imageUrl;

  Data(
      {this.id,
        this.productId,
        this.productName,
        this.qty,
        this.price,
        this.variation,
        this.attribute,
        this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    qty = json['qty'];
    price = json['price'];
    variation = json['variation'];
    attribute = json['attribute'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['qty'] = qty;
    data['price'] = price;
    data['variation'] = variation;
    data['attribute'] = attribute;
    data['image_url'] = imageUrl;
    return data;
  }
}
