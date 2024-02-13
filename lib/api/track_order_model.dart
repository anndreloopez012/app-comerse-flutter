// ignore: camel_case_types
class track_model {
  int? status;
  String? message;
  OrderInfo? orderInfo;
  int? ratting;

  track_model({this.status, this.message, this.orderInfo, this.ratting});

  track_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderInfo = json['order_info'] != null
        ? OrderInfo.fromJson(json['order_info'])
        : null;
    ratting = json['ratting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderInfo != null) {
      data['order_info'] = orderInfo!.toJson();
    }
    data['ratting'] = ratting;
    return data;
  }
}

class OrderInfo {
  int? id;
  String? productId;
  String? orderNumber;
  String? returnNumber;
  String? vendorComment;
  String? vendorId;
  String? productName;
  String? price;
  String? qty;
  String? status;
  String? createdAtt;
  String? confirmedAtt;
  String? shippedAtt;
  String? deliveredAtt;
  String? variation;
  String? imageUrl;

  OrderInfo(
      {this.id,
        this.productId,
        this.orderNumber,
        this.returnNumber,
        this.vendorComment,
        this.vendorId,
        this.productName,
        this.price,
        this.qty,
        this.status,
        this.createdAtt,
        this.confirmedAtt,
        this.shippedAtt,
        this.deliveredAtt,
        this.variation,
        this.imageUrl});

  OrderInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    orderNumber = json['order_number'];
    returnNumber = json['return_number'];
    vendorComment = json['vendor_comment'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    price = json['price'];
    qty = json['qty'];
    status = json['status'];
    createdAtt = json['created_att'];
    confirmedAtt = json['confirmed_att'];
    shippedAtt = json['shipped_att'];
    deliveredAtt = json['delivered_att'];
    variation = json['variation'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['order_number'] = orderNumber;
    data['return_number'] = returnNumber;
    data['vendor_comment'] = vendorComment;
    data['vendor_id'] = vendorId;
    data['product_name'] = productName;
    data['price'] = price;
    data['qty'] = qty;
    data['status'] = status;
    data['created_att'] = createdAtt;
    data['confirmed_att'] = confirmedAtt;
    data['shipped_att'] = shippedAtt;
    data['delivered_att'] = deliveredAtt;
    data['variation'] = variation;
    data['image_url'] = imageUrl;
    return data;
  }
}
