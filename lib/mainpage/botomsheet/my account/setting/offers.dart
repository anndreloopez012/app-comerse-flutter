import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/widget_image.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' as store;
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../api/all_model/offer_model.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  store.GetStorage box = store.GetStorage();
  coupen_code_model? cpn;
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

  Future<bool> viewallapi({isRefresh = false}) async {
    Loader.showLoading();
    try {
      if (isRefresh) {
        currentPage = 1;
      } else {
        if (too == totalPages) {
          Loader.hideLoading();
          refreshController.loadNoData();
          return false;
        }
      }

      var response = await Dio().get(
        "${default_API.baseUrl + post_api.urlcoupencode}?page=$currentPage",
      );
      Loader.hideLoading();
      if (response.statusCode == 200) {
        var result = await response.data;
        cpn = coupen_code_model.fromJson(result);
        if (isRefresh) {
          passengers = cpn!.data!.data!;
        } else {
          passengers.addAll(cpn!.data!.data!);
        }
        currentPage++;
      
        totalPages = cpn!.data!.total!;
        too = cpn!.data!.to!;
        
        setState(() {
          mss = true;
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
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
            leadingWidth: 6.h,
            primary: true,
            automaticallyImplyLeading: false,
            title: Text("Offers".tr),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
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
                  if (mode == RefreshStatus.refreshing) {
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
              child: passengers.isNotEmpty
                  ? SizedBox(
                      child: ListView.builder(
                        itemCount: passengers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 1.5.h),
                            height: 16.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: GlobalRadious.border,
                                color: themeModel.isdark.value
                                    ? const Color(0xfffdf7ff)
                                    : Colors.grey,
                                borderRadius: GlobalRadious.radious_),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 0, top: 8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xff263238),
                                            borderRadius:
                                                GlobalRadious.radious_),
                                        height: 8.h,
                                        width: 18.w,
                                        child: Center(
                                            child: Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: buildSvgimage(
                                                    lightclr:
                                                        GlobalData.whitecolor,
                                                    widt: 50,
                                                    imgnem: icon_global
                                                        .icdiscount))),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 8, right: 8, top: 3.h),
                                          child: Text(
                                            box.read("pos") == "right"
                                                ? "Minimum amount for this offer ${GlobalData.formatCurrency.format(double.parse(passengers[index].minAmount!)) + box.read("doller")}"
                                                : "Minimum amount for this offer ${box.read("doller") + GlobalData.formatCurrency.format(double.parse(passengers[index].minAmount!))}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              fontSize: 14.sp,
                                              color: themeModel.isdark.value
                                                  ? GlobalData.darkgray
                                                  : GlobalData.fullwhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(children: [
                                      Text(
                                        formateddatelist(
                                            passengers[index].endDate),
                                        style: TextStyle(
                                          fontFamily:
                                              GlobalData.fontlistsemibold,
                                          fontSize: 14.sp,
                                          color: themeModel.isdark.value
                                              ? GlobalData.ofblack
                                              : GlobalData.fullwhite,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: GlobalData.bluebtn,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(4))),
                                        height: 4.h,
                                        width: 24.w,
                                        child: Center(
                                            child: Text(
                                          passengers[index].couponName!,
                                          style: TextStyle(
                                              color: GlobalData.whitecolor),
                                        )),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : passengers.isEmpty
                      ? const Center(child: Text(""))
                      : const Center(child: Text("No data")),
            ),
          ),
        );
      },
    );
  }
}

/*
 */

/*

 */
