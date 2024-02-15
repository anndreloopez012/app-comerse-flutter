import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/widget_image.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../api/all_model/rating_review_model.dart';
import '../../../coman_widget/cman_widget_product.dart';

// ignore: must_be_immutable, camel_case_types
class retingreviews extends StatefulWidget {
  String? productid;

  retingreviews(this.productid, {super.key});

  @override
  State<retingreviews> createState() => _retingreviewsState();
}

// ignore: camel_case_types
class _retingreviewsState extends State<retingreviews> {
  late int too;
  int currentPage = 0;

  late int totalPages;
  List<Data> passengers = [];
  bool? isRefresh;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  ThemeModel themeModel = Get.find<ThemeModel>();
  double? ave;
  int? aved;
  int? creting;

  Rating_reviews_model? rate;

  Future ratingreviewsapi() async {
    try {
      var map = {"product_id": widget.productid};
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlratingreviews, data: map);

      rate = Rating_reviews_model.fromJson(response.data);
      ave = double.parse(rate!.reviews!.avgRatting!).roundToDouble();
      aved = double.parse(rate!.reviews!.avgRatting!).toInt();

      return rate;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  Future<bool> getPassengerData({bool isRefresh = false}) async {
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

    var map = {"product_id": widget.productid};
    var response = await Dio()
        .post(default_API.baseUrl + post_api.urlratingreviews, data: map);

    if (response.statusCode == 200) {
      Loader.hideLoading();
      rate = Rating_reviews_model.fromJson(response.data);
      ave = double.parse(rate!.reviews!.avgRatting!).roundToDouble();
      aved = double.parse(rate!.reviews!.avgRatting!).toInt();

      if (isRefresh) {
        passengers = rate!.allReview!.data!;
      } else {
        passengers.addAll(rate!.allReview!.data!);
        aved = double.parse(rate!.reviews!.avgRatting!).toInt();
      }
      currentPage++;
      totalPages = rate!.allReview!.total!;
      too = rate!.allReview!.to!;
      setState(() {});
      return true;
    } else {
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
            title: Text("Ratting_Reviews".tr),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: FutureBuilder(
                future: ratingreviewsapi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return rate!.reviews!.total != 0
                        ? Column(
                            children: [
                              Card(
                                elevation: 5,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 24.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                          child: SizedBox(
                                            height: 25.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    ave == 1.0
                                                        ? "${rate!.reviews!.avgRatting!}/ 1"
                                                        : ave == 2.0
                                                            ? "${rate!.reviews!.avgRatting!}/ 2"
                                                            : ave == 3.0
                                                                ? "${rate!.reviews!.avgRatting!}/ 3"
                                                                : ave == 4.0
                                                                    ? "${rate!.reviews!.avgRatting!}/ 4"
                                                                    : ave == 5.0
                                                                        ? "${rate!.reviews!.avgRatting!}/ 5"
                                                                        : "",
                                                    style: TextStyle(
                                                        fontFamily: GlobalData
                                                            .fontlistmedium,
                                                        fontSize: 28.sp)),
                                                Image(
                                                  image: AssetImage(
                                                    aved == 1
                                                        ? icon_global
                                                            .icrating1
                                                        : aved == 2
                                                            ? icon_global
                                                                .icrating2
                                                            : aved == 3
                                                                ? icon_global
                                                                    .icrating3
                                                                : aved == 4
                                                                    ? icon_global
                                                                        .icrating4
                                                                    : aved == 5
                                                                        ? icon_global
                                                                            .icrating5
                                                                        : icon_global
                                                                            .icrating0,
                                                  ),
                                                  color: GlobalData.orange,
                                                  width: 40.w,
                                                ),
                                                Text(
                                                    "Based on ${rate!.reviews!.total!} Ratings & Reviews",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: GlobalData
                                                            .fontlistmedium,
                                                        fontSize: 16.sp)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                          color: GlobalData.whitecolor),
                                      Expanded(
                                        flex: 2,
                                        child: SizedBox(
                                          height: 18.h,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("5",
                                                      style: TextStyle(
                                                          fontSize: 16.sp)),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  const Image(
                                                    image: AssetImage(
                                                        icon_global
                                                            .icfillstar),
                                                    width: 16,
                                                  ),
                                                  LinearPercentIndicator(
                                                    width: 26.w,
                                                    lineHeight: 5.0,
                                                    percent: rate!.reviews!
                                                            .fiveRatting! /
                                                        rate!.reviews!.total!,
                                                    progressColor:
                                                        GlobalData.bluebtn,
                                                    // backgroundColor: GlobalData.,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("4",
                                                      style: TextStyle(
                                                          fontSize: 16.sp)),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  const Image(
                                                    image: AssetImage(
                                                        icon_global
                                                            .icfillstar),
                                                    width: 16,
                                                  ),
                                                  LinearPercentIndicator(
                                                    width: 26.w,
                                                    lineHeight: 5.0,
                                                    percent: rate!.reviews!
                                                            .fourRatting! /
                                                        rate!.reviews!.total!,
                                                    progressColor:
                                                        GlobalData.bluebtn,
                                                    // backgroundColor: GlobalData.,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("3",
                                                      style: TextStyle(
                                                          fontSize: 16.sp)),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  const Image(
                                                    image: AssetImage(
                                                        icon_global
                                                            .icfillstar),
                                                    width: 16,
                                                  ),
                                                  LinearPercentIndicator(
                                                    width: 26.w,
                                                    lineHeight: 5.0,
                                                    percent: rate!.reviews!
                                                            .threeRatting! /
                                                        rate!.reviews!.total!,
                                                    progressColor:
                                                        GlobalData.bluebtn,
                                                    // backgroundColor: GlobalData.,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("2",
                                                      style: TextStyle(
                                                          fontSize: 16.sp)),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  const Image(
                                                    image: AssetImage(
                                                        icon_global
                                                            .icfillstar),
                                                    width: 16,
                                                  ),
                                                  LinearPercentIndicator(
                                                    width: 26.w,
                                                    lineHeight: 5.0,
                                                    percent: rate!.reviews!
                                                            .twoRatting! /
                                                        rate!.reviews!.total!,
                                                    progressColor:
                                                        GlobalData.bluebtn,
                                                    // backgroundColor: GlobalData.,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("1",
                                                      style: TextStyle(
                                                          fontSize: 16.sp)),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  const Image(
                                                    image: AssetImage(
                                                        icon_global
                                                            .icfillstar),
                                                    width: 16,
                                                  ),
                                                  LinearPercentIndicator(
                                                    width: 26.w,
                                                    lineHeight: 5.0,
                                                    percent: rate!.reviews!
                                                            .oneRatting! /
                                                        rate!.reviews!.total!,
                                                    progressColor:
                                                        GlobalData.bluebtn,
                                                    // backgroundColor: GlobalData.,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  height: 62.h,
                                  margin: const EdgeInsets.only(top: 10),
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
                                      enablePullUp: true,
                                      footer: CustomFooter(
                                        builder: (context, mode) {
                                          Widget body;
                                          if (mode == LoadStatus.loading) {
                                            body = const Center(child: Center());
                                          } else {
                                            body = const Text("");
                                          }
                                          return SizedBox(
                                            height: 0,
                                            child: SizedBox(child: body),
                                          );
                                        },
                                      ),
                                      onRefresh: () async {
                                        final result = await getPassengerData(
                                            isRefresh: true);
                                        if (result) {
                                          refreshController.refreshCompleted();
                                        } else {
                                          refreshController.refreshFailed();
                                        }
                                      },
                                      onLoading: () async {
                                        final result = await getPassengerData();
                                        if (result) {
                                          refreshController.loadComplete();
                                        } else {
                                          refreshController.loadFailed();
                                        }
                                      },
                                      child: passengers.isNotEmpty ||
                                              rate!.allReview!.data!.isNotEmpty
                                          ? ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return Divider(
                                                  thickness: 0.5,
                                                  color: GlobalData.darkgray,
                                                );
                                              },
                                              itemCount: passengers.length,
                                              itemBuilder: (context, index) {
                                                final passenger =
                                                    passengers[index];
                                                creting = double.parse(
                                                        passenger.ratting!)
                                                    .toInt();
                                                return Container(
                                                  height: 12.h,
                                                  width: double.infinity,
                                                  margin: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.5,
                                                          color: GlobalData
                                                              .whitecolor),
                                                      color: themeModel
                                                              .isdark.value
                                                          ? GlobalData.fullwhite
                                                          : GlobalData.fullblk,
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 18.w,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    passenger
                                                                        .users!
                                                                        .imageUrl!),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 4),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin: const EdgeInsets
                                                                    .only(
                                                                        left: 0,
                                                                        right:
                                                                            0,
                                                                        top: 0),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      passenger
                                                                          .users!
                                                                          .name!,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            17.sp,
                                                                        fontFamily:
                                                                            GlobalData.fontlistsemibold,
                                                                        color: themeModel.isdark.value
                                                                            ? GlobalData.fullblk
                                                                            : GlobalData.fullwhite,
                                                                      ),
                                                                    ),
                                                                    const Spacer(),
                                                                    Text(
                                                                      formateddatelist(
                                                                          passenger
                                                                              .date!),
                                                                      style: TextStyle(
                                                                          color: themeModel.isdark.value
                                                                              ? GlobalData
                                                                                  .fullblk
                                                                              : GlobalData
                                                                                  .fullwhite,
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontFamily:
                                                                              GlobalData.fontlistregular),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Image(
                                                                image:
                                                                    AssetImage(
                                                                  creting == 1
                                                                      ? icon_global
                                                                          .icrating1
                                                                      : creting ==
                                                                              2
                                                                          ? icon_global
                                                                              .icrating2
                                                                          : creting == 3
                                                                              ? icon_global.icrating3
                                                                              : creting == 4
                                                                                  ? icon_global.icrating4
                                                                                  : creting == 5
                                                                                      ? icon_global.icrating5
                                                                                      : icon_global.icrating0,
                                                                ),
                                                                color:
                                                                    GlobalData
                                                                        .orange,
                                                                width: 26.w,
                                                              ),
                                                              SizedBox(
                                                                  child: Text(
                                                                passenger
                                                                    .comment!,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontFamily:
                                                                      GlobalData
                                                                          .fontlistregular,
                                                                  color: themeModel
                                                                          .isdark
                                                                          .value
                                                                      ? GlobalData
                                                                          .darkgray
                                                                      : GlobalData
                                                                          .fullwhite,
                                                                ),
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                          : buildNodata(
                                              imge:
                                                  icon_global.icimgrarting)),
                                ),
                              ),
                            ],
                          )
                        : buildNodata(imge: icon_global.icimgrarting);
                  }
                  return bulidcircu();
                },
              )),
        );
      },
    );
  }
}
