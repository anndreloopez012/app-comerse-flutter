// ignore: camel_case_types
class add_address_api {
  int? status;
  String? message;
  Addressdata? addressdata;

  add_address_api({this.status, this.message, this.addressdata});

  add_address_api.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    addressdata = json['addressdata'] != null
        ? Addressdata.fromJson(json['addressdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (addressdata != null) {
      data['addressdata'] = addressdata!.toJson();
    }
    return data;
  }
}

class Addressdata {
  int? id;
  String? name;
  String? street;
  String? landmark;
  String? postcode;
  String? mobile;
  String? email;
  String? userName;

  Addressdata(
      {this.id,
        this.name,
        this.street,
        this.landmark,
        this.postcode,
        this.mobile,
        this.email,
        this.userName});

  Addressdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    street = json['street'];
    landmark = json['landmark'];
    postcode = json['postcode'];
    mobile = json['mobile'];
    email = json['email'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['street'] = street;
    data['landmark'] = landmark;
    data['postcode'] = postcode;
    data['mobile'] = mobile;
    data['email'] = email;
    data['user_name'] = userName;
    return data;
  }
}
