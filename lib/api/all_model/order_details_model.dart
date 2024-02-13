// ignore: camel_case_types
class order_details_model {
  int? status;
  String? message;
  OrderInfo? orderInfo;
  List<OrderData>? orderData;

  order_details_model(
      {this.status, this.message, this.orderInfo, this.orderData});

  order_details_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderInfo = json['order_info'] != null
        ? OrderInfo.fromJson(json['order_info'])
        : null;
    if (json['order_data'] != null) {
      orderData = <OrderData>[];
      json['order_data'].forEach((v) {
        orderData!.add(OrderData.fromJson(v));
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
    if (orderData != null) {
      data['order_data'] = orderData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderInfo {
  String? orderNumber;
  String? orderNotes;
  String? paymentType;
  String? fullName;
  String? email;
  String? mobile;
  String? landmark;
  String? streetAddress;
  String? pincode;
  String? couponName;
  String? discountAmount;
  String? status;
  String? date;
  String? subtotal;
  String? tax;
  String? shippingCost;
  int? grandTotal;

  OrderInfo(
      {this.orderNumber,
        this.orderNotes,
        this.paymentType,
        this.fullName,
        this.email,
        this.mobile,
        this.landmark,
        this.streetAddress,
        this.pincode,
        this.couponName,
        this.discountAmount,
        this.status,
        this.date,
        this.subtotal,
        this.tax,
        this.shippingCost,
        this.grandTotal});

  OrderInfo.fromJson(Map<String, dynamic> json) {
    orderNumber = json['order_number'];
    orderNotes = json['order_notes'];
    paymentType = json['payment_type'];
    fullName = json['full_name'];
    email = json['email'];
    mobile = json['mobile'];
    landmark = json['landmark'];
    streetAddress = json['street_address'];
    pincode = json['pincode'];
    couponName = json['coupon_name'];
    discountAmount = json['discount_amount'];
    status = json['status'];
    date = json['date'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    grandTotal = json['grand_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_number'] = orderNumber;
    data['order_notes'] = orderNotes;
    data['payment_type'] = paymentType;
    data['full_name'] = fullName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['landmark'] = landmark;
    data['street_address'] = streetAddress;
    data['pincode'] = pincode;
    data['coupon_name'] = couponName;
    data['discount_amount'] = discountAmount;
    data['status'] = status;
    data['date'] = date;
    data['subtotal'] = subtotal;
    data['tax'] = tax;
    data['shipping_cost'] = shippingCost;
    data['grand_total'] = grandTotal;
    return data;
  }
}

class OrderData {
  int? id;
  String? productId;
  String? productName;
  String? qty;
  String? price;
  String? status;
  String? attribute;
  String? variation;
  String? tax;
  String? shippingCost;
  String? imageUrl;
  String? discountAmount;
  String? returnDays;
  // ignore: prefer_typing_uninitialized_variables
  var total;

  OrderData(
      {this.id,
        this.productId,
        this.productName,
        this.qty,
        this.price,
        this.status,
        this.attribute,
        this.variation,
        this.tax,
        this.shippingCost,
        this.imageUrl,
        this.discountAmount,
        this.returnDays,
        this.total});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    qty = json['qty'];
    price = json['price'];
    status = json['status'];
    attribute = json['attribute'];
    variation = json['variation'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    imageUrl = json['image_url'];
    discountAmount = json['discount_amount'];
    returnDays = json['return_days'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['qty'] = qty;
    data['price'] = price;
    data['status'] = status;
    data['attribute'] = attribute;
    data['variation'] = variation;
    data['tax'] = tax;
    data['shipping_cost'] = shippingCost;
    data['image_url'] = imageUrl;
    data['discount_amount'] = discountAmount;
    data['return_days'] = returnDays;
    data['total'] = total;
    return data;
  }
}
