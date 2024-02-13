// ignore_for_file: camel_case_types

import 'home_model.dart';

class view_all_listing_model {
  int? status;
  String? message;
  Data? data;

  view_all_listing_model({this.status, this.message, this.data});

  view_all_listing_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?   Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['status'] =  status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<Datasub>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Datasub>[];
      json['data'].forEach((v) {
        data!.add(  Datasub.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(  Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Datasub {
  int? id;
  String? productName;
  String? productPrice;
  String? discountedPrice;
  String? isVariation;
  String? sku;
  String? isWishlist;
  Productimage? productimage;
  Variation? variation;
  List<Rattings>? rattings;

  Datasub(
      {this.id,
        this.productName,
        this.productPrice,
        this.discountedPrice,
        this.isVariation,
        this.sku,
        this.isWishlist,
        this.productimage,
        this.variation,
        this.rattings});

  Datasub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    discountedPrice = json['discounted_price'];
    isVariation = json['is_variation'];
    sku = json['sku'];
    isWishlist = json['is_wishlist'];
    productimage = json['productimage'] != null
        ? Productimage.fromJson(json['productimage'])
        : null;
    variation = json['variation'] != null
        ? Variation.fromJson(json['variation'])
        : null;
    if (json['rattings'] != null) {
      rattings = <Rattings>[];
      json['rattings'].forEach((v) {
        rattings!.add(Rattings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['discounted_price'] = discountedPrice;
    data['is_variation'] = isVariation;
    data['sku'] = sku;
    data['is_wishlist'] = isWishlist;
    if (productimage != null) {
      data['productimage'] = productimage!.toJson();
    }
    if (variation != null) {
      data['variation'] = variation!.toJson();
    }
    if (rattings != null) {
      data['rattin gs'] = rattings!.map((v) => v.toJson()).toList();
    }
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
