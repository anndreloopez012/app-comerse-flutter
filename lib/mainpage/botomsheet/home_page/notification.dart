import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/notification_model.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/My%20order%20list/order_details.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/return_track_order.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/track_order.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' as store;
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../coman_widget/widget_image.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  store.GetStorage box = store.GetStorage();
  notification_model? noti;
  late int totalPages;
  late int totalPa;
  late int too;
  late int tos;
  List<Datasub> passengers = [];
  bool isRefresh = false;
  bool mss = false;
  int type = 0;
  int currentPage = 1;
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  Future<bool> notificationapi({isRefresh = false}) async {
    Loader.showLoading();
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (too == totalPages) {
        Loader.hideLoading();
        refreshController.loadNoData();
        return false;
      }
    }
    Map map = {"user_id": box.read('user_id')};
    var response = await Dio().post(
        "${default_API.baseUrl + post_api.urlnotification}?page=$currentPage",
        data: map);
    Loader.hideLoading();
    if (response.statusCode == 200) {
      var result = await response.data;
      noti = notification_model.fromJson(result);
      if (isRefresh) {
        passengers = noti!.data!.datasub!;
      } else {
        passengers.addAll(noti!.data!.datasub!);
      }
      currentPage++;
      totalPages = noti!.data!.total!;
      too = noti!.data!.to!;
      setState(() {
        mss = true;
      });
      return true;
    } else {
      Loader.hideLoading();

      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            primary: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            title: Text("Notifications".tr),
          ),
          body: Container(
            margin: const EdgeInsets.only(right: 12, left: 12),
            child: SmartRefresher(
            controller: refreshController,
            primary: true,
            header: CustomHeader(
              builder: (context, mode) {
                if (mode == RefreshStatus.refreshing) {
                  return Center(
                    child: CircularProgressIndicator(color: GlobalData.bluebtn),
                  );
                }
                return const Center();
                  },
                ),
                footer: CustomFooter(
                  builder: (context, mode) {
                    Widget body;
                    if (mode == LoadStatus.loading) {
                      body = const Center(child: Center());
                    } else {
                      body = const Text("");
                    }
                    return SizedBox(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                enablePullUp: true,
                enablePullDown: mss == false ? true : false,
                onRefresh: () async {
                  final result = await notificationapi(isRefresh: true);
                  
                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  final result = await notificationapi();
                 
                  if (result) {
                    refreshController.loadComplete();
                  } else {
                    refreshController.loadNoData();
                  }
                },
                child: passengers.isNotEmpty
                    ? ListView.builder(
                        itemCount: passengers.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (passengers[index].orderStatus == "7" ||
                                  passengers[index].orderStatus == "8" ||
                                  passengers[index].orderStatus == "9" ||
                                  passengers[index].orderStatus == "10") {
                                Get.to(() => ReaturnTrackOrder(
                                    passengers[index].orderId!));
                              } else if (passengers[index].orderStatus == "2" ||
                                  passengers[index].orderStatus == "3" ||
                                  passengers[index].orderStatus == "4") {
                                Get.to(() => TrackOrder(passengers[index].orderId!));
                              } else {
                                Get.to(() => OrderDetailsPage(
                                    passengers[index].orderNumber!));
                              }
                            },
                            child: Container(
                              height: 10.h,
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: GlobalData.whitecolor),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 16.w,
                                    height: 8.h,
                                    decoration: BoxDecoration(
                                      color: passengers[index].orderStatus ==
                                              "1"
                                          ? const Color(0xffffeb3b)
                                          : passengers[index].orderStatus == "2"
                                              ? const Color(0xff2291FF)
                                              : passengers[index].orderStatus ==
                                                      "3"
                                                  ? const Color(0xff44bedf)
                                                  : passengers[index]
                                                              .orderStatus ==
                                                          "4"
                                                      ? const Color(0xff34c759)
                                                      : passengers[index]
                                                                  .orderStatus ==
                                                              "5"
                                                          ? const Color(0xffff0000)
                                                          : passengers[index]
                                                                      .orderStatus ==
                                                                  "6"
                                                              ? const Color(
                                                                  0xffff0000)
                                                              : passengers[index]
                                                                          .orderStatus ==
                                                                      "7"
                                                                  ? const Color(
                                                                      0xffff9500)
                                                                  : passengers[index]
                                                                              .orderStatus ==
                                                                          "8"
                                                                      ? const Color(
                                                                          0xff34c759)
                                                                      : passengers[index].orderStatus ==
                                                                              "9"
                                                                          ? const Color(
                                                                              0xff44bedf)
                                                                          : passengers[index].orderStatus == '10'
                                                                              ? const Color(0xffff0000)
                                                                              : const Color(0xffffeb3b),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                        margin: const EdgeInsets.all(12),
                                        child: Image(
                                            image: AssetImage(
                                              passengers[index].orderStatus ==
                                                      "1"
                                                  ? icon_global.icorderplace
                                                  : passengers[index]
                                                              .orderStatus ==
                                                          "2"
                                                      ? icon_global
                                                          .icorderconfirmed
                                                      : passengers[index]
                                                                  .orderStatus ==
                                                              "3"
                                                          ? icon_global
                                                              .icdelivery
                                                          : passengers[index]
                                                                      .orderStatus ==
                                                                  "4"
                                                              ? icon_global
                                                                  .icorderdelivery
                                                              : passengers[index]
                                                                          .orderStatus ==
                                                                      "5"
                                                                  ? icon_global
                                                                      .icordercancelledpackage
                                                                  : passengers[index]
                                                                              .orderStatus ==
                                                                          "6"
                                                                      ? icon_global
                                                                          .icordercancelledpackage
                                                                      : passengers[index].orderStatus ==
                                                                              "7"
                                                                          ? icon_global
                                                                              .icorderreturn
                                                                          : passengers[index].orderStatus == "8"
                                                                              ? icon_global.icorderdelivery
                                                                              : passengers[index].orderStatus == "9"
                                                                                  ? icon_global.icdelivery
                                                                                  : passengers[index].orderStatus == '10'
                                                                                      ? icon_global.icordercancelledpackage
                                                                                      : icon_global.icorderplace,
                                            ),
                                            height: 17,
                                            width: 17,
                                            color: GlobalData.fullwhite)),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              passengers[index].orderStatus ==
                                                      "1"
                                                  ? "order place"
                                                  : passengers[index]
                                                              .orderStatus ==
                                                          "2"
                                                      ? "order confirmed"
                                                      : passengers[index]
                                                                  .orderStatus ==
                                                              "3"
                                                          ? "order shipped"
                                                          : passengers[index]
                                                                      .orderStatus ==
                                                                  "4"
                                                              ? "order delivered"
                                                              : passengers[index]
                                                                          .orderStatus ==
                                                                      "5"
                                                                  ? "order cancelled"
                                                                  : passengers[index]
                                                                              .orderStatus ==
                                                                          "6"
                                                                      ? "order cancelled"
                                                                      : passengers[index].orderStatus ==
                                                                              "7"
                                                                          ? "order return created"
                                                                          : passengers[index].orderStatus == "8"
                                                                              ? "order return accepted"
                                                                              : passengers[index].orderStatus == "9"
                                                                                  ? "order return completed"
                                                                                  : passengers[index].orderStatus == '10'
                                                                                      ? "order return rejected"
                                                                                      : "",
                                              overflow: TextOverflow.clip,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily:
                                                      GlobalData.fontlistmedium,
                                                  fontSize: 16.5.sp,
                                                  color: themeModel.isdark.value
                                                      ? GlobalData.fullblk
                                                      : GlobalData.fullwhite),
                                            ),
                                            Text(
                                              formateddatelist(
                                                  passengers[index].date),
                                              style: TextStyle(
                                                  fontFamily: GlobalData
                                                      .fontlistregular,
                                                  fontSize: 14.sp,
                                                  color: themeModel.isdark.value
                                                      ? GlobalData.ofwhite
                                                      : GlobalData.ofwhite),
                                            )
                                          ],
                                        ),
                                        Text(
                                          passengers[index].message!,
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              fontSize: 16.sp,
                                              color: themeModel.isdark.value
                                                  ? GlobalData.ofwhite
                                                  : GlobalData.ofwhite),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : buildNodat(imge: icon_global.icnodata)),
          ),
        );
      },
    );
  }
}
