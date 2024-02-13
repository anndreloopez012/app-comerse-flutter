// ignore: camel_case_types
class success_or_no_model {
  int? status;
  String? message;

  success_or_no_model({this.status, this.message});

  success_or_no_model.fromJson(Map<String, dynamic> json) {
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
