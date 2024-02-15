import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/all_string.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/cman_widget_product.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/wallet_paymnet/allet_flutterwave.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/wallet_paymnet/walet_srip_pay.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/wallet_paymnet/wallet_razor_pay_page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Config/thememodel.dart';
import '../../../../api/all_model/paymnet_slect_model.dart';

class AddMoneyPage extends StatefulWidget {
  const AddMoneyPage({super.key});

  @override
  State<AddMoneyPage> createState() => _AddMoneyPageState();
}

class _AddMoneyPageState extends State<AddMoneyPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  String? namepay;
  List<Paymentlist> person = [];
  paymnet_model? payment;

  String? testPayKeypublic;
  String? testsPayKeysecret;
  String? livePayKeypublic;
  String? livePayKeysecret;
  int? selectedindex;
  int? selectindex;
  String? encryptionkey;
  String amount = "";
  TextEditingController am = TextEditingController();
  bool fill = false;

  Future getpaymnetmethodapi() async {
    try {
      var map = {"user_id": box.read('user_id')};
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlpaymnetget, data: map);
     
      var finallist = await response.data;

      payment = paymnet_model.fromJson(finallist);
      person.clear();
      for (var element in payment!.paymentlist!) {
        if (element.paymentName != "COD" && element.paymentName != "Wallet") {
          person.add(element);
        }
      }

      return person;
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Add_Money'.tr,
            ),
            primary: true,
            leadingWidth: 40,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 12, right: 10),
                height: 14.h,
                decoration: BoxDecoration(
                    border: GlobalRadious.border,
                    color: themeModel.isdark.value
                        ? GlobalData.whitecolor
                        : GlobalData.fullblk,
                    borderRadius: GlobalRadious.radious_),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text("Add_Money_to_Wallet".tr,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: GlobalData.fontlistmedium,
                            ))),
                    TextField(
                      controller: am,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white38),
                              borderRadius: GlobalRadious.radious_),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white38)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white38),
                              borderRadius: GlobalRadious.radious_),
                          hintText: 'Enter_Your_Amount'.tr,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: GlobalData.fontlistregular),
                          fillColor: themeModel.isdark.value
                              ? GlobalData.whitecolor
                              : GlobalData.fullblk,
                          filled: true,
                          prefixIcon: const Icon(Icons.ac_unit_rounded),
                          focusColor: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Select_payment_method'.tr,
                  style: TextStyle(
                      fontFamily: GlobalData.fontlistsemibold, fontSize: 18.sp),
                ),
              ),
              SingleChildScrollView(
                child: FutureBuilder(
                  future: getpaymnetmethodapi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return person.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: SizedBox(
                                  height: 55.h,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    itemCount: person.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedindex = index;
                                          });
                                 
                                          namepay = person[index].paymentName;
                                          selectindex = index;
                                         
                                          testPayKeypublic =
                                              person[selectedindex!]
                                                  .testPublicKey!;
                                          testsPayKeysecret =
                                              person[selectedindex!]
                                                  .testSecretKey!;
                                          encryptionkey = person[selectedindex!]
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
                                                          person[index]
                                                                      .paymentName ==
                                                                  "RazorPay".tr
                                                              ? GlobalString
                                                                      .paymentmethodicon[
                                                                  2]
                                                              : person[index]
                                                                          .paymentName ==
                                                                      "Stripe".tr
                                                                  ? GlobalString
                                                                          .paymentmethodicon[
                                                                      3]
                                                                  : person[index]
                                                                              .paymentName ==
                                                                          "Flutterwave".tr
                                                                      ? GlobalString
                                                                              .paymentmethodicon[
                                                                          4]
                                                                      : person[index].paymentName ==
                                                                              "Paystack".tr
                                                                          ? GlobalString.paymentmethodicon[
                                                                              5]
                                                                          : GlobalString
                                                                              .paymentmethodicon[0],
                                                        ),
                                                        width: 60),
                                                    name: person[index]
                                                        .paymentName!,
                                                    fontfmly: GlobalData
                                                        .fontlistmedium,
                                                    leadwidg:
                                                        selectedindex == index
                                                            ? const Image(
                                                                image: AssetImage(
                                                                    icon_global.icpaymnetselect),
                                                                width: 20,
                                                              )
                                                            : const SizedBox(
                                                                height: 20,
                                                                width: 20,
                                                              )))),
                                      );
                                    },
                                  )),
                            )
                          : const SizedBox(
                              height: 500,
                              width: 500,
                              child: Image(
                                  image:
                                      AssetImage(icon_global.icnodata)),
                            );
                    }
                    return bulidcircu();
                  },
                ),
              ),
            ],
          ),
          bottomSheet: GestureDetector(
            onTap: () {
              setState(() {
                amount = am.text;
                if (amount.isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'Enter_Amount'.tr,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else if (selectedindex == null) {
                  Fluttertoast.showToast(
                    msg: 'select_payment_type'.tr,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else {
                  if (namepay == "RazorPay") {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return WalletRazorPay(
                            "$testPayKeypublic", amount);
                      },
                    ));
                  }
                  if (namepay == "Stripe") {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return WalletStripPay(amount);
                      },
                    ));
                  }
                  if (namepay == "Flutterwave") {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return WalletFlutterWave("$testPayKeypublic",
                            "$encryptionkey", amount);
                      },
                    ));
                  }
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: 7.h,
              width: double.infinity,
              color: GlobalData.bluebtn,
              child: Center(
                child: Text('Procced_to_Payment'.tr,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: GlobalData.fontlistmedium,
                        color: GlobalData.fullwhite)),
              ),
            ),
          ),
        );
      },
    );
  }
}
