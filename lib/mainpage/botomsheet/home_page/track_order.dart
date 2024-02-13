import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/cman_widget_product.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/wirteeview.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../api/track_order_model.dart';

// ignore: must_be_immutable
class TrackOrder extends StatefulWidget {
  String? orderid;

  TrackOrder(this.orderid, {super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  track_model? track;
  GetStorage box = GetStorage();

  Future ordertrackapi() async {
    try {
      var map = {
        "user_id": box.read('user_id'),
        "order_id": widget.orderid!
      };

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
                        SizedBox(height: 2.5.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    track!.orderInfo!.status == "1" ||
                                        track!.orderInfo!.status == "2" ||
                                        track!.orderInfo!.status == "3" ||
                                        track!.orderInfo!.status == "4"
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
                                          border: GlobalRadious.border),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 0.5.w),
                                      color:track!.orderInfo!.status == "2" ||
                                          track!.orderInfo!.status == "3" ||
                                          track!.orderInfo!.status == "4"? GlobalData.green:GlobalData.darkgray,
                                      height: 8.h,
                                      width: 2,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Order_Placed".tr,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: GlobalData.fontlistsemibold,
                                        )),
                                    Text("We_have_received_Order".tr,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontFamily: GlobalData.fontlistregular,
                                            color: themeModel.isdark.value
                                                ? GlobalData.darkgray
                                                : GlobalData.fullwhite)),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                    track!.orderInfo!.createdAtt != null
                                        ? "${formateddate(track!.orderInfo!.createdAtt!)}"
                                        : "",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: GlobalData.fontlistregular,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    track!.orderInfo!.status == "2" ||
                                        track!.orderInfo!.status == "3" ||
                                        track!.orderInfo!.status == "4"
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
                                          border: GlobalRadious.border),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 0.5.w),
                                      color: track!.orderInfo!.status == "3" ||
                                          track!.orderInfo!.status == "4"? GlobalData.green:GlobalData.darkgray,
                                      height: 8.h,
                                      width: 2,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Confirmed".tr,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: GlobalData.fontlistsemibold,
                                        )),
                                    Text("your_order_has_been_confirmed".tr,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontFamily: GlobalData.fontlistregular,
                                            color: themeModel.isdark.value
                                                ? GlobalData.darkgray
                                                : GlobalData.fullwhite)),
                                  ],
                                ),
                                Text(
                                    track!.orderInfo!.confirmedAtt != null
                                        ? "${formateddate(track!.orderInfo!.confirmedAtt!)}"
                                        : "",
                                    style: TextStyle(
                                        fontSize: 13.8.sp,
                                        fontFamily: GlobalData.fontlistregular,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    track!.orderInfo!.status == "3" ||
                                        track!.orderInfo!.status == "4"||
                                        track!.orderInfo!.status == "7"||  track!.orderInfo!.status == "10"
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
                                          border: GlobalRadious.border),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 0.5.w),
                                      color:  track!.orderInfo!.status == "4"? GlobalData.green:GlobalData.darkgray,
                                      height: 8.h,
                                      width: 2,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Order_Shipped".tr,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: GlobalData.fontlistsemibold,
                                        )),
                                    Text("Your_package_off_delivery".tr,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontFamily: GlobalData.fontlistregular,
                                            color: themeModel.isdark.value
                                                ? GlobalData.darkgray
                                                : GlobalData.fullwhite)),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                    track!.orderInfo!.shippedAtt != null
                                        ? "${formateddate(track!.orderInfo!.shippedAtt!)}"
                                        : "",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: GlobalData.fontlistregular,
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    track!.orderInfo!.status == "4"||
                                        track!.orderInfo!.status == "7"||
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
                                          border: GlobalRadious.border),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Delivered".tr,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: GlobalData.fontlistsemibold,
                                        )),
                                    Text("Your_order_has_been_delivered".tr,
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontFamily: GlobalData.fontlistregular,
                                            color: themeModel.isdark.value
                                                ? GlobalData.darkgray
                                                : GlobalData.fullwhite)),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                    track!.orderInfo!.deliveredAtt != null
                                        ? "${formateddate(track!.orderInfo!.deliveredAtt!)}"
                                        : "",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: GlobalData.fontlistregular,
                                        color: themeModel.isdark.value
                                            ? GlobalData.darkgray
                                            : GlobalData.fullwhite)),
                              ],
                            ),
                          ],),
                        ),
                        const Spacer(),
                       if(
                       track!.orderInfo!.status=="4"||
                       track!.orderInfo!.status=="7"||
                       track!.orderInfo!.status=="8"||
                       track!.orderInfo!.status=="9"
                       )...
                         {
                           GestureDetector(
                             onTap: () {
                               Get.to(WriteReview(
                                 track!.orderInfo!.imageUrl!,
                                 track!.orderInfo!.productName!,
                                 track!.orderInfo!.vendorId!,
                                 track!.orderInfo!.productId!,
                               ));
                             },
                             child: Container(
                               color: GlobalData.bluebtn,
                               height: 7.h,
                               width: double.infinity,
                               child: Center(child: Text("Add_Rating_and_Review".tr,style: TextStyle(color:
                               GlobalData.fullwhite,fontFamily: GlobalData.fontlistsemibold,fontSize: 16.sp),)),
                             ),
                           ),
                         }
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
