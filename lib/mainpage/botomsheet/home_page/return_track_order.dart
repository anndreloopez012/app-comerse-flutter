import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/cman_widget_product.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../api/track_order_model.dart';

// ignore: must_be_immutable
class ReaturnTrackOrder extends StatefulWidget {
  String? orderid;

  ReaturnTrackOrder(this.orderid, {super.key});

  @override
  State<ReaturnTrackOrder> createState() => _ReaturnTrackOrderState();
}

class _ReaturnTrackOrderState extends State<ReaturnTrackOrder> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  track_model? track;
  GetStorage box = GetStorage();

  Future ordertrackapi() async {
    try {
      var map = {"user_id": box.read('user_id'), "order_id": widget.orderid!};

      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlordertrack, data: map);

      track = track_model.fromJson(response.data);

      return track;
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
            title: Text("TrackOrder".tr),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
          ),
          body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: FutureBuilder(
                future: ordertrackapi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 13.h,
                          width: double.infinity,
                          color: GlobalData.whitecolor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 20.w,
                                height: 10.h,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(2)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            track!.orderInfo!.imageUrl!),
                                        fit: BoxFit.fill)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        track!.orderInfo!.productName!,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily:
                                              GlobalData.fontlistsemibold,
                                        ),
                                      ),
                                      Text(
                                        track!.orderInfo!.variation != null
                                            ? "Size : ${track!.orderInfo!.variation!}"
                                            : " -",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily:
                                              GlobalData.fontlistregular,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              box.read("pos") == "right"
                                                  ? "qty : ${track!.orderInfo!.qty!}"
                                                  : "qty : ${track!.orderInfo!.qty!}",
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: themeModel.isdark.value
                                                    ? GlobalData.fullblk
                                                    : GlobalData.fullwhite,
                                              )),
                                          const Spacer(),
                                          Text(
                                              box.read("pos") == "right"
                                                  ? GlobalData.formatCurrency
                                                          .format(double.parse(
                                                              track!
                                                                  .orderInfo!
                                                                  .price!)) +
                                                      box.read("doller")
                                                  : box.read("doller") +
                                                      GlobalData.formatCurrency
                                                          .format(double.parse(
                                                              track!
                                                                  .orderInfo!
                                                                  .price!)),
                                              style: TextStyle(
                                                  fontFamily: GlobalData.fontlistsemibold,
                                                  fontSize: 16.sp)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Return Order id #${track!.orderInfo!.returnNumber!}",
                                  style: TextStyle(
                                      fontFamily: GlobalData.fontlistmedium,
                                      fontSize: 16.sp)),
                              SizedBox(height: 1.5.h),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      track!.orderInfo!.status == "7" ||
                                              track!.orderInfo!.status == "8" ||
                                              track!.orderInfo!.status == "9" ||
                                              track!.orderInfo!.status == "10"
                                          ? Container(
                                              height: 22,
                                              width: 22,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: GlobalData.green),
                                            )
                                          : Container(
                                              height: 22,
                                              width: 22,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border:
                                                      GlobalRadious.border),
                                            ),
                                      Container(
                                        margin: EdgeInsets.only(left: 0.5.w),
                                        color: track!.orderInfo!.status ==
                                                    "8" ||
                                                track!.orderInfo!.status ==
                                                    "9" ||
                                                track!.orderInfo!.status == "10"
                                            ? GlobalData.green
                                            : GlobalData.darkgray,
                                        height: 8.h,
                                        width: 2,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("ReturnRequest_Created".tr,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily:
                                                GlobalData.fontlistsemibold,
                                          )),
                                      Text("We_have_received_your_Order".tr,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              color: themeModel.isdark.value
                                                  ? GlobalData.darkgray
                                                  : GlobalData.fullwhite)),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                      track!.orderInfo!.status == "7" ||
                                              track!.orderInfo!.status == "8" ||
                                              track!.orderInfo!.status == "9" ||
                                              track!.orderInfo!.status == "10"
                                          ? track!.orderInfo!.createdAtt != null
                                              ? "${formateddate(track!.orderInfo!.createdAtt!)}"
                                              : ""
                                          : "",
                                      style: TextStyle(
                                          fontSize: 13.5.sp,
                                          fontFamily:
                                              GlobalData.fontlistregular,
                                          color: themeModel.isdark.value
                                              ? GlobalData.darkgray
                                              : GlobalData.fullwhite)),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      track!.orderInfo!.status == "8" ||
                                              track!.orderInfo!.status == "9" ||
                                              track!.orderInfo!.status == "10"
                                          ? Container(
                                              height: 22,
                                              width: 22,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: GlobalData.green),
                                            )
                                          : Container(
                                              height: 22,
                                              width: 22,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border:
                                                      GlobalRadious.border),
                                            ),
                                      Container(
                                        margin: EdgeInsets.only(left: 0.5.w),
                                        color: track!.orderInfo!.status == "9"
                                            ? GlobalData.green
                                            : GlobalData.darkgray,
                                        height: 8.h,
                                        width: 2,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          track!.orderInfo!.status == "10"
                                              ? "Order_Return_Rejected".tr
                                              : "Order_Return_accepted ".tr,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color:
                                                track!.orderInfo!.status == "10"
                                                    ? GlobalData.red
                                                    : GlobalData.fullblk,
                                            fontFamily:
                                                GlobalData.fontlistsemibold,
                                          )),
                                      Text("your_order_has_been_accepted".tr,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              color: themeModel.isdark.value
                                                  ? GlobalData.darkgray
                                                  : GlobalData.fullwhite)),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                      track!.orderInfo!.status == "8" ||
                                              track!.orderInfo!.status == "9" ||
                                              track!.orderInfo!.status == "10"
                                          ? track!.orderInfo!.confirmedAtt !=
                                                  null
                                              ? "${formateddate(track!.orderInfo!.confirmedAtt!)}"
                                              : ""
                                          : "",
                                      style: TextStyle(
                                          fontSize: 13.5.sp,
                                          fontFamily:
                                              GlobalData.fontlistregular,
                                          color: themeModel.isdark.value
                                              ? GlobalData.darkgray
                                              : GlobalData.fullwhite)),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      track!.orderInfo!.status == "9"
                                          ? Container(
                                              height: 22,
                                              width: 22,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: GlobalData.green),
                                            )
                                          : Container(
                                              height: 22,
                                              width: 22,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border:
                                                      GlobalRadious.border),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Order_Return_Completed".tr,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily:
                                                GlobalData.fontlistsemibold,
                                          )),
                                      Text("Your_package_off_for_completed".tr,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              color: themeModel.isdark.value
                                                  ? GlobalData.darkgray
                                                  : GlobalData.fullwhite)),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                      track!.orderInfo!.status == "9"
                                          ? track!.orderInfo!.deliveredAtt !=
                                                  null
                                              ? "${formateddate(track!.orderInfo!.deliveredAtt!)}"
                                              : ""
                                          : "",
                                      style: TextStyle(
                                          fontSize: 13.5.sp,
                                          fontFamily:
                                              GlobalData.fontlistregular,
                                          color: themeModel.isdark.value
                                              ? GlobalData.darkgray
                                              : GlobalData.fullwhite)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return bulidcircu();
                },
              )),
        );
      },
    );
  }
}
