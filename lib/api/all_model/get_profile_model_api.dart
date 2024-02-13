// ignore: camel_case_types
class get_profile_model {
  int? status;
  String? message;
  Data? data;
  Contactinfo? contactinfo;

  get_profile_model({this.status, this.message, this.data, this.contactinfo});

  get_profile_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    contactinfo = json['contactinfo'] != null
        ? Contactinfo.fromJson(json['contactinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (contactinfo != null) {
      data['contactinfo'] = contactinfo!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? referralCode;
  String? notificationStatus;
  String? profilePic;

  Data(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.referralCode,
        this.notificationStatus,
        this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    referralCode = json['referral_code'];
    notificationStatus = json['notification_status'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['referral_code'] = referralCode;
    data['notification_status'] = notificationStatus;
    data['profile_pic'] = profilePic;
    return data;
  }
}

class Contactinfo {
  String? address;
  String? contact;
  String? email;
  String? facebook;
  String? twitter;
  String? instagram;
  String? linkedin;

  Contactinfo(
      {this.address,
        this.contact,
        this.email,
        this.facebook,
        this.twitter,
        this.instagram,
        this.linkedin});

  Contactinfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    contact = json['contact'];
    email = json['email'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    linkedin = json['linkedin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['contact'] = contact;
    data['email'] = email;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['instagram'] = instagram;
    data['linkedin'] = linkedin;
    return data;
  }
}
