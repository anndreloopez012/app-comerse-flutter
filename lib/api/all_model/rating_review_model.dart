// ignore: camel_case_types
class Rating_reviews_model {
  int? status;
  String? message;
  Reviews? reviews;
  AllReview? allReview;

  Rating_reviews_model(
      {this.status, this.message, this.reviews, this.allReview});

  Rating_reviews_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    reviews =
    json['reviews'] != null ? Reviews.fromJson(json['reviews']) : null;
    allReview = json['all_review'] != null
        ? AllReview.fromJson(json['all_review'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (reviews != null) {
      data['reviews'] = reviews!.toJson();
    }
    if (allReview != null) {
      data['all_review'] = allReview!.toJson();
    }
    return data;
  }
}

class Reviews {
  String? avgRatting;
  int? total;
  int? fiveRatting;
  int? fourRatting;
  int? threeRatting;
  int? twoRatting;
  int? oneRatting;

  Reviews(
      {this.avgRatting,
        this.total,
        this.fiveRatting,
        this.fourRatting,
        this.threeRatting,
        this.twoRatting,
        this.oneRatting});

  Reviews.fromJson(Map<String, dynamic> json) {
    avgRatting = json['avg_ratting'];
    total = json['total'];
    fiveRatting = json['five_ratting'];
    fourRatting = json['four_ratting'];
    threeRatting = json['three_ratting'];
    twoRatting = json['two_ratting'];
    oneRatting = json['one_ratting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg_ratting'] = avgRatting;
    data['total'] = total;
    data['five_ratting'] = fiveRatting;
    data['four_ratting'] = fourRatting;
    data['three_ratting'] = threeRatting;
    data['two_ratting'] = twoRatting;
    data['one_ratting'] = oneRatting;
    return data;
  }
}

class AllReview {
  int? currentPage;
  List<Data>? data;
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

  AllReview(
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

  AllReview.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class Data {
  String? userId;
  String? ratting;
  String? comment;
  String? date;
  Users? users;

  Data({this.userId, this.ratting, this.comment, this.date, this.users});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    ratting = json['ratting'];
    comment = json['comment'];
    date = json['date'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['ratting'] = ratting;
    data['comment'] = comment;
    data['date'] = date;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? imageUrl;

  Users({this.id, this.name, this.imageUrl});

  Users.fromJson(Map<String, dynamic> json) {
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
