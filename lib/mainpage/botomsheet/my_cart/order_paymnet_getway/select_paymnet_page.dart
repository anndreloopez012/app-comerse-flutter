import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/cman_widget_product.dart';
import 'package:customer_ecomerce/coman_widget/widget_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Config/all_string.dart';
import '../../../../api/all_model/paymnet_slect_model.dart';
import '../success.dart';

import 'order_flutterwave.dart';
import 'order_razor_pay_page.dart';
import 'order_srip_pay.dart';

// ignore: must_be_immutable
class SelectPaymnetPage extends StatefulWidget {
  String? gtotal;
  String? disamt;
  String? vedorid;
  String? fname;
  String? lname;
  String? landmark;
  String? mail;
  String? mobile;
  String? strno;
  String? note;
  String? pin;

  SelectPaymnetPage(
      this.gtotal,
      this.disamt,
      this.vedorid,
      this.fname,
      this.lname,
      this.landmark,
      this.mail,
      this.mobile,
      this.strno,
      this.note,
      this.pin, {super.key});

  @override
  State<SelectPaymnetPage> createState() => _SelectPaymnetPageState();
}

class _SelectPaymnetPageState extends State<SelectPaymnetPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  paymnet_model? payment;
  String? namepay;
  int? selectedindex;
  int? selectindex;
  String? testPayKeypublic;
  String? testsPayKeysecret;
  String? livePayKeypublic;
  String? livePayKeysecret;
  String? enryptionkey;
  GetStorage box = GetStorage();
  success_or_no_model? success;

  Future getpaymnetmethodapi() async {
    try {
      var map = {
        "user_id": box.read('user_id'),
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlpaymnetget, data: map);

      var finallist = await response.data;

      payment = paymnet_model.fromJson(finallist);

      return payment;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  Future getcodapi() async {
    Loader.showLoading();

    try {
      var map = {
        "user_id": box.read('user_id'),
        "email": widget.mail,
        "full_name": "${widget.fname!} ${widget.lname!}",
        "landmark": widget.landmark,
        "mobile": widget.mobile,
        "order_notes": widget.note,
        "grand_total": widget.gtotal,
        "payment_type": "1",
        "pincode": widget.pin,
        "street_address": widget.strno,
        "coupon_name": "",
        "discount_amount": widget.disamt ?? "0",
        "vendor_id": widget.vedorid,
      };
      var response =
          await Dio().post(default_API.baseUrl + post_api.urlorder, data: map);
      var finallist = await response.data;
      success = success_or_no_model.fromJson(finallist);
      if (success!.status == 1) {
        Get.to(() => () => const SucessFully());
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => SucessFully(),
        //     ),
        //     (route) => false);
      } else {
        Fluttertoast.showToast(
          msg: success!.message!,
          toastLength: Toast.LENGTH_SHORT,
        );
      }

      return success;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: "No Data Found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            primary: true,
            automaticallyImplyLeading: false,
            title: const Text("Payment Method"),
          ),
          body: Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 12, right: 12),
              child: FutureBuilder(
                future: getpaymnetmethodapi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return payment!.paymentlist!.isNotEmpty
                        ? SizedBox(
                            height: 62.h,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: payment!.paymentlist!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedindex = index;
                                    });
                                    namepay = payment!
                                        .paymentlist![index].paymentName;
                                    selectindex = index;
                                    testPayKeypublic = payment!
                                        .paymentlist![selectedindex!]
                                        .testPublicKey!;
                                    testsPayKeysecret = payment!
                                        .paymentlist![selectedindex!]
                                        .testSecretKey!;
                                    enryptionkey = payment!
                                        .paymentlist![selectedindex!]
                                        .encryptionKey!;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    height: 80,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: GlobalData.ofwhite),
                                        color: themeModel.isdark.value
                                            ? GlobalData.whitecolor
                                            : GlobalData.fullblk,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: buildlisttilecell(
                                          widd: Image(
                                              image: AssetImage(
                                                payment!.paymentlist![index]
                                                            .paymentName ==
                                                        "COD"
                                                    ? GlobalString
                                                        .paymentmethodicon[0]
                                                    : payment!
                                                                .paymentlist![
                                                                    index]
                                                                .paymentName ==
                                                            "Wallet"
                                                        ? GlobalString
                                                                .paymentmethodicon[
                                                            1]
                                                        : payment!
                                                                    .paymentlist![
                                                                        index]
                                                                    .paymentName ==
                                                                "RazorPay"
                                                            ? GlobalString
                                                                    .paymentmethodicon[
                                                                2]
                                                            : payment!
                                                                        .paymentlist![
                                                                            index]
                                                                        .paymentName ==
                                                                    "Stripe"
                                                                ? GlobalString
                                                                        .paymentmethodicon[
                                                                    3]
                                                                : payment!.paymentlist![index].paymentName ==
                                                                        "Flutterwave"
                                                                    ? GlobalString
                                                                            .paymentmethodicon[
                                                                        4]
                                                                    : payment!.paymentlist![index].paymentName ==
                                                                            "Paystack"
                                                                        ? GlobalString
                                                                            .paymentmethodicon[5]
                                                                        : GlobalString.paymentmethodicon[0],
                                              ),
                                              width: 60),
                                          name: payment!.paymentlist![index]
                                                      .paymentName ==
                                                  "COD"
                                              ? "${payment!.paymentlist![0]
                                                      .paymentName!} Payment"
                                              : payment!.paymentlist![index]
                                                          .paymentName ==
                                                      "Wallet"
                                                  ? "${"${payment!.paymentlist![1].paymentName!} Payment"} (${payment!.walletamount!})"
                                                  : payment!.paymentlist![index]
                                                              .paymentName ==
                                                          "RazorPay"
                                                      ? "${payment!.paymentlist![2]
                                                              .paymentName!} Payment"
                                                      : payment!.paymentlist![index].paymentName ==
                                                              "Stripe"
                                                          ? "${payment!
                                                                  .paymentlist![
                                                                      3]
                                                                  .paymentName!} Payment"
                                                          : payment!.paymentlist![index].paymentName ==
                                                                  "Flutterwave"
                                                              ? "${payment!.paymentlist![4].paymentName!} Payment"
                                                              : payment!.paymentlist![index].paymentName ==
                                                                      "Paystack"
                                                                  ? "${payment!.paymentlist![5].paymentName!} Payment"
                                                                  : "${payment!
                                                                          .paymentlist![0]
                                                                          .paymentName!} Payment",
                                          fontfmly: GlobalData.fontlistmedium,
                                          leadwidg: selectedindex == index
                                              ? const Image(
                                                  image: AssetImage(
                                                      icon_global.icpaymnetselect),
                                                  width: 20,
                                                )
                                              : const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                )),
                                    ),
                                  ),
                                );
                              },
                            ))
                        : buildNodata(imge: icon_global.icnodata);
                  } //if conditon
                  return bulidcircu();
                },
              )),
          bottomSheet: GestureDetector(
            onTap: () {
              setState(() {
                if (selectedindex == null) {
                  Fluttertoast.showToast(
                    msg: " select payment type ",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
                if (namepay == "RazorPay") {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return OrderRazorPayment(
                        "$testPayKeypublic",
                        "${widget.gtotal}",
                        "${widget.fname}",
                        "${widget.lname}",
                        "${widget.mobile}",
                        "${widget.mail}",
                        "${widget.landmark}",
                        "${widget.pin}",
                        "${widget.strno}",
                        "${widget.note}",
                        "${widget.disamt}",
                        "${widget.vedorid}",
                      );
                    },
                  ));
                }
                if (namepay == "COD") {
                  getcodapi();
                }
                if (namepay == "Stripe") {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return OrderStripPay(
                        "$testPayKeypublic",
                        "${widget.gtotal}",
                        "${widget.fname}",
                        "${widget.lname}",
                        "${widget.mobile}",
                        "${widget.mail}",
                        "${widget.landmark}",
                        "${widget.pin}",
                        "${widget.strno}",
                        "${widget.note}",
                        "${widget.disamt}",
                        "${widget.vedorid}",
                      );
                    },
                  ));
                }
                if (namepay == "Flutterwave") {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      // return flutter_wave();
                      return OrderFlutterWave(
                        "$testPayKeypublic",
                        "$enryptionkey",
                        "${widget.gtotal}",
                        "${widget.fname}",
                        "${widget.lname}",
                        "${widget.mobile}",
                        "${widget.mail}",
                        "${widget.landmark}",
                        "${widget.pin}",
                        "${widget.strno}",
                        "${widget.note}",
                        "${widget.disamt}",
                        "${widget.vedorid}",
                      );
                    },
                  ));
                }
                if (namepay == "Wallet") {
                  getcodapi();
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              color: GlobalData.bluebtn,
              child: Text("Proceed to Payment",
                  style: TextStyle(
                      color: GlobalData.fullwhite,
                      fontSize: 18,
                      fontFamily: GlobalData.fontlistsemibold)),
            ),
          ),
        );
      },
    );
  }
}
