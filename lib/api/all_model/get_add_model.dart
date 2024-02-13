// ignore: camel_case_types
class address_get_model {
  int? status;
  String? message;
  List<Data>? data;

  address_get_model({this.status, this.message, this.data});

  address_get_model.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? firstName;
  String? lastName;
  String? streetAddress;
  String? landmark;
  String? pincode;
  String? mobile;
  String? email;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.firstName,
        this.lastName,
        this.streetAddress,
        this.landmark,
        this.pincode,
        this.mobile,
        this.email,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    streetAddress = json['street_address'];
    landmark = json['landmark'];
    pincode = json['pincode'];
    mobile = json['mobile'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['street_address'] = streetAddress;
    data['landmark'] = landmark;
    data['pincode'] = pincode;
    data['mobile'] = mobile;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
