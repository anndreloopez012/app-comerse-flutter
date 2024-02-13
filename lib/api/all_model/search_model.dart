// ignore: camel_case_types
class search_model {
  int? status;
  String? message;
  List<Data>? data;

  search_model({this.status, this.message, this.data});

  search_model.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  String? productPrice;
  String? discountedPrice;
  String? tags;
  String? isVariation;
  String? sku;
  String? isWishlist;
  Productimage? productimage;
  Variation? variation;
  // List<Null>? rattings;

  Data(
      {this.id,
        this.productName,
        this.productPrice,
        this.discountedPrice,
        this.tags,
        this.isVariation,
        this.sku,
        this.isWishlist,
        this.productimage,
        this.variation,
       });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    discountedPrice = json['discounted_price'];
    tags = json['tags'];
    isVariation = json['is_variation'];
    sku = json['sku'];
    isWishlist = json['is_wishlist'];
    productimage = json['productimage'] != null
        ? Productimage.fromJson(json['productimage'])
        : null;
    variation = json['variation'] != null
        ? Variation.fromJson(json['variation'])
        : null;
    // if (json['rattings'] != null) {
    //   rattings = <Null>[];
    //   json['rattings'].forEach((v) {
    //     rattings!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['discounted_price'] = discountedPrice;
    data['tags'] = tags;
    data['is_variation'] = isVariation;
    data['sku'] = sku;
    data['is_wishlist'] = isWishlist;
    if (productimage != null) {
      data['productimage'] = productimage!.toJson();
    }
    if (variation != null) {
      data['variation'] = variation!.toJson();
    }
    // if (this.rattings != null) {
    //   data['rattings'] = this.rattings!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Productimage {
  int? id;
  String? productId;
  String? imageUrl;

  Productimage({this.id, this.productId, this.imageUrl});

  Productimage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['image_url'] = imageUrl;
    return data;
  }
}

class Variation {
  int? id;
  String? productId;
  String? price;
  String? discountedVariationPrice;
  String? variation;
  String? qty;

  Variation(
      {this.id,
        this.productId,
        this.price,
        this.discountedVariationPrice,
        this.variation,
        this.qty});

  Variation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    price = json['price'];
    discountedVariationPrice = json['discounted_variation_price'];
    variation = json['variation'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['price'] = price;
    data['discounted_variation_price'] = discountedVariationPrice;
    data['variation'] = variation;
    data['qty'] = qty;
    return data;
  }
}
