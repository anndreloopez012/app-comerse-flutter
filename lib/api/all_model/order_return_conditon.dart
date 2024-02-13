// ignore: camel_case_types
class return_condition {
  int? status;
  String? message;
  OrderInfo? orderInfo;
  List<Data>? data;

  return_condition({this.status, this.message, this.orderInfo, this.data});

  return_condition.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderInfo = json['order_info'] != null
        ? OrderInfo.fromJson(json['order_info'])
        : null;
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
    if (orderInfo != null) {
      data['order_info'] = orderInfo!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderInfo {
  int? id;
  String? productId;
  String? vendorId;
  String? productName;
  String? price;
  String? qty;
  String? status;
  String? variation;
  String? imageUrl;

  OrderInfo(
      {this.id,
        this.productId,
        this.vendorId,
        this.productName,
        this.price,
        this.qty,
        this.status,
        this.variation,
        this.imageUrl});

  OrderInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    price = json['price'];
    qty = json['qty'];
    status = json['status'];
    variation = json['variation'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['vendor_id'] = vendorId;
    data['product_name'] = productName;
    data['price'] = price;
    data['qty'] = qty;
    data['status'] = status;
    data['variation'] = variation;
    data['image_url'] = imageUrl;
    return data;
  }
}

class Data {
  String? returnConditions;

  Data({this.returnConditions});

  Data.fromJson(Map<String, dynamic> json) {
    returnConditions = json['return_conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['return_conditions'] = returnConditions;
    return data;
  }
}
