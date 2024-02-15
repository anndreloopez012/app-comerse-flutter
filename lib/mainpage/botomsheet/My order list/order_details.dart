import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/order_details_model.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/My%20order%20list/return_request_page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../home_page/notification.dart';
import '../home_page/track_order.dart';

// ignore: must_be_immutable
class OrderDetailsPage extends StatefulWidget {
  String? ordernum;

  // ignore: use_key_in_widget_constructors
  OrderDetailsPage([this.ordernum]);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  GetStorage box = GetStorage();
  order_details_model? order;
  success_or_no_model? suuce;

  Future orderdetailsapi() async {
    try {
      var map = {"order_number": widget.ordernum};

      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlorderdetails, data: map);

      order = order_details_model.fromJson(response.data);

      return order;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  ordercancelapi(int index) async {
    Loader.showLoading();
    try {
      var map = {
        "user_id": box.read('user_id'),
        "order_id": order!.orderData![index].id!,
        "status": "5"
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlordercancle, data: map);

      suuce = success_or_no_model.fromJson(response.data);
      Loader.hideLoading();
      if (suuce!.status == 1) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return const NotificationPage();
          },
        ), (route) => false);
      } else {
        Loader.showErroDialog(description: suuce!.message!);
      }
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  orderreturnapi(int index) async {
    Loader.showLoading();
    try {
      var map = {
        "user_id": box.read('user_id'),
        "order_id": order!.orderData![index].id!,
        "status": "5"
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlordercancle, data: map);

      suuce = success_or_no_model.fromJson(response.data);
      Loader.hideLoading();
      if (suuce!.status == 1) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return const NotificationPage();
          },
        ), (route) => false);
      } else {
        Loader.showErroDialog(description: suuce!.message!);
      }
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            primary: true,
            automaticallyImplyLeading: false,
            title: Text("Order_Details".tr),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
          ),
          body: Container(
              height: 89.h,
              margin: const EdgeInsets.only(left: 12, right: 12),
              child: FutureBuilder(
                future: orderdetailsapi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 10.h,
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            color: GlobalData.whitecolor,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 4, bottom: 12, left: 4, top: 12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Order Id : ${order!.orderInfo!.orderNumber!}",
                                        style: TextStyle(
                                            fontFamily:
                                                GlobalData.fontlistregular,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        formateddatelist(
                                            order!.orderInfo!.date),
                                        style: TextStyle(
                                            fontFamily:
                                                GlobalData.fontlistregular,
                                            color: themeModel.isdark.value
                                                ? GlobalData.darkgray
                                                : GlobalData.fullblk,
                                            fontSize: 15.sp),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        order!.orderInfo!.paymentType == "1"
                                            ? "Payment Type : Cash"
                                            : order!.orderInfo!.paymentType ==
                                                    "2"
                                                ? "Payment Type : wallet"
                                                : order!.orderInfo!
                                                            .paymentType ==
                                                        "3"
                                                    ? "Payment Type : RazorPay"
                                                    : order!.orderInfo!
                                                                .paymentType ==
                                                            "4"
                                                        ? "Payment Type : Stripe"
                                                        : order!.orderInfo!
                                                                    .paymentType ==
                                                                "5"
                                                            ? "Payment Type : Flutterwave"
                                                            : order!.orderInfo!
                                                                        .paymentType ==
                                                                    "6"
                                                                ? "Payment Type : Paystack"
                                                                : "",
                                        style: TextStyle(
                                            fontFamily:
                                                GlobalData.fontlistregular,
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h * order!.orderData!.length,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: GlobalData.darkgray,
                                  height: 0.5,
                                );
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: order!.orderData!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: GlobalData.whitecolor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Slidable(
                                    enabled: order!.orderData![index].status ==
                                                "5" ||
                                            order!.orderData![index].status ==
                                                "7"
                                        ? false
                                        : true,
                                    endActionPane: ActionPane(
                                        extentRatio: 0.25,
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                setState) {
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                            color: themeModel
                                                                    .isdark
                                                                    .value
                                                                ? GlobalData
                                                                    .fullwhite
                                                                : GlobalData
                                                                    .fullblk,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        height: 24.h,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      height:
                                                                          40.h,
                                                                      width: double
                                                                          .infinity,
                                                                      color: themeModel
                                                                              .isdark
                                                                              .value
                                                                          ? GlobalData
                                                                              .fullwhite
                                                                          : GlobalData
                                                                              .fullblk,
                                                                      margin: const EdgeInsets.only(
                                                                          left:
                                                                              12,
                                                                          right:
                                                                              12),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                50,
                                                                            child: IconButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                icon: const Icon(Icons.close)),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                const EdgeInsets.only(left: 12, right: 12),
                                                                            child:
                                                                                Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                              SizedBox(child: Image(image: const AssetImage(icon_global.iccancelround), width: 30.w)),
                                                                              SizedBox(
                                                                                height: 1.5.h,
                                                                              ),
                                                                              SizedBox(
                                                                                child: Text(
                                                                                  "Cancel_Product".tr,
                                                                                  style: TextStyle(fontSize: 18.sp, fontFamily: GlobalData.fontlistsemibold),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 8,
                                                                              ),
                                                                              SizedBox(
                                                                                child: Text(
                                                                                  "Are_you_sure_to_cancel_the_product_from_your_order".tr,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(fontSize: 16.sp, fontFamily: GlobalData.fontlistmedium),
                                                                                ),
                                                                              )
                                                                            ]),
                                                                          ),
                                                                          const Spacer(),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              ordercancelapi(index);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 6.5.h,
                                                                              margin: EdgeInsets.only(bottom: 1.h),
                                                                              width: double.infinity,
                                                                              decoration: BoxDecoration(borderRadius: GlobalRadious.radious_, color: GlobalData.fullblk),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "Procced".tr,
                                                                                  style: TextStyle(fontFamily: GlobalData.fontlistsemibold, color: GlobalData.fullwhite, fontSize: 18.sp),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                );

                                                                // ordercancelapi(index);
                                                              },
                                                              child: SizedBox(
                                                                height: 4.h,
                                                                width: double
                                                                    .infinity,
                                                                child: Text(
                                                                    "Cancel_Order".tr,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: themeModel.isdark.value
                                                                            ? GlobalData
                                                                                .bluebtn
                                                                            : GlobalData
                                                                                .whitecolor,
                                                                        fontSize: 18
                                                                            .sp,
                                                                        fontFamily:
                                                                            GlobalData.fontlistsemibold)),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          6),
                                                              height: 0.8,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              color: themeModel
                                                                      .isdark
                                                                      .value
                                                                  ? GlobalData
                                                                      .ofblack
                                                                  : GlobalData
                                                                      .whitecolor,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                if (order!.orderData![index].status == "1" ||
                                                                    order!
                                                                            .orderData![
                                                                                index]
                                                                            .status ==
                                                                        "2" ||
                                                                    order!
                                                                            .orderData![
                                                                                index]
                                                                            .status ==
                                                                        "3" ||
                                                                    order!.orderData![index]
                                                                            .status ==
                                                                        "4") {
                                                                  Get.to(() => TrackOrder(order!
                                                                      .orderData![
                                                                          index]
                                                                      .id!
                                                                      .toString()));
                                                                } else {
                                                                  Get.to(() => TrackOrder(order!
                                                                      .orderData![
                                                                          index]
                                                                      .productId!));
                                                                }
                                                              },
                                                              child: SizedBox(
                                                                height: 4.h,
                                                                width: double
                                                                    .infinity,
                                                                child: Text(
                                                                    "TrackOrder".tr,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: themeModel.isdark.value
                                                                            ? GlobalData
                                                                                .bluebtn
                                                                            : GlobalData
                                                                                .whitecolor,
                                                                        fontSize: 18
                                                                            .sp,
                                                                        fontFamily:
                                                                            GlobalData.fontlistsemibold)),
                                                              ),
                                                            ),
                                                            if (order!
                                                                    .orderData![
                                                                        index]
                                                                    .status ==
                                                                "4") ...{
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                            vertical:
                                                                                6),
                                                                    height: 0.8,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    color: themeModel
                                                                            .isdark
                                                                            .value
                                                                        ? GlobalData
                                                                            .ofblack
                                                                        : GlobalData
                                                                            .whitecolor,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      Get.to(() => ReturnRequest(order!
                                                                          .orderData![
                                                                              index]
                                                                          .id!
                                                                          .toString()));
                                                                    },
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          4.h,
                                                                      width: double
                                                                          .infinity,
                                                                      child: Text(
                                                                          "ReturnRequest".tr,
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              color: themeModel.isdark.value ? GlobalData.bluebtn : GlobalData.whitecolor,
                                                                              fontSize: 18.sp,
                                                                              fontFamily: GlobalData.fontlistsemibold)),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            },
                                                            Container(
                                                              margin: const EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          6),
                                                              height: 0.8,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              color: themeModel
                                                                      .isdark
                                                                      .value
                                                                  ? GlobalData
                                                                      .ofblack
                                                                  : GlobalData
                                                                      .whitecolor,
                                                            ),
                                                            GestureDetector(
                                                              onTap: (){
                                                                Navigator.pop(context);
                                                              },
                                                              child: SizedBox(
                                                                height: 4.h,
                                                                width: double
                                                                    .infinity,
                                                                child: Text(
                                                                    'Cancel'.tr,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: themeModel.isdark.value
                                                                            ? GlobalData
                                                                                .red
                                                                            : GlobalData
                                                                                .whitecolor,
                                                                        fontSize: 18
                                                                            .sp,
                                                                        fontFamily:
                                                                            GlobalData.fontlistsemibold)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                                  });
                                            },
                                            backgroundColor: GlobalData.gray,
                                            foregroundColor: Colors.white,
                                            label: 'More'.tr,
                                          ),
                                        ]),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10.8.h,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 24.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(Radius
                                                            .circular(10)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            order!
                                                                .orderData![
                                                                    index]
                                                                .imageUrl!),
                                                        fit: BoxFit.fill)),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 10),
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
                                                          order!
                                                              .orderData![index]
                                                              .productName!,
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontFamily: GlobalData
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
                                                                  order!.orderData![index].attribute !=
                                                                          null
                                                                      ? order!
                                                                          .orderData![
                                                                              index]
                                                                          .attribute!
                                                                      : "null ",
                                                                  style:
                                                                      TextStyle(
                                                                    color: themeModel
                                                                            .isdark
                                                                            .value
                                                                        ? GlobalData
                                                                            .darkgray
                                                                        : GlobalData
                                                                            .fullblk,
                                                                  )),
                                                              Text(
                                                                  order!.orderData![index].variation !=
                                                                          null
                                                                      ? ": ${order!.orderData![index].variation!}"
                                                                      : "  ",
                                                                  style: TextStyle(
                                                                    color: themeModel
                                                                            .isdark
                                                                            .value
                                                                        ? GlobalData
                                                                            .darkgray
                                                                        : GlobalData
                                                                            .fullblk,
                                                                  )),
                                                            ],
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                              box.read("pos") ==
                                                                      "right"
                                                                  ? "Qty : ${order!
                                                                          .orderData![
                                                                              index]
                                                                          .qty!}*${GlobalData.formatCurrency.format(double.parse(order!.orderData![index].price!)) + box.read("doller")}"
                                                                  : "Qty : ${order!
                                                                          .orderData![
                                                                              index]
                                                                          .qty!}*${box.read("doller") + GlobalData.formatCurrency.format(double.parse(order!.orderData![index].price!))}",
                                                              style:
                                                                  TextStyle(
                                                                fontSize:
                                                                    15.sp,
                                                                color: themeModel
                                                                        .isdark
                                                                        .value
                                                                    ? GlobalData
                                                                        .darkgray
                                                                    : GlobalData
                                                                        .fullblk,
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
                                                                    ? GlobalData.formatCurrency.format(double.parse(order!.orderData![index].price!)) +
                                                                        box.read(
                                                                            "doller")
                                                                    : box.read("doller") +
                                                                        GlobalData.formatCurrency.format(double.parse(order!
                                                                            .orderData![
                                                                                index]
                                                                            .price!)),
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        GlobalData
                                                                            .fontlistsemibold,
                                                                    fontSize:
                                                                        16.sp)),
                                                          ),
                                                          if (order!
                                                                  .orderData![
                                                                      index]
                                                                  .status ==
                                                              "5") ...{
                                                            Text(
                                                              "item_Cancelled".tr,
                                                              style: TextStyle(
                                                                  color: themeModel
                                                                          .isdark
                                                                          .value
                                                                      ? GlobalData
                                                                          .red
                                                                      : GlobalData
                                                                          .fullwhite,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontFamily:
                                                                      GlobalData
                                                                          .fontlistregular),
                                                            )
                                                          } else if (order!
                                                                  .orderData![
                                                                      index]
                                                                  .status ==
                                                              "7") ...{
                                                            Text(
                                                              "ReturnRequest".tr,
                                                              style: TextStyle(
                                                                  color: themeModel
                                                                          .isdark
                                                                          .value
                                                                      ? GlobalData
                                                                          .red
                                                                      : GlobalData
                                                                          .fullwhite,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontFamily:
                                                                      GlobalData
                                                                          .fontlistregular),
                                                            )
                                                          }
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
                                              horizontal: 12, vertical: 7),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                                .isdark.value
                                                            ? GlobalData
                                                                .darkgray
                                                            : GlobalData
                                                                .fullwhite,
                                                        fontSize: 15.sp,
                                                        fontFamily: GlobalData
                                                            .fontlistregular),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                        box.read("pos") ==
                                                                "right"
                                                            ? GlobalData.formatCurrency.format(double.parse(order!.orderData![index].shippingCost!)) + box.read("doller")
                                                            : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(order!.orderData![index].shippingCost!))}",
                                                        style: TextStyle(
                                                            fontFamily: GlobalData
                                                                .fontlistmedium,
                                                            fontSize: 15.sp)),
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
                                                                .isdark.value
                                                            ? GlobalData
                                                                .darkgray
                                                            : GlobalData
                                                                .fullwhite,
                                                        fontSize: 15.sp,
                                                        fontFamily: GlobalData
                                                            .fontlistregular),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                        box.read("pos") ==
                                                                "right"
                                                            ? GlobalData.formatCurrency.format(double.parse(order!.orderData![index].tax!)) + box.read("doller")
                                                            : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(order!.orderData![index].tax!))}",
                                                        style: TextStyle(
                                                            fontFamily: GlobalData
                                                                .fontlistmedium,
                                                            fontSize: 15.sp)),
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
                                                                .isdark.value
                                                            ? GlobalData
                                                                .darkgray
                                                            : GlobalData
                                                                .fullwhite,
                                                        fontSize: 15.sp,
                                                        fontFamily: GlobalData
                                                            .fontlistregular),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                        box.read("pos") ==
                                                                "right"
                                                            ? GlobalData.formatCurrency.format(double.parse(order!.orderData![index].total!.toString())) + box.read("doller")
                                                            : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(order!.orderData![index].total!.toString()))}",
                                                        style: TextStyle(
                                                            fontFamily: GlobalData
                                                                .fontlistmedium,
                                                            fontSize: 15.sp)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Divider(height: 0.5, color: GlobalData.darkgray),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "Billing_Shiping_address".tr,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: GlobalData.fontlistsemibold),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            height: 18.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: GlobalRadious.border,
                                borderRadius: GlobalRadious.radious_,
                                color: GlobalData.whitecolor),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order!.orderInfo!.fullName!,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: themeModel.isdark.value
                                            ? GlobalData.fullblk
                                            : GlobalData.fullblk,
                                        fontFamily: GlobalData.fontlistregular),
                                  ),
                                  Text(
                                    "${order!.orderInfo!.pincode!} ${order!.orderInfo!.streetAddress!} ${order!.orderInfo!.landmark!}",
                                    overflow: TextOverflow.clip,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: themeModel.isdark.value
                                            ? GlobalData.darkgray
                                            : GlobalData.fullblk,
                                        fontFamily: GlobalData.fontlistregular),
                                  ),
                                  Text(
                                    order!.orderInfo!.mobile!,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: themeModel.isdark.value
                                            ? GlobalData.darkgray
                                            : GlobalData.fullblk,
                                        fontFamily: GlobalData.fontlistregular),
                                  ),
                                  Text(
                                    order!.orderInfo!.email!,
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        color: themeModel.isdark.value
                                            ? GlobalData.darkgray
                                            : GlobalData.fullblk,
                                        fontFamily: GlobalData.fontlistregular),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 1.5.h),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal".tr,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: GlobalData.darkgray,
                                    fontFamily: GlobalData.fontlistmedium),
                              ),
                              Text(
                                box.read("pos") == "right"
                                    ? GlobalData.formatCurrency.format(double.parse(order!.orderInfo!.subtotal!.toString())) + box.read("doller")
                                    : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(order!.orderInfo!.subtotal!))}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: GlobalData.darkgray,
                                    fontFamily: GlobalData.fontlistmedium),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tax".tr,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: GlobalData.darkgray,
                                    fontFamily: GlobalData.fontlistmedium),
                              ),
                              Text(
                                box.read("pos") == "right"
                                    ? GlobalData.formatCurrency.format(double.parse(order!.orderInfo!.tax!.toString())) + box.read("doller")
                                    : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(order!.orderInfo!.tax!))}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: GlobalData.darkgray,
                                    fontFamily: GlobalData.fontlistmedium),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shipping".tr,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: GlobalData.darkgray,
                                    fontFamily: GlobalData.fontlistmedium),
                              ),
                              Text(
                                box.read("pos") == "right"
                                    ? GlobalData.formatCurrency.format(double.parse(order!.orderInfo!.shippingCost!.toString())) + box.read("doller")
                                    : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(order!.orderInfo!.shippingCost!))}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: GlobalData.darkgray,
                                    fontFamily: GlobalData.fontlistmedium),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount".tr,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: GlobalData.darkgray,
                                    fontFamily: GlobalData.fontlistmedium),
                              ),
                              Text(
                                box.read("pos") == "right"
                                    ? GlobalData.formatCurrency.format(double.parse(order!.orderInfo!.discountAmount!.toString())) + box.read("doller")
                                    : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(order!.orderInfo!.discountAmount!))}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: GlobalData.darkgray,
                                    fontFamily: GlobalData.fontlistmedium),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Divider(height: 0.5, color: GlobalData.darkgray),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand_Total".tr,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: GlobalData.fontlistmedium),
                              ),
                              Text(
                                box.read("pos") == "right"
                                    ? GlobalData.formatCurrency.format(double.parse(order!.orderInfo!.grandTotal!.toString())) + box.read("doller")
                                    : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(order!.orderInfo!.grandTotal!.toString()))}",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: GlobalData.fontlistsemibold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (order!.orderInfo!.orderNotes != null) ...{
                                Text(
                                  "Note".tr,
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontFamily: GlobalData.fontlistsemibold),
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: GlobalRadious.radious_,
                                      border: GlobalRadious.border,
                                      color: GlobalData.whitecolor),
                                  margin: EdgeInsets.only(top: 1.5.h),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text(
                                      order!.orderInfo!.orderNotes!,
                                      overflow: TextOverflow.clip,
                                      maxLines: 5,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily:
                                              GlobalData.fontlistregular),
                                    ),
                                  ),
                                ),
                              }
                            ],
                          )
                        ],
                      ),
                    );
                  }
                  return Center(
                    child:
                        CircularProgressIndicator(color: GlobalData.bluebtn),
                  );
                },
              )),
        );
      },
    );
  }
}

