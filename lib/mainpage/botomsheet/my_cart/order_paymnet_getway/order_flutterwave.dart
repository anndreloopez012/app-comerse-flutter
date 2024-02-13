import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../success.dart';

// ignore: must_be_immutable
class OrderFlutterWave extends StatefulWidget {
  String? tkey;
  String? ekey;
  String? amt;
  String? fname;
  String? lname;
  String? mob;
  String? mail;
  String? lanmark;
  String? pin;
  String? strno;
  String? note;
  String? disamt;
  String? vendorid;

  OrderFlutterWave(
      this.tkey,
      this.ekey,
      this.amt,
      this.fname,
      this.lname,
      this.mob,
      this.mail,
      this.lanmark,
      this.pin,
      this.strno,
      this.note,
      this.disamt,
      this.vendorid, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderFlutterWaveState createState() => _OrderFlutterWaveState();
}

class _OrderFlutterWaveState extends State<OrderFlutterWave> {
  success_or_no_model? addmoney;
  GetStorage box = GetStorage();

  _handlePaymentInitialization() async {
    final Customer customer = Customer(
        name: "${widget.fname!} ${widget.lname!}",
        phoneNumber: "${widget.mob}",
        email: "${widget.mail}");
    // ignore: use_build_context_synchronously
    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: publicKeyController.text.trim().isEmpty
            ? getPublicKey()
            : publicKeyController.text.trim(),
        currency: "NGN",
        redirectUrl: "https://google.com",
        txRef: DateTime.now().toString(),
        amount: "${widget.amt}",
        customer: customer,
        // subAccounts: subAccounts,
        paymentOptions: "card, payattitude, barter",
        customization: Customization(title: "Test Payment"),
        isTestMode: false);
    final ChargeResponse response = await flutterwave.charge();

    // ignore: unnecessary_null_comparison
    if (response != null) {
      Loader.showLoading(response.status!);
      paykey = response.transactionId;
 
      if (paykey != null) {
        var map = {
          "user_id": box.read('user_id'),
          "email": widget.mail,
          "full_name": "${widget.fname!} ${widget.lname!}",
          "landmark": widget.lanmark,
          "mobile": widget.mob,
          "order_notes": widget.note,
          "grand_total": widget.amt,
          "payment_type": "5",
          "pincode": widget.pin,
          "street_address": widget.strno,
          "coupon_name": "",
          "discount_amount": widget.disamt ?? "0",
          "vendor_id": widget.vendorid,
          "payment_id": paykey,
        };
        var response = await Dio()
            .post(default_API.baseUrl + post_api.urlorder, data: map);
        
        var finallist = await response.data;
        addmoney = success_or_no_model.fromJson(finallist);
        if (addmoney!.status == 1) {
          Get.to(() => const SucessFully());
        } else {}
      }
    } else {
      Loader.showLoading("No Response!");
    }
  }

  String getPublicKey() {
    if (isTestMode) {
      return "${widget.tkey}";
    }
    return "${widget.ekey}";
  }

  final publicKeyController = TextEditingController();
  String? paykey;
  bool isTestMode = true;
  bool right = false;

  @override
  void initState() {
    super.initState();
    _handlePaymentInitialization();
  }

  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
