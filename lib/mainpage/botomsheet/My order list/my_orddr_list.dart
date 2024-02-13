import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as store;
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../api/all_model/order_list_model.dart';
import '../../../api/all_model/success_or_not.dart';
import '../../../coman_widget/widget_image.dart';
import 'order_details.dart';

class MyOrderList extends StatefulWidget {
  const MyOrderList({Key? key}) : super(key: key);

  @override
  State<MyOrderList> createState() => _MyOrderListState();
}

class _MyOrderListState extends State<MyOrderList> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  store.GetStorage box = store.GetStorage();
  order_list_model? view;
  late int totalPages;
  late int totalPa;
  late int too;
  late int tos;
  List<Datasub> passengers = [];
  bool isRefresh = false;
  bool mss = false;
  int type = 0;
  success_or_no_model? favorite;
  int currentPage = 1;
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  Future<bool> viewallapi({isRefresh = false}) async {
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
        "${default_API.baseUrl + post_api.urlorderlist}?page=$currentPage",
        data: map);
    Loader.hideLoading();
    if (response.statusCode == 200) {
      var result = await response.data;
      view = order_list_model.fromJson(result);
      if (isRefresh) {
        passengers = view!.data!.data!;
      } else {
        passengers.addAll(view!.data!.data!);
      }
      currentPage++;
     
      totalPages = view!.data!.total!;
      too = view!.data!.to!;
      setState(() {
        mss = true;
      });
      return true;
    } else {
      Loader.hideLoading();
      Loader.showErroDialog(description: "No Data Found");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 6.h,
            primary: true,
            automaticallyImplyLeading: false,
            title: Text("MyOrderList".tr),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: SmartRefresher(
                controller: refreshController,
                primary: true,
                header: CustomHeader(
                  builder: (context, mode) {
                    if (mode == LoadStatus.loading) {
                      const Center(
                        child: Center(),
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
                  final result = await viewallapi(isRefresh: true);
                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  final result = await viewallapi();
                  if (result) {
                    refreshController.loadComplete();
                  } else {
                    refreshController.loadNoData();
                  }
                },
                child: passengers.isEmpty || view!.data!.data!.isEmpty
                    ? buildNodat(imge: icon_global.icnodata)
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: GlobalData.fullblk,
                            height: 0.5,
                          );
                        },
                        itemCount: passengers.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return OrderDetailsPage(
                                      passengers[index].orderNumber!);
                                },
                              ));
                            },
                            child: Container(
                              height: 10.h,
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
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
                                          "Order Id : ${passengers[index].orderNumber}",
                                          style: TextStyle(
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              fontSize: 17.sp),
                                        ),
                                        Text(
                                          formateddatelist(
                                              passengers[index].date!),
                                          style: TextStyle(
                                            fontFamily:
                                                GlobalData.fontlistmedium,
                                            fontSize: 15.sp,
                                            color: themeModel.isdark.value
                                                ? GlobalData.darkgray
                                                : GlobalData.fullblk,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          passengers[index].paymentType == "1"
                                              ? "Payment Type : Cash"
                                              : passengers[index].paymentType ==
                                                      "2"
                                                  ? "Payment Type : wallet"
                                                  : passengers[index]
                                                              .paymentType ==
                                                          "3"
                                                      ? "Payment Type : RazorPay"
                                                      : passengers[index]
                                                                  .paymentType ==
                                                              "4"
                                                          ? "Payment Type : Stripe"
                                                          : passengers[index]
                                                                      .paymentType ==
                                                                  "5"
                                                              ? "Payment Type : Flutterwave"
                                                              : passengers[index]
                                                                          .paymentType ==
                                                                      "6"
                                                                  ? "Payment Type : Paystack"
                                                                  : "Payment Type : ",
                                          style: TextStyle(
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              fontSize: 17.sp),
                                        ),
                                        Text(
                                            box.read("pos") == "right"
                                                ? GlobalData.formatCurrency.format(double.parse(passengers[index].grandTotal!)) + box.read("doller")
                                                : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(passengers[index].grandTotal!))}",
                                            style: TextStyle(
                                                fontFamily:
                                                    GlobalData.fontlistsemibold,
                                                fontSize: 16.sp)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              )),
        );
      },
    );
  }
}

