import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Config/global_data.dart';
import '../success.dart';

// ignore: must_be_immutable
class OrderStripPay extends StatefulWidget {
  String? tkey;
  String? amt;
  String? fname;
  String? lnsme;
  String? mob;
  String? mail;
  String? lanmark;
  String? pin;
  String? strno;
  String? note;
  String? disamt;
  String? vendorid;

  OrderStripPay(
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
  State<OrderStripPay> createState() => _OrderStripPayState();
}

class _OrderStripPayState extends State<OrderStripPay> {
  TextEditingController cdname = TextEditingController();
  ThemeModel themeModel = Get.find<ThemeModel>();
  TextEditingController cdnum = TextEditingController();
  TextEditingController mm = TextEditingController();
  TextEditingController yy = TextEditingController();
  TextEditingController cv = TextEditingController();
  GetStorage box = GetStorage();
  String cardname = "";
  String cardnumber = "";
  String month = "";
  String year = "";
  String cvv = "";
  success_or_no_model? addmoney;

  Future getaddwalletapi() async {
    try {
      Loader.showLoading();
      var map = {
        "user_id": box.read('user_id'),
        "card_number": cardnumber,
        "card_exp_month": month,
        "card_exp_year": year,
        "card_cvc": cvv,
        "email": widget.mail,
        "full_name": "${widget.fname!} ${widget.lnsme!}",
        "landmark": widget.lanmark,
        "mobile": widget.mob,
        "order_notes": widget.note,
        "grand_total": widget.amt,
        "payment_type": "4",
        "pincode": widget.pin,
        "street_address": widget.strno,
        "coupon_name": "",
        "discount_amount": widget.disamt ?? "0",
        "vendor_id": widget.vendorid,
      };
      var response =
          await Dio().post(default_API.baseUrl + post_api.urlorder, data: map);
      var finallist = await response.data;
      addmoney = success_or_no_model.fromJson(finallist);
      if (addmoney!.status == 1) {
        Fluttertoast.showToast(
          msg: "${addmoney!.message}",
          toastLength: Toast.LENGTH_SHORT,
        );
        Get.to(() => const SucessFully());
      } else {
        Fluttertoast.showToast(
          msg: "${addmoney!.message}",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
      return addmoney;
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
            title: const Text(
              "Stripe",
            ),
            primary: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel_rounded,
                )),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(left: 12, right: 12, top: 22),
            child: Column(
              children: [
                TextField(
                  controller: cdname,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: GlobalData.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: GlobalData.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: GlobalData.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0))),
                    filled: true,
                    fillColor: themeModel.isdark.value
                        ? GlobalData.fullwhite
                        : GlobalData.fullblk,
                    hintText: "Card holder name",
                    hintStyle: TextStyle(
                        fontSize: 18.sp,
                        color: GlobalData.grey,
                        fontFamily: GlobalData.fontlistmedium),
                  ),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                TextField(
                  controller: cdnum,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: GlobalData.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: GlobalData.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: GlobalData.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0))),
                    filled: true,
                    fillColor: themeModel.isdark.value
                        ? GlobalData.fullwhite
                        : GlobalData.fullblk,
                    hintText: "Card Number  ",
                    hintStyle: TextStyle(
                        fontSize: 18.sp,
                        color: GlobalData.grey,
                        fontFamily: GlobalData.fontlistmedium),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 12,
                      ),
                      width: 30.w,
                      child: TextField(
                        controller: mm,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalData.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalData.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalData.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0))),
                          filled: true,
                          fillColor: themeModel.isdark.value
                              ? GlobalData.fullwhite
                              : GlobalData.fullblk,
                          hintText: "MM  ",
                          hintStyle: TextStyle(
                              fontSize: 18.sp,
                              color: GlobalData.grey,
                              fontFamily: GlobalData.fontlistmedium),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 12),
                      width: 30.w,
                      child: TextField(
                        controller: yy,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalData.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalData.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalData.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0))),
                          filled: true,
                          fillColor: themeModel.isdark.value
                              ? GlobalData.fullwhite
                              : GlobalData.fullblk,
                          hintText: "YYYY  ",
                          hintStyle: TextStyle(
                              fontSize: 18.sp,
                              color: GlobalData.grey,
                              fontFamily: GlobalData.fontlistmedium),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 12,
                      ),
                      width: 30.w,
                      child: TextField(
                        controller: cv,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalData.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalData.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: GlobalData.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0))),
                          filled: true,
                          fillColor: themeModel.isdark.value
                              ? GlobalData.fullwhite
                              : GlobalData.fullblk,
                          hintText: "CVV  ",
                          hintStyle: TextStyle(
                              fontSize: 18.sp,
                              color: GlobalData.grey,
                              fontFamily: GlobalData.fontlistmedium),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cardname = cdname.text;
                      cardnumber = cdnum.text;
                      month = mm.text;
                      year = yy.text;
                      cvv = cv.text;
                      if (cardname.isEmpty &&
                          cardnumber.isEmpty &&
                          month.isEmpty &&
                          year.isEmpty &&
                          cvv.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "Plzz enter your all deatils",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                      if (cardname.isEmpty) {
                        Fluttertoast.showToast(
                          msg: " Enter Card name ",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                      if (cardnumber.isEmpty) {
                        Fluttertoast.showToast(
                          msg: " Enter Card number ",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                      if (month.isEmpty) {
                        Fluttertoast.showToast(
                          msg: " Enter card ex month",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                      if (year.isEmpty) {
                        Fluttertoast.showToast(
                          msg: " Enter Card ex year ",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                      if (cvv.isEmpty) {
                        Fluttertoast.showToast(
                          msg: " Enter Card CVV  ",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                      if (cvv.length != 3) {
                        Fluttertoast.showToast(
                          msg: " Enter valid CVV  ",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      } else {
                        getaddwalletapi();
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 22),
                    alignment: Alignment.center,
                    height: 6.5.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: GlobalData.bluebtn,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text("Submit",
                        style: TextStyle(
                            color: GlobalData.fullwhite,
                            fontSize: 18,
                            fontFamily: GlobalData.fontlistsemibold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
