import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/widget_image.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/products_details.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' as store;
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../api/all_model/vendors_produt_model.dart';
import 'about_vendo.dart';

// ignore: must_be_immutable
class VendorsPage extends StatefulWidget {
  int? type;
  String? id;
  String? name;
  String? imaage;

  // ignore: use_key_in_widget_constructors
  VendorsPage(this.type, [this.id, this.name, this.imaage]);

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  success_or_no_model? favorite;
  vendors_products_model? vendor;
  store.GetStorage box = store.GetStorage();
  late int totalPages;
  List<Datasub> passengers = [];
  bool? isRefresh;
  bool mss = false;
  late int totalPa;
  late int too;

  int currentPage = 0;
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  Future<bool> viewallapi({bool isRefresh = false}) async {
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
    Map map = {
      if (widget.type == 1) ...{
        "vendor_id": widget.id,
        "user_id": box.read('user_id')
      } else if (widget.type == 2) ...{
        "brand_id": widget.id,
        "user_id": box.read('user_id')
      }
    };

    var response = await Dio().post(
        widget.type == 1
            ? "${default_API.baseUrl + post_api.urlvendorsproduct}?page=$currentPage"
            : widget.type == 2
                ? "${default_API.baseUrl + post_api.urlbrandsproduct}?page=$currentPage"
                : "",
        data: map);

    if (response.statusCode == 200) {
      vendor = vendors_products_model.fromJson(response.data);
      if (vendor!.status == 0) {
        Loader.hideLoading();
        SizedBox(
          width: 50.w,
          height: 50.h,
          child: const Image(image: AssetImage(icon_global.icnodata)),
        );

        return false;
      }
      if (vendor!.status == 1) {
        Loader.hideLoading();
        if (isRefresh) {
          passengers = vendor!.data!.data!;
        } else {
          passengers.addAll(vendor!.data!.data!);
        }
        currentPage++;
        totalPages = vendor!.data!.total!;
        too = vendor!.data!.to!;

        setState(() {
          mss = true;
        });
        return true;
      } else {
        Loader.hideLoading();
        Loader.showErroDialog(description: 'Something_went_wrong'.tr);
        return true;
      }
    } else {
      return false;
    }
  }

  Future like(int index) async {
    try {
      var map = {
        "product_id": passengers[index].id,
        "user_id": box.read('user_id')
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlmakfavorite, data: map);

      var finallist = await response.data;
      favorite = success_or_no_model.fromJson(finallist);

      setState(() {
        viewallapi(isRefresh: true);
      });
      Loader.hideLoading();
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);

    }
  }

  Future dislike(int index) async {
    try {
      var map = {
        "product_id": passengers[index].id,
        "user_id": box.read('user_id')
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlmakunfavorite, data: map);

      var finallist = await response.data;
      favorite = success_or_no_model.fromJson(finallist);

      setState(() {
        viewallapi(isRefresh: true);
      });
      Loader.hideLoading();
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
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            title: Text(widget.name!),
            actions: [
              if (widget.type == 1) ...{
                GestureDetector(
                  onTap: () {
                    Get.to(() => AboutVendor(
                        vendor!.vendordetails!, widget.name, widget.imaage));
                  },
                  child: Container(
                    height: 3,
                    width: 30,
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: buildSvgimage(imgnem: icon_global.icabout),
                  ),
                )
              }
            ],
          ),
          body: Container(
            margin: const EdgeInsets.only(right: 12, left: 12),
            child: SmartRefresher(
              controller: refreshController,
              primary: true,
              header: CustomHeader(
                builder: (context, mode) {
                if (mode == RefreshStatus.refreshing) {
                    Center(
                      child:
                          CircularProgressIndicator(color: GlobalData.bluebtn),
                    );
                  }
                  return const Center();
                },
              ),
              footer: CustomFooter(
                builder: (context, mode) {
                  Widget body;
                  if (mode == LoadStatus.loading) {
                    body = const Center(
                      child: Center(),
                    );
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
                  refreshController.refreshFailed();
                } else {
                  refreshController.refreshCompleted();
                }
              },
              onLoading: () async {
                final result = await viewallapi();
                if (result) {
                  refreshController.loadNoData();
                } else {
                  refreshController.loadComplete();
                }
              },
              child: passengers.isNotEmpty
                  ? ListView.builder(
                      itemCount: passengers.length,
                      shrinkWrap: true,
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        return passengers.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Get.to(() => ProdutsDetails(
                                      "${passengers[index].id}",
                                      "${passengers[index].productName}"));
                                },
                                child: Container(
                                  height: 12.h,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: GlobalData.whitecolor),
                                      color: themeModel.isdark.value
                                          ? GlobalData.whitecolor
                                          : GlobalData.fullblk,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 22.w,
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(8)),
                                            image: passengers[index]
                                                    .productimage!
                                                    .imageUrl!
                                                    .isEmpty
                                                ? const DecorationImage(
                                                    image: AssetImage(
                                                        icon_global.icmans),
                                                    fit: BoxFit.cover)
                                                : DecorationImage(
                                                    image: NetworkImage(
                                                        passengers[index]
                                                            .productimage!
                                                            .imageUrl!),
                                                    fit: BoxFit.fill)),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: SizedBox(
                                                          child: Text(
                                                        passengers[index]
                                                            .productName!,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: GlobalData
                                                              .fontlistmedium,
                                                        ),
                                                      )),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () async {
                                                          if (passengers[index]
                                                                  .isWishlist ==
                                                              "0") {
                                                            Loader
                                                                .showLoading();
                                                            like(index);
                                                          } else {
                                                            Loader
                                                                .showLoading();
                                                            dislike(index);
                                                          }
                                                        },
                                                        child: passengers[index]
                                                                    .isWishlist ==
                                                                "0"
                                                            ? const Image(
                                                                image: AssetImage(
                                                                    icon_global
                                                                        .icheart),
                                                                width: 25,
                                                                height: 25,
                                                              )
                                                            : Image(
                                                                image: const AssetImage(
                                                                    icon_global
                                                                        .icbalckheart),
                                                                color: GlobalData
                                                                    .redcolor,
                                                                width: 25,
                                                                height: 25,
                                                              )),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 0, right: 0, top: 6),
                                                child: Row(
                                                  children: [
                                                    Image(
                                                        image: const AssetImage(
                                                            icon_global
                                                                .icfillstar),
                                                        width: 16,
                                                        color:
                                                            GlobalData.orange),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        passengers[index]
                                                                .rattings!
                                                                .isNotEmpty
                                                            ? "${passengers[index].rattings![0].avgRatting}"
                                                            : "0.0",
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    child: Text(
                                                        box.read("pos") ==
                                                                "right"
                                                            ? GlobalData.formatCurrency.format(double.parse(passengers[index].productPrice!)) + box.read("doller")
                                                            : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(passengers[index].productPrice!))}",
                                                        style: TextStyle(
                                                            fontFamily: GlobalData
                                                                .fontlistsemibold,
                                                            fontSize: 17.sp)),
                                                  ),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                      passengers[index]
                                                                  .discountedPrice !=
                                                              "0"
                                                          ? box.read("pos") ==
                                                                  "right"
                                                              ? GlobalData.formatCurrency.format(double.parse(passengers[index].discountedPrice!)) + box.read("doller")
                                                              : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(passengers[index].discountedPrice!))}"
                                                          : "",
                                                      style: TextStyle(
                                                          fontFamily: GlobalData
                                                              .fontlistregular,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 14.5.sp)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(
                                height: 500,
                                width: 500,
                                child: Image(
                                    image: AssetImage(icon_global.icnodata),
                                    fit: BoxFit.cover),
                              );
                      },
                    )
                  : passengers.isEmpty
                      ? SizedBox(
                          height: 50.h,
                          width: 50.h,
                          child:
                              const Image(image: AssetImage(icon_global.icnodata)))
                      : SizedBox(
                          height: 50.h,
                          width: 50.h,
                          child:
                              const Image(image: AssetImage(icon_global.icnodata))),
            ),
          ),
        );
      },
    );
  }
}
