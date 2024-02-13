// ignore: camel_case_types
class cmpspage {
  int? status;
  String? message;
  String? termsconditions;
  String? privacypolicy;
  String? about;

  cmpspage(
      {this.status,
        this.message,
        this.termsconditions,
        this.privacypolicy,
        this.about});

  cmpspage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    termsconditions = json['termsconditions'];
    privacypolicy = json['privacypolicy'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['termsconditions'] = termsconditions;
    data['privacypolicy'] = privacypolicy;
    data['about'] = about;
    return data;
  }
}
