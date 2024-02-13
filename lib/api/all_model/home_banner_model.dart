// ignore: camel_case_types
class home_banner_model {
  int? status;
  String? message;
  List<Topbanner>? topbanner;
  List<Largebanner>? largebanner;
  List<Leftbanner>? leftbanner;
  List<Bottombanner>? bottombanner;
  List<Popupbanner>? popupbanner;
  List<Sliders>? sliders;

  home_banner_model(
      {this.status,
        this.message,
        this.topbanner,
        this.largebanner,
        this.leftbanner,
        this.bottombanner,
        this.popupbanner,
        this.sliders});

  home_banner_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['topbanner'] != null) {
      topbanner = <Topbanner>[];
      json['topbanner'].forEach((v) {
        topbanner!.add(Topbanner.fromJson(v));
      });
    }
    if (json['largebanner'] != null) {
      largebanner = <Largebanner>[];
      json['largebanner'].forEach((v) {
        largebanner!.add(Largebanner.fromJson(v));
      });
    }
    if (json['leftbanner'] != null) {
      leftbanner = <Leftbanner>[];
      json['leftbanner'].forEach((v) {
        leftbanner!.add(Leftbanner.fromJson(v));
      });
    }
    if (json['bottombanner'] != null) {
      bottombanner = <Bottombanner>[];
      json['bottombanner'].forEach((v) {
        bottombanner!.add(Bottombanner.fromJson(v));
      });
    }
    if (json['popupbanner'] != null) {
      popupbanner = <Popupbanner>[];
      json['popupbanner'].forEach((v) {
        popupbanner!.add(Popupbanner.fromJson(v));
      });
    }
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (topbanner != null) {
      data['topbanner'] = topbanner!.map((v) => v.toJson()).toList();
    }
    if (largebanner != null) {
      data['largebanner'] = largebanner!.map((v) => v.toJson()).toList();
    }
    if (leftbanner != null) {
      data['leftbanner'] = leftbanner!.map((v) => v.toJson()).toList();
    }
    if (bottombanner != null) {
      data['bottombanner'] = bottombanner!.map((v) => v.toJson()).toList();
    }
    if (popupbanner != null) {
      data['popupbanner'] = popupbanner!.map((v) => v.toJson()).toList();
    }
    if (sliders != null) {
      data['sliders'] = sliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leftbanner {
  String? type;
  String? imageUrl;
  String? catId;
  String? categoryName;
  String? productId;

  Leftbanner(
      {this.type,
        this.imageUrl,
        this.catId,
        this.categoryName,
        this.productId});

  Leftbanner.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    imageUrl = json['image_url'];
    catId = json['cat_id'];
    categoryName = json['category_name'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['image_url'] = imageUrl;
    data['cat_id'] = catId;
    data['category_name'] = categoryName;
    data['product_id'] = productId;
    return data;
  }
}
class Popupbanner {
  String? type;
  String? imageUrl;
  String? catId;
  String? categoryName;
  String? productId;

  Popupbanner(
      {this.type,
        this.imageUrl,
        this.catId,
        this.categoryName,
        this.productId});

  Popupbanner.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    imageUrl = json['image_url'];
    catId = json['cat_id'];
    categoryName = json['category_name'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['image_url'] = imageUrl;
    data['cat_id'] = catId;
    data['category_name'] = categoryName;
    data['product_id'] = productId;
    return data;
  }
}
class Bottombanner {
  String? type;
  String? imageUrl;
  String? catId;
  String? categoryName;
  String? productId;

  Bottombanner(
      {this.type,
        this.imageUrl,
        this.catId,
        this.categoryName,
        this.productId});

  Bottombanner.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    imageUrl = json['image_url'];
    catId = json['cat_id'];
    categoryName = json['category_name'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['image_url'] = imageUrl;
    data['cat_id'] = catId;
    data['category_name'] = categoryName;
    data['product_id'] = productId;
    return data;
  }
}

class Largebanner {
  String? type;
  String? imageUrl;
  String? catId;
  String? categoryName;
  String? productId;

  Largebanner(
      {this.type,
        this.imageUrl,
        this.catId,
        this.categoryName,
        this.productId});

  Largebanner.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    imageUrl = json['image_url'];
    catId = json['cat_id'];
    categoryName = json['category_name'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['image_url'] = imageUrl;
    data['cat_id'] = catId;
    data['category_name'] = categoryName;
    data['product_id'] = productId;
    return data;
  }
}

class Topbanner {
  String? type;
  String? imageUrl;
  String? catId;
  String? categoryName;
  String? productId;

  Topbanner(
      {this.type,
        this.imageUrl,
        this.catId,
        this.categoryName,
        this.productId});

  Topbanner.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    imageUrl = json['image_url'];
    catId = json['cat_id'];
    categoryName = json['category_name'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['image_url'] = imageUrl;
    data['cat_id'] = catId;
    data['category_name'] = categoryName;
    data['product_id'] = productId;
    return data;
  }
}

class Sliders {
  String? link;
  String? imageUrl;

  Sliders({this.link, this.imageUrl});

  Sliders.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    data['image_url'] = imageUrl;
    return data;
  }
}
