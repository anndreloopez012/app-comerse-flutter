// ignore: camel_case_types
class edt_profile_model {
  int? status;
  String? message;
  Userdata? userdata;

  edt_profile_model({this.status, this.message, this.userdata});

  edt_profile_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userdata = json['userdata'] != null
        ? Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (userdata != null) {
      data['userdata'] = userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? loginType;
  String? imageUrl;

  Userdata(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.loginType,
        this.imageUrl});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    loginType = json['login_type'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['login_type'] = loginType;
    data['image_url'] = imageUrl;
    return data;
  }
}
