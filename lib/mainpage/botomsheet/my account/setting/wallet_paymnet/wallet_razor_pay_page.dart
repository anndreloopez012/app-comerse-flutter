import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' as getx;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:customer_ecomerce/api/all_model/login_model.dart';
import '../add_money.dart';
import '../wallet.dart';


// ignore: must_be_immutable
class WalletRazorPay extends StatefulWidget {
  String?tkey;
  String?amt;


  WalletRazorPay(this.tkey, this.amt, {super.key});

  @override
  State<WalletRazorPay> createState() => _WalletRazorPayState();
}

class _WalletRazorPayState extends State<WalletRazorPay> {
  Data?info;
  String? paykeys;
  String? paymessge;
  late Razorpay razorpay;
  getx.GetStorage box= getx.GetStorage();


  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openchekout();
  }
  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paykeys = response.paymentId;
    paymessge = "sucscess"; // D
    getaddwalletapi();// o something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    paymessge = response.message;
    getaddwalletapi();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {

    paymessge = "wallet";
    getaddwalletapi();
  }
  bool right = false;
  openchekout() async {

    var options = {
      'key': widget.tkey,
      'amount':double.parse(widget.amt!)*100 ,
      'name':box.read("u_name"),
      'description': "E-Commerce",
      'prefill': {
        'contact':box.read("u_mobile"),
        'email': box.read("u_mail"),
      }
    };
    try {
      razorpay.open(options);
    }
    catch (e) {
      Loader.showErroDialog(description: "Something went Wrong");
    }
  }

  success_or_no_model ? addmoney;
  getaddwalletapi() async {
    try {
      var map = {
        "user_id": box.read('user_id'),
        "recharge_amount":widget.amt,
        "payment_type":"3",
        "payment_id":paykeys,
      };
      var response = await Dio().post(default_API.baseUrl + post_api.urlrecharge, data: map);

      var finallist = await response.data;
      addmoney = success_or_no_model.fromJson(finallist);

      if (addmoney!.status==1) {
        Loader.showLoading();
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const WalletPage(),), (route) => false);

      }
      else
      {
        Loader.showLoading();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const AddMoneyPage();
        },));
      }
      return addmoney;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: "No Data Found");
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    );
  }
}
