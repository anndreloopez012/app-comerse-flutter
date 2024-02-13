// ignore: camel_case_types
class login_model {
  int? status;
  String? message;
  Data? data;

  login_model({this.status, this.message, this.data});

  login_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
