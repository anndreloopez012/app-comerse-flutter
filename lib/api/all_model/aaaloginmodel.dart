// ignore_for_file: prefer_collection_literals

class SignUpmodel {
  int? status;
  String? message;
  Data? data;
  int? otp;

  SignUpmodel({this.status, this.message, this.data, this.otp});

  SignUpmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['otp'] = otp;
    return data;
  }
}

class Data {
  int? id;
  dynamic name;
  dynamic mobile;
  dynamic email;
  dynamic referralCode;
  dynamic profilePic;

  Data(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.referralCode,
        this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    referralCode = json['referral_code'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['referral_code'] = referralCode;
    data['profile_pic'] = profilePic;
    return data;
  }
}
