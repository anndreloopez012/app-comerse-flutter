// ignore: camel_case_types
class chekout_model {
  dynamic status;
  dynamic message;
  Data? data;
  List<Cartdata>? cartdata;
  // Null? couponName;

  chekout_model(
      {this.status, this.message, this.data, this.cartdata});

  chekout_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['cartdata'] != null) {
      cartdata = <Cartdata>[];
      json['cartdata'].forEach((v) {
        cartdata!.add(Cartdata.fromJson(v));
      });
    }
    // couponName = json['coupon_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (cartdata != null) {
      data['cartdata'] = cartdata!.map((v) => v.toJson()).toList();
    }
    // data['coupon_name'] = this.couponName;
    return data;
  }
}

class Data {
  dynamic vendorId;
  dynamic subtotal;
  dynamic tax;
  dynamic shippingCost;
  dynamic discountAmount;
  dynamic grandTotal;

  Data(
      {this.vendorId,
        this.subtotal,
        this.tax,
        this.shippingCost,
        this.discountAmount,
        this.grandTotal});

  Data.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    discountAmount = json['discount_amount'];
    grandTotal = json['grand_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vendor_id'] = vendorId;
    data['subtotal'] = subtotal;
    data['tax'] = tax;
    data['shipping_cost'] = shippingCost;
    data['discount_amount'] = discountAmount;
    data['grand_total'] = grandTotal;
    return data;
  }
}

class Cartdata {
  dynamic id;
  dynamic productId;
  dynamic productName;
  dynamic vendorId;
  dynamic qty;
  dynamic price;
  dynamic attribute;
  dynamic variation;
  dynamic tax;
  dynamic shippingCost;
  dynamic imageUrl;
  dynamic discountAmount;
  dynamic total;

  Cartdata(
      {this.id,
        this.productId,
        this.productName,
        this.vendorId,
        this.qty,
        this.price,
        this.attribute,
        this.variation,
        this.tax,
        this.shippingCost,
        this.imageUrl,
        this.discountAmount,
        this.total});

  Cartdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    vendorId = json['vendor_id'];
    qty = json['qty'];
    price = json['price'];
    attribute = json['attribute'];
    variation = json['variation'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    imageUrl = json['image_url'];
    discountAmount = json['discount_amount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['vendor_id'] = vendorId;
    data['qty'] = qty;
    data['price'] = price;
    data['attribute'] = attribute;
    data['variation'] = variation;
    data['tax'] = tax;
    data['shipping_cost'] = shippingCost;
    data['image_url'] = imageUrl;
    data['discount_amount'] = discountAmount;
    data['total'] = total;
    return data;
  }
}
