import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/wallet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get_storage/get_storage.dart';
import '../add_money.dart';

// ignore: must_be_immutable
class WalletFlutterWave extends StatefulWidget {
  String? tkey;
  String? ekey;
  String? amt;

  WalletFlutterWave(
    this.tkey,
    this.ekey,
    this.amt, {super.key}
  );

  @override
  // ignore: library_private_types_in_public_api
  _WalletFlutterWaveState createState() => _WalletFlutterWaveState();
}

class _WalletFlutterWaveState extends State<WalletFlutterWave> {
  success_or_no_model? addmoney;
  GetStorage box = GetStorage();

  _handlePaymentInitialization() async {
    final Customer customer = Customer(
      name: box.read("u_name"),
      phoneNumber: box.read("u_mobile"),
      email: box.read("u_mail"),
    );
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
          "recharge_amount": widget.amt,
          "payment_type": "5",
          "payment_id": paykey,
        };
        var response = await Dio()
            .post(default_API.baseUrl + post_api.urlrecharge, data: map);

        var finallist = await response.data;
        addmoney = success_or_no_model.fromJson(finallist);
        if (addmoney!.status == 1) {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const WalletPage(),
              ),
              (route) => false);
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const AddMoneyPage();
            },
          ));
        }
      }
    } else {
      Loader.showLoading("No Response!");
    }
  }

  String getPublicKey() {
    if (isTestMode) return "${widget.tkey}";
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

