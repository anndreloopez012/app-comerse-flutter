// ignore: camel_case_types
class productdetails_model {
  int? status;
  String? message;
  Data? data;
  Vendors? vendors;
  List<RelatedProducts>? relatedProducts;
  Returnpolicy? returnpolicy;

  productdetails_model(
      {this.status,
        this.message,
        this.data,
        this.vendors,
        this.relatedProducts,
        this.returnpolicy});

  productdetails_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    vendors =
    json['vendors'] != null ? Vendors.fromJson(json['vendors']) : null;
    if (json['related_products'] != null) {
      relatedProducts = <RelatedProducts>[];
      json['related_products'].forEach((v) {
        relatedProducts!.add(RelatedProducts.fromJson(v));
      });
    }
    returnpolicy = json['returnpolicy'] != null
        ? Returnpolicy.fromJson(json['returnpolicy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (vendors != null) {
      data['vendors'] = vendors!.toJson();
    }
    if (relatedProducts != null) {
      data['related_products'] =
          relatedProducts!.map((v) => v.toJson()).toList();
    }
    if (returnpolicy != null) {
      data['returnpolicy'] = returnpolicy!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? productName;
  String? productPrice;
  String? catId;
  String? discountedPrice;
  String? description;
  String? productQty;
  String? isVariation;
  String? vendorId;
  String? sku;
  String? freeShipping;
  String? shippingCost;
  String? taxType;
  String? tax;
  String? estShippingDays;
  String? isReturn;
  String? returnDays;
  String? isWishlist;
  String? categoryName;
  String? subcategoryName;
  String? innersubcategoryName;
  String? attribute;
  List<Productimages>? productimages;
  List<Variations>? variations;
  List<Rattings>? rattings;

  Data(
      {this.id,
        this.productName,
        this.productPrice,
        this.catId,
        this.discountedPrice,
        this.description,
        this.productQty,
        this.isVariation,
        this.vendorId,
        this.sku,
        this.freeShipping,
        this.shippingCost,
        this.taxType,
        this.tax,
        this.estShippingDays,
        this.isReturn,
        this.returnDays,
        this.isWishlist,
        this.categoryName,
        this.subcategoryName,
        this.innersubcategoryName,
        this.attribute,
        this.productimages,
        this.variations,
        this.rattings});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    catId = json['cat_id'];
    discountedPrice = json['discounted_price'];
    description = json['description'];
    productQty = json['product_qty'];
    isVariation = json['is_variation'];
    vendorId = json['vendor_id'];
    sku = json['sku'];
    freeShipping = json['free_shipping'];
    shippingCost = json['shipping_cost'];
    taxType = json['tax_type'];
    tax = json['tax'];
    estShippingDays = json['est_shipping_days'];
    isReturn = json['is_return'];
    returnDays = json['return_days'];
    isWishlist = json['is_wishlist'];
    categoryName = json['category_name'];
    subcategoryName = json['subcategory_name'];
    innersubcategoryName = json['innersubcategory_name'];
    attribute = json['attribute'];
    if (json['productimages'] != null) {
      productimages = <Productimages>[];
      json['productimages'].forEach((v) {
        productimages!.add(Productimages.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(Variations.fromJson(v));
      });
    }
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
    data['cat_id'] = catId;
    data['discounted_price'] =discountedPrice;
    data['description'] = description;
    data['product_qty'] = productQty;
    data['is_variation'] = isVariation;
    data['vendor_id'] = vendorId;
    data['sku'] = sku;
    data['free_shipping'] = freeShipping;
    data['shipping_cost'] = shippingCost;
    data['tax_type'] = taxType;
    data['tax'] = tax;
    data['est_shipping_days'] = estShippingDays;
    data['is_return'] =isReturn;
    data['return_days'] = returnDays;
    data['is_wishlist'] = isWishlist;
    data['category_name'] = categoryName;
    data['subcategory_name'] = subcategoryName;
    data['innersubcategory_name'] =innersubcategoryName;
    data['attribute'] = attribute;
    if (productimages != null) {
      data['productimages'] =
         productimages!.map((v) => v.toJson()).toList();
    }
    if (variations != null) {
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    if (rattings != null) {
      data['rattings'] = rattings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productimages {
  int? id;
  String? productId;
  String? imageName;
  String? imageUrl;

  Productimages({this.id, this.productId, this.imageName, this.imageUrl});

  Productimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    imageName = json['image_name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['image_name'] = imageName;
    data['image_url'] = imageUrl;
    return data;
  }
}

class Variations {
  int? id;
  String? productId;
  String? price;
  String? discountedVariationPrice;
  String? variation;
  String? qty;

  Variations(
      {this.id,
        this.productId,
        this.price,
        this.discountedVariationPrice,
        this.variation,
        this.qty});

  Variations.fromJson(Map<String, dynamic> json) {
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

class Rattings {
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

class Vendors {
  int? id;
  String? name;
  String? imageUrl;
  List<Rattings>? rattings;

  Vendors({this.id, this.name, this.imageUrl, this.rattings});

  Vendors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
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
    data['name'] = name;
    data['image_url'] = imageUrl;
    if (rattings != null) {
      data['rattings'] = rattings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class RelatedProducts {
  int? id;
  String? productName;
  String? productPrice;
  String? discountedPrice;
  String? isVariation;
  String? sku;
  String? isWishlist;
  Productimage? productimage;
  Variations? variation;
  List<Rattings>? rattings;

  RelatedProducts(
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

  RelatedProducts.fromJson(Map<String, dynamic> json) {
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
        ? Variations.fromJson(json['variation'])
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

class Returnpolicy {
  String? returnPolicies;

  Returnpolicy({this.returnPolicies});

  Returnpolicy.fromJson(Map<String, dynamic> json) {
    returnPolicies = json['return_policies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['return_policies'] = returnPolicies;
    return data;
  }
}
