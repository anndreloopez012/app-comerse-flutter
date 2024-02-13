// ignore: camel_case_types
class paymnet_model {
  int? status;
  String? message;
  List<Paymentlist>? paymentlist;
  String? walletamount;

  paymnet_model(
      {this.status, this.message, this.paymentlist, this.walletamount});

  paymnet_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['paymentlist'] != null) {
      paymentlist = <Paymentlist>[];
      json['paymentlist'].forEach((v) {
        paymentlist!.add(Paymentlist.fromJson(v));
      });
    }
    walletamount = json['walletamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] =status;
    data['message'] = message;
    if (paymentlist != null) {
      data['paymentlist'] = paymentlist!.map((v) => v.toJson()).toList();
    }
    data['walletamount'] = walletamount;
    return data;
  }
}

class Paymentlist {
  int? id;
  String? paymentName;
  String? testPublicKey;
  String? testSecretKey;
  String? livePublicKey;
  String? liveSecretKey;
  String? encryptionKey;
  String? environment;
  String? status;
  String? createdAt;
  String? updatedAt;

  Paymentlist(
      {this.id,
        this.paymentName,
        this.testPublicKey,
        this.testSecretKey,
        this.livePublicKey,
        this.liveSecretKey,
        this.encryptionKey,
        this.environment,
        this.status,
        this.createdAt,
        this.updatedAt});

  Paymentlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentName = json['paymentname'];
    testPublicKey = json['test_public_key'];
    testSecretKey = json['test_secret_key'];
    livePublicKey = json['live_public_key'];
    liveSecretKey = json['live_secret_key'];
    encryptionKey = json['encryption_key'];
    environment = json['environment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['paymentname'] = paymentName;
    data['test_public_key'] = testPublicKey;
    data['test_secret_key'] = testSecretKey;
    data['live_public_key'] = livePublicKey;
    data['live_secret_key'] = liveSecretKey;
    data['encryption_key'] = encryptionKey;
    data['environment'] = environment;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
