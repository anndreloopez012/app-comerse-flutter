import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/view_all_model.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/products_details.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get_storage/get_storage.dart' as store;
import '../../../api/all_model/success_or_not.dart';
import '../../../coman_widget/cman_widget_product.dart';
import '../../../login/login_page.dart';

// ignore: must_be_immutable
class ViewAllProducts extends StatefulWidget {
  int? type;

  ViewAllProducts(this.type, {super.key});

  @override
  State<ViewAllProducts> createState() => _ViewAllProductsState();
}

class _ViewAllProductsState extends State<ViewAllProducts> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  view_all_listing_model? view;
  store.GetStorage box = store.GetStorage();

  late int totalPages;
  late int totalPa;

  late int tos;

  List<Datasub> passengers = [];
  bool isRefresh = false;
  bool mss = false;
  int type = 0;
  late int too;
  success_or_no_model? favorite;
  int currentPage = 1;
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );
  bool zam = false;

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
      Map map = {
        "type": widget.type == 1
            ? "featured_products"
            : widget.type == 2
                ? "new_products"
                : widget.type == 3
                    ? "hot_products"
                    : "null",
        "user_id": box.read('user_id')
      };

      var response = await Dio().post(
          "${default_API.baseUrl + post_api.urlviewall}?page=$currentPage",
          data: map);
      Loader.hideLoading();
      if (response.statusCode == 200) {
        var result = await response.data;
        view = view_all_listing_model.fromJson(result);
        if (isRefresh) {
          passengers = view!.data!.data!;
        } else {
          passengers.addAll(view!.data!.data!);
        }
        currentPage++;
      
        totalPages = view!.data!.total!;
        too = view!.data!.to!;
       
        setState(() {});
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

  Future<bool> viewhighb(int type, {bool isRsf = false}) async {
    Loader.showLoading();
    try {
      if (isRsf) {
        currentPage = 1;
      } else {
        if (tos == totalPa) {
          Loader.hideLoading();
          refreshController.loadNoData();
          return false;
        }
      }
      Map map = {
        "type": type == 1
            ? "new"
            : type == 2
                ? "price-low-to-high"
                : type == 3
                    ? "price-high-to-low"
                    : type == 4
                        ? "ratting-low-to-high"
                        : type == 5
                            ? "ratting-high-to-low"
                            : "",
        "product": "",
        "innersubcat_id": "",
        "user_id": box.read('user_id')
      };

      var response = await Dio().post(
          "${default_API.baseUrl + post_api.urlfilter}?page=$currentPage",
          data: map);
      Loader.hideLoading();
      if (response.statusCode == 200) {
        var result = await response.data;
        view = view_all_listing_model.fromJson(result);
        if (isRsf) {
          passengers = view!.data!.data!;
        } else {
          passengers.addAll(view!.data!.data!);
        }
        currentPage++;
        totalPa = view!.data!.total!;
        tos = view!.data!.to!;

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
            leadingWidth: 6.h,
            primary: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            title: Text(widget.type == 1
                ? "Featured_Products".tr
                : widget.type == 2
                    ? "New_arrivals".tr
                    : widget.type == 3
                        ? "Hot_Deals".tr
                        : "null"),
            actions: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isDismissible: false,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 38.h,
                        color: themeModel.isdark.value
                            ? GlobalData.fullwhite
                            : GlobalData.fullblk,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.h,
                              child: AppBar(
                                // leadingWidth: 6.h,
                                primary: true,
                                leading: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 20,
                                    )),
                                title: Text("Sort_By".tr,
                                    style: TextStyle(
                                        color: themeModel.isdark.value
                                            ? GlobalData.fullblk
                                            : GlobalData.fullwhite,
                                        fontFamily: GlobalData.fontlistbold,
                                        fontSize: 18.sp)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      passengers.clear();
                                      zam = true;
                                      currentPage = 1;
                                      mss = false;
                                      Navigator.pop(context);
                                      Loader.showLoading();
                                      viewhighb(1, isRsf: true);
                                      Navigator.pop(context);
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text("Latest",
                                          style: TextStyle(
                                              color: themeModel.isdark.value
                                                  ? GlobalData.fullblk
                                                  : GlobalData.fullwhite,
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              fontSize: 17.sp)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Divider(
                                    color: themeModel.isdark.value
                                        ? GlobalData.grey
                                        : GlobalData.fullwhite,
                                    height: 0.5,
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      passengers.clear();
                                      zam = true;
                                      currentPage = 1;

                                      mss = false;
                                      Navigator.pop(context);
                                      Loader.showLoading();
                                      viewhighb(2, isRsf: true);
                                      Navigator.pop(context);
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text("Price Low to high",
                                          style: TextStyle(
                                              color: themeModel.isdark.value
                                                  ? GlobalData.fullblk
                                                  : GlobalData.fullwhite,
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              fontSize: 17.sp)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Divider(
                                    color: themeModel.isdark.value
                                        ? GlobalData.grey
                                        : GlobalData.fullwhite,
                                    height: 0.5,
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        passengers.clear();
                                        zam = true;
                                        currentPage = 1;

                                        mss = false;
                                        Navigator.pop(context);
                                        Loader.showLoading();
                                        viewhighb(3, isRsf: true);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text("Price_high_to_low".tr,
                                          style: TextStyle(
                                              color: themeModel.isdark.value
                                                  ? GlobalData.fullblk
                                                  : GlobalData.fullwhite,
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              fontSize: 17.sp)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Divider(
                                    color: themeModel.isdark.value
                                        ? GlobalData.grey
                                        : GlobalData.fullwhite,
                                    height: 0.5,
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        passengers.clear();
                                        zam = true;
                                        currentPage = 1;
                                        mss = false;
                                        Navigator.pop(context);
                                        Loader.showLoading();
                                        viewhighb(4, isRsf: true);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text("Ratting_low_to_high".tr,
                                          style: TextStyle(
                                              color: themeModel.isdark.value
                                                  ? GlobalData.fullblk
                                                  : GlobalData.fullwhite,
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              fontSize: 17.sp)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Divider(
                                    color: themeModel.isdark.value
                                        ? GlobalData.grey
                                        : GlobalData.fullwhite,
                                    height: 0.5,
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      passengers.clear();
                                      zam = true;
                                      currentPage = 1;
                                      totalPages = 0;
                                      too = 0;
                                      mss = false;
                                      Navigator.pop(context);
                                      Loader.showLoading();
                                      viewhighb(5, isRsf: true);
                                      Navigator.pop(context);
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text("Ratting_low_to_high".tr,
                                          style: TextStyle(
                                              color: themeModel.isdark.value
                                                  ? GlobalData.fullblk
                                                  : GlobalData.fullwhite,
                                              fontFamily:
                                                  GlobalData.fontlistregular,
                                              fontSize: 17.sp)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Divider(
                                    color: themeModel.isdark.value
                                        ? GlobalData.grey
                                        : GlobalData.fullwhite,
                                    height: 0.5,
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: SvgPicture.asset(icon_global.icuniqserch)),
              )
            ],
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
              onRefresh: () async {
                if (zam == false) {
                  final result = await viewallapi(isRefresh: true);
                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                }
                if (zam == true) {
                  final result = await viewhighb(1, isRsf: true);

                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                }
              },
              onLoading: () async {
                if (zam == false) {
                  final result = await viewallapi();

                  if (result) {
                    refreshController.loadComplete();
                  } else {
                    refreshController.loadFailed();
                  }
                }
                if (zam == true) {
                  final result = await viewhighb(1);

                  if (result) {
                    refreshController.loadComplete();
                  } else {
                    refreshController.loadFailed();
                  }
                }
              },
              child: passengers.isNotEmpty
                  ? GridView.builder(
                      itemCount: passengers.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.58,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(() => ProdutsDetails("${passengers[index].id!}",
                                  passengers[index].productName!));
                            },
                            child: buildtrendingproductcell(
                              productImage:
                                  passengers[index].productimage!.imageUrl!,
                              productName: passengers[index].productName!,
                              productPrice: passengers[index].productPrice!,
                              productdiscountprice:
                                  passengers[index].discountedPrice!,
                              ret: passengers[index].rattings!.isNotEmpty
                                  ? "${passengers[index].rattings![0].avgRatting}"
                                  : "0.0",
                              widget: Container(
                                  margin: const EdgeInsets.only(top: 8, right: 8),
                                  height: 25,
                                  width: 25,
                                  child: GestureDetector(
                                      onTap: () async {
                                        if (box.read("user_id") == null) {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return const LoginPage();
                                            },
                                          ));
                                        } else {
                                          if (passengers[index].isWishlist ==
                                              "0") {
                                            Loader.showLoading();
                                            like(index);
                                          } else {
                                            Loader.showLoading();
                                            dislike(index);
                                          }
                                        }
                                      },
                                      child: passengers[index].isWishlist == "0"
                                          ? const Image(
                                              image: AssetImage(
                                                  icon_global.icheart),
                                              width: 25,
                                              height: 25,
                                            )
                                          : Image(
                                              image: const AssetImage(
                                                  icon_global.icbalckheart),
                                              color: GlobalData.redcolor,
                                              width: 25,
                                              height: 25,
                                            ))),
                            ));
                      },
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
