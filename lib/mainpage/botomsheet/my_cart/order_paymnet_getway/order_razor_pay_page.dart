import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../success.dart';

// ignore: must_be_immutable
class OrderRazorPayment extends StatefulWidget {
  String?tkey;
  String?amt;
  String?fname;
  String?lnsme;
  String?mob;
  String?mail;
  String?lanmark;
  String?pin;
  String?strno;
  String?note;
  String?disamt;
  String?vendorid;


  OrderRazorPayment(
      this.tkey,
      this.amt,
      this.fname,
      this.lnsme,
      this.mob,
      this.mail,
      this.lanmark,
      this.pin,
      this.strno,
      this.note,
      this.disamt,
      this.vendorid, {super.key});

  @override
  State<OrderRazorPayment> createState() => _OrderRazorPaymentState();
}

class _OrderRazorPaymentState extends State<OrderRazorPayment> {
  String? paykeys;
  String? paymessge;
  late Razorpay razorpay;
  GetStorage box= GetStorage();


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
    // Do something when payment fails

    paymessge = response.message;
    getaddwalletapi();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
   
    paymessge = "wallet";
    getaddwalletapi();
  }
  bool right = false;
  openchekout() async {
    var options = {
      'key': widget.tkey,
      'amount':double.parse(widget.amt!)*100 ,
      'name':"${widget.fname!} ${widget.lnsme!}",
      'description': "DigiColmado",
      'prefill': {
        'contact':widget.mob!,
        'email': widget.mail!,
      }
    };
    try {
      razorpay.open(options);
    }
    // ignore: empty_catches
    catch (e) {
      
    }
  }

  success_or_no_model ? addmoney;
  getaddwalletapi() async {
    try {
      var map = {
        "user_id": box.read('user_id'),
        "email":widget.mail,
        "full_name":"${widget.fname!} ${widget.lnsme!}",
        "landmark":widget.lanmark,
        "mobile":widget.mob,
        "order_notes":widget.note,
        "grand_total":widget.amt,
        "payment_type":"3",
        "pincode":widget.pin,
        "street_address":widget.strno,
        "coupon_name":"",
        "discount_amount":widget.disamt??"0",
        "vendor_id":widget.vendorid,
        "payment_id":paykeys,
      };
      var response = await Dio().post(default_API.baseUrl + post_api.urlorder, data: map);
     
      var finallist = await response.data;
      addmoney = success_or_no_model.fromJson(finallist);
      if (addmoney!.status==1) {
        Loader.showLoading();
        Get.to(() => () => const SucessFully());
      }
      else
      {
        Loader.showLoading();
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
