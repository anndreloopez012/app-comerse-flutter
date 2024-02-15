import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/chack_out.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../coman_widget/cman_widget_product.dart';
import '../home_page/products_details.dart';
import '../my account/setting/my_address.dart';
import 'order_paymnet_getway/select_paymnet_page.dart';

// ignore: must_be_immutable
class CheckOutPage extends StatefulWidget {
  String? amt;
  String? nam;
  String? lastn;
  String? lan;
  String? mo;
  String? mail;
  String? stret;
  String? pin;

  // ignore: use_key_in_widget_constructors
  CheckOutPage(
      [this.amt,
      this.nam,
      this.lastn,
      this.lan,
      this.mo,
      this.mail,
      this.stret,
      this.pin]);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  chekout_model? chek;
  String codes = "";
  TextEditingController code = TextEditingController();
  TextEditingController note = TextEditingController();
  bool isvisible = false;
  bool show = false;
  bool alld = false;

  Future chekoutapi() async {
    var map = {"user_id": box.read('user_id'), "coupon_name": codes};
    var response =
        await Dio().post(default_API.baseUrl + post_api.urlchekout, data: map);

    var finallist = await response.data;
    chek = chekout_model.fromJson(finallist);
    if (response.statusCode == 200) {
      if (chek!.status == 0) {
        Fluttertoast.showToast(msg: chek!.message!);
      } else {
        Fluttertoast.showToast(msg: "suucess");
        if (show == false) {
          setState(() {
            show = true;
          });
        } else {
          codes = "";
          setState(() {
            show = false;
          });
        }
      }
    }

    setState(() {
      alld = true;
    });
    return chek;
  }

  @override
  void initState() {
    super.initState();
    chekoutapi();
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
            title: Text("Check_out".tr),
          ),
          body: SizedBox(
              height: double.infinity,
              child: alld == true
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 3.w, right: 3.w, top: 1.h, bottom: 10.h),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: chek!.cartdata!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Get.to(() => ProdutsDetails(
                                            chek!.cartdata![index].productId,
                                            chek!.cartdata![index]
                                                .productName));
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.5,
                                                  color:
                                                      GlobalData.whitecolor),
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 12.h,
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Container(
                                                      width: 22.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          4)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(chek!
                                                                  .cartdata![
                                                                      index]
                                                                  .imageUrl!),
                                                              fit: BoxFit
                                                                  .fill)),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                chek!
                                                                    .cartdata![
                                                                        index]
                                                                    .productName!,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontFamily:
                                                                      GlobalData
                                                                          .fontlistbold,
                                                                ),
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                        chek!.cartdata![index].attribute != null
                                                                            ? chek!.cartdata![index].attribute!
                                                                            : "Size ",
                                                                        style: TextStyle(
                                                                          color: themeModel.isdark.value ? GlobalData.darkgray : GlobalData.fullblk,
                                                                        )),
                                                                    Text(
                                                                        chek!.cartdata![index].variation != null
                                                                            ? ": ${chek!.cartdata![index].variation}"
                                                                            : " ",
                                                                        style: TextStyle(
                                                                          color: themeModel.isdark.value ? GlobalData.darkgray : GlobalData.fullblk,
                                                                        )),
                                                                  ],
                                                                ),
                                                                const Spacer(),
                                                                Text(
                                                                    box.read("pos") ==
                                                                            "right"
                                                                        ? "${"Qty : ${chek!.cartdata![index].qty}"}*${GlobalData.formatCurrency.format(double.parse(chek!.cartdata![index].price!)) + box.read("doller")}"
                                                                        : "${"Qty : ${chek!.cartdata![index].qty}"}*${box.read("doller") + GlobalData.formatCurrency.format(double.parse(chek!.cartdata![index].price!))}",
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          15.sp,
                                                                      color: themeModel.isdark.value
                                                                          ? GlobalData.darkgray
                                                                          : GlobalData.fullblk,
                                                                    )),
                                                              ],
                                                            ),
                                                            const Spacer(),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                      box.read("pos") ==
                                                                              "right"
                                                                          ? GlobalData.formatCurrency.format(double.parse(chek!.cartdata![index].price!)) +
                                                                              box.read("doller")
                                                                          : box.read("doller") + GlobalData.formatCurrency.format(double.parse(chek!.cartdata![index].price!)),
                                                                      style: TextStyle(fontFamily: GlobalData.fontlistsemibold, fontSize: 16.sp)),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 8.h,
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 7),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Shipping".tr,
                                                          style: TextStyle(
                                                              color: themeModel
                                                                      .isdark
                                                                      .value
                                                                  ? GlobalData
                                                                      .darkgray
                                                                  : GlobalData
                                                                      .fullwhite,
                                                              fontSize: 15.sp,
                                                              fontFamily:
                                                                  GlobalData
                                                                      .fontlistregular),
                                                        ),
                                                        Center(
                                                          child: Text(
                                                              box.read("pos") ==
                                                                      "right"
                                                                  ? GlobalData.formatCurrency.format(double.parse(chek!.cartdata![index].shippingCost!)) + box.read("doller")
                                                                  : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(chek!.cartdata![index].shippingCost!))}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      GlobalData
                                                                          .fontlistmedium,
                                                                  fontSize:
                                                                      15.sp)),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Tax".tr,
                                                          style: TextStyle(
                                                              color: themeModel
                                                                      .isdark
                                                                      .value
                                                                  ? GlobalData
                                                                      .darkgray
                                                                  : GlobalData
                                                                      .fullwhite,
                                                              fontSize: 15.sp,
                                                              fontFamily:
                                                                  GlobalData
                                                                      .fontlistregular),
                                                        ),
                                                        Center(
                                                          child: Text(
                                                              box.read("pos") ==
                                                                      "right"
                                                                  ? GlobalData.formatCurrency.format(double.parse(chek!.cartdata![index].tax!.toString())) + box.read("doller")
                                                                  : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(chek!.cartdata![index].tax!.toString()))}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      GlobalData
                                                                          .fontlistmedium,
                                                                  fontSize:
                                                                      15.sp)),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Total".tr,
                                                          style: TextStyle(
                                                              color: themeModel
                                                                      .isdark
                                                                      .value
                                                                  ? GlobalData
                                                                      .darkgray
                                                                  : GlobalData
                                                                      .fullwhite,
                                                              fontSize: 15.sp,
                                                              fontFamily:
                                                                  GlobalData
                                                                      .fontlistregular),
                                                        ),
                                                        Center(
                                                          child: Text(
                                                              box.read("pos") ==
                                                                      "right"
                                                                  ? GlobalData.formatCurrency.format(double.parse(chek!.cartdata![index].total!.toString())) + box.read("doller")
                                                                  : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(chek!.cartdata![index].total!.toString()))}",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      GlobalData
                                                                          .fontlistmedium,
                                                                  fontSize:
                                                                      15.sp)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )));
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isvisible = false;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 2.h),
                                  decoration: BoxDecoration(
                                      color: GlobalData.bluebtn,
                                      border: GlobalRadious.border,
                                      borderRadius: GlobalRadious.radious_),
                                  height: 8.h,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Icon(
                                        Icons.info_outline,
                                        color: GlobalData.fullwhite,
                                        size: 3.h,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Expanded(
                                          child: Text(
                                              "Have_a_coupon_Click_here_to_enter_your_code"
                                                  .tr,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontFamily:
                                                      GlobalData.fontlistmedium,
                                                  color: GlobalData.fullwhite,
                                                  fontSize: 16.sp))),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Visibility(
                                  visible: isvisible,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "if_you_have_a_coupon_code_please_apply_it_below",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              color: GlobalData.darkgray,
                                              fontSize: 15.5.sp)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 60.w,
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(top: 10),
                                            child: TextField(
                                              controller: code,
                                              readOnly:
                                                  show == false ? true : false,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(10),
                                                  border: const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.white38),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(8))),
                                                  enabledBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.white38)),
                                                  focusedBorder: const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.white38),
                                                      borderRadius:
                                                          BorderRadius.all(Radius.circular(8))),
                                                  hintText: "Coupon_Code".tr,
                                                  hintStyle: TextStyle(fontSize: 16.sp, fontFamily: GlobalData.fontlistregular),
                                                  fillColor: themeModel.isdark.value ? GlobalData.whitecolor : GlobalData.fullblk,
                                                  filled: true,
                                                  focusColor: Colors.white),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              codes = code.text;

                                              if (codes.isEmpty) {
                                                Fluttertoast.showToast(
                                                  msg: "Enter_your_Coupen_code".tr,
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                );
                                              } else {
                                                if (show == false) {
                                                  code.clear();
                                                }
                                                chekoutapi();
                                              }
                                            },
                                            child: Container(
                                              height: 6.h,
                                              width: 30.w,
                                              margin: const EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                  color: GlobalData.whitecolor,
                                                  borderRadius:
                                                      GlobalRadious.radious_,
                                                  border: Border.all(
                                                      color: GlobalData.grey)),
                                              child: Center(
                                                child: Text(
                                                    show == true
                                                        ? "Apply".tr
                                                        : "Remove".tr,
                                                    style: TextStyle(
                                                        fontFamily: GlobalData
                                                            .fontlistsemibold,
                                                        color: show == true
                                                            ? GlobalData.fullblk
                                                            : GlobalData
                                                                .redcolor,
                                                        fontSize: 17.sp)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Billing_Shiping_address".tr,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily:
                                            GlobalData.fontlistsemibold),
                                  ),
                                  const Spacer(),
                                  Visibility(
                                    visible: widget.nam == null
                                        ? isvisible == true
                                        : isvisible == false,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return MyAdressPage(
                                              true,
                                            );
                                          },
                                        ));
                                      },
                                      child: Text(
                                        "Edit".tr,
                                        style: TextStyle(
                                          color: themeModel.isdark.value
                                              ? GlobalData.darkgray
                                              : GlobalData.fullwhite,
                                          fontFamily:
                                              GlobalData.fontlistsemibold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                height: 16.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: GlobalRadious.border,
                                    borderRadius: GlobalRadious.radious_,
                                    color: GlobalData.whitecolor),
                                child: widget.nam == null
                                    ? Container(
                                        alignment: Alignment.center,
                                        height: 60,
                                        width: 60,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    GlobalData.bluebtn),
                                            onPressed: () async {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return MyAdressPage(true);
                                                },
                                              ));
                                            },
                                            child: Text(
                                              "Select_Address".tr,
                                              style: TextStyle(
                                                  color: themeModel.isdark.value
                                                      ? GlobalData.fullwhite
                                                      : GlobalData.fullwhite,
                                                  fontFamily: GlobalData
                                                      .fontlistmedium),
                                            )),
                                      )
                                    : SizedBox(
                                        height: 12.h,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${widget.nam!} ${widget.lastn!}",
                                                style: TextStyle(
                                                    fontFamily: GlobalData
                                                        .fontlistsemibold,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                "${widget.stret!} ${widget.lan!} ${widget.pin!} ",
                                                style: TextStyle(
                                                    color: themeModel
                                                            .isdark.value
                                                        ? GlobalData.darkgray
                                                        : GlobalData.fullwhite,
                                                    fontFamily: GlobalData
                                                        .fontlistregular,
                                                    fontSize: 15.sp),
                                              ),
                                              Text(
                                                widget.mo!,
                                                style: TextStyle(
                                                    color: themeModel
                                                            .isdark.value
                                                        ? GlobalData.darkgray
                                                        : GlobalData.fullwhite,
                                                    fontFamily: GlobalData
                                                        .fontlistregular,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                widget.mail!,
                                                // "xyz@yopmail.com",
                                                style: TextStyle(
                                                    color: themeModel
                                                            .isdark.value
                                                        ? GlobalData.darkgray
                                                        : GlobalData.fullwhite,
                                                    fontFamily: GlobalData
                                                        .fontlistregular,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        )),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "Order_info".tr,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: GlobalData.fontlistsemibold),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal".tr,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: GlobalData.ofwhite,
                                        fontFamily:
                                            GlobalData.fontlistsemibold),
                                  ),
                                  Text(
                                      box.read("pos") == "right"
                                          ? GlobalData.formatCurrency.format(double.parse(chek!.data!.subtotal!.toString())) + box.read("doller")
                                          : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(chek!.data!.subtotal!.toString()))}",
                                      style: TextStyle(
                                          color: themeModel.isdark.value
                                              ? GlobalData.darkgray
                                              : GlobalData.fullwhite,
                                          fontFamily: GlobalData.fontlistmedium,
                                          fontSize: 16.sp)),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tax".tr,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: GlobalData.ofwhite,
                                        fontFamily:
                                            GlobalData.fontlistsemibold),
                                  ),
                                  Text(
                                      box.read("pos") == "right"
                                          ? GlobalData.formatCurrency.format(double.parse(chek!.data!.tax!.toString())) + box.read("doller")
                                          : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(chek!.data!.tax!.toString()))}",
                                      style: TextStyle(
                                          color: themeModel.isdark.value
                                              ? GlobalData.darkgray
                                              : GlobalData.fullwhite,
                                          fontFamily: GlobalData.fontlistmedium,
                                          fontSize: 16.sp)),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Shipping".tr,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: GlobalData.ofwhite,
                                        fontFamily:
                                            GlobalData.fontlistsemibold),
                                  ),
                                  Text(
                                      box.read("pos") == "right"
                                          ? GlobalData.formatCurrency.format(double.parse(chek!.data!.shippingCost!.toString())) + box.read("doller")
                                          : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(chek!.data!.shippingCost!.toString()))}",
                                      style: TextStyle(
                                          color: themeModel.isdark.value
                                              ? GlobalData.darkgray
                                              : GlobalData.fullwhite,
                                          fontFamily: GlobalData.fontlistmedium,
                                          fontSize: 16.sp)),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount".tr,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: GlobalData.ofwhite,
                                        fontFamily:
                                            GlobalData.fontlistsemibold),
                                  ),
                                  Text(
                                      box.read("pos") == "right"
                                          ? GlobalData.formatCurrency.format(double.parse(chek!.data!.discountAmount!.toString())) + box.read("doller")
                                          : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(chek!.data!.discountAmount!.toString()))}",
                                      style: TextStyle(
                                          color: themeModel.isdark.value
                                              ? GlobalData.darkgray
                                              : GlobalData.fullwhite,
                                          fontFamily: GlobalData.fontlistmedium,
                                          fontSize: 16.sp)),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Divider(
                                height: 1.h,
                                color: GlobalData.grey,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Grand_Total".tr,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily:
                                            GlobalData.fontlistsemibold),
                                  ),
                                  Text(
                                      box.read("pos") == "right"
                                          ? GlobalData.formatCurrency.format(double.parse(chek!.data!.grandTotal!.toString())) + box.read("doller")
                                          : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(chek!.data!.grandTotal!.toString()))}",
                                      style: TextStyle(
                                          color: themeModel.isdark.value
                                              ? GlobalData.fullblk
                                              : GlobalData.fullwhite,
                                          fontFamily:
                                              GlobalData.fontlistsemibold,
                                          fontSize: 17.sp)),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "Note".tr,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: GlobalData.fontlistsemibold),
                              ),
                              SizedBox(height: 1.5.h),
                              TextField(
                                controller: note,
                                maxLines: 3,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white38),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white38)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white38),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    hintText: "Order_Note".tr,
                                    hintStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: GlobalData.fontlistregular,
                                      color: themeModel.isdark.value
                                          ? GlobalData.darkgray
                                          : GlobalData.whitecolor,
                                    ),
                                    fillColor: themeModel.isdark.value
                                        ? GlobalData.whitecolor
                                        : GlobalData.fullblk,
                                    filled: true,
                                    focusColor: Colors.white),
                              ),
                            ]),
                      ),
                    )
                  : bulidcircu()),
          bottomSheet: GestureDetector(
            onTap: () {
              setState(() {
                String notes = note.text;
                if (widget.nam == null) {
                  Fluttertoast.showToast(msg: "select_your_aaddress".tr);
                } else {
                  Get.to(() => SelectPaymnetPage(
                    "${chek!.data!.grandTotal!}",
                    "${chek!.data!.discountAmount!}",
                    "${chek!.data!.vendorId!}",
                    "${widget.nam}",
                    "${widget.lastn}",
                    "${widget.lan}",
                    "${widget.mail}",
                    "${widget.mo}",
                    "${widget.stret}",
                    notes,
                    "${widget.pin}",
                  ));
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(color: GlobalData.bluebtn),
              height: 6.5.h,
              child: Center(
                child: Text("Procced_to_Payment".tr,
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
