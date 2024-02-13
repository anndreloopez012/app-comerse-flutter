// ignore: camel_case_types
class register_api {
  int? status;
  String? message;

  register_api({this.status, this.message});

  register_api.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
