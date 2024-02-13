class HotProducts {
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

  HotProducts(
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

  HotProducts.fromJson(Map<String, dynamic> json) {
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
      data['rattings'] = rattings!.map((v) => v.toJson()).toList();
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

class NewProducts {
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

  NewProducts(
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

  NewProducts.fromJson(Map<String, dynamic> json) {
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
      data['rattings'] = rattings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}class Rattings {
  String? productId;
  String? avgRatting;

  Rattings({this.productId, this.avgRatting});

  Rattings.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    avgRatting = json['avg_ratting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['avg_ratting'] = avgRatting;
    return data;
  }
}

// ignore: camel_case_types
class home_model {
  int? status;
  String? message;
  String? currency;
  String? currencyPosition;
  String? referralAmount;
  List<FeaturedProducts>? featuredProducts;
  List<HotProducts>? hotProducts;
  List<NewProducts>? newProducts;
  List<Vendors>? vendors;
  List<Brands>? brands;
  int? notifications;

  home_model(
      {this.status,
      this.message,
      this.currency,
      this.currencyPosition,
      this.referralAmount,
      this.featuredProducts,
      this.hotProducts,
      this.newProducts,
      this.vendors,
      this.brands,
      this.notifications});

  home_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    currency = json['currency'];
    currencyPosition = json['currency_position'];
    referralAmount = json['referral_amount'];
    if (json['featured_products'] != null) {
      featuredProducts = <FeaturedProducts>[];
      json['featured_products'].forEach((v) {
        featuredProducts!.add(FeaturedProducts.fromJson(v));
      });
    }
    if (json['hot_products'] != null) {
      hotProducts = <HotProducts>[];
      json['hot_products'].forEach((v) {
        hotProducts!.add(HotProducts.fromJson(v));
      });
    }
    if (json['new_products'] != null) {
      newProducts = <NewProducts>[];
      json['new_products'].forEach((v) {
        newProducts!.add(NewProducts.fromJson(v));
      });
    }
    if (json['vendors'] != null) {
      vendors = <Vendors>[];
      json['vendors'].forEach((v) {
        vendors!.add(Vendors.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
    notifications = json['notifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['currency'] = currency;
    data['currency_position'] = currencyPosition;
    data['referral_amount'] = referralAmount;
    if (featuredProducts != null) {
      data['featured_products'] =
          featuredProducts!.map((v) => v.toJson()).toList();
    }
    if (hotProducts != null) {
      data['hot_products'] = hotProducts!.map((v) => v.toJson()).toList();
    }
    if (newProducts != null) {
      data['new_products'] = newProducts!.map((v) => v.toJson()).toList();
    }
    if (vendors != null) {
      data['vendors'] = vendors!.map((v) => v.toJson()).toList();
    }
    if (brands != null) {
      data['brands'] = brands!.map((v) => v.toJson()).toList();
    }
    data['notifications'] = notifications;
    return data;
  }
}

class FeaturedProducts {
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

  FeaturedProducts(
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

  FeaturedProducts.fromJson(Map<String, dynamic> json) {
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
      data['rattings'] = rattings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendors {
  int? id;
  String? name;
  String? imageUrl;

  Vendors({this.id, this.name, this.imageUrl});

  Vendors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    return data;
  }
}

class Brands {
  int? id;
  String? brandName;
  String? imageUrl;

  Brands({this.id, this.brandName, this.imageUrl});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand_name'] = brandName;
    data['image_url'] = imageUrl;
    return data;
  }
}

