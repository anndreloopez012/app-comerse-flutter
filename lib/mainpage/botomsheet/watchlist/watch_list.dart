import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' as store;
import 'package:get/get.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../api/all_model/success_or_not.dart';
import '../../../api/all_model/view_all_model.dart';
import '../../../coman_widget/cman_widget_product.dart';
import '../../../coman_widget/widget_image.dart';
import '../../../login/login_page.dart';
import '../home_page/products_details.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  store.GetStorage box = store.GetStorage();
  view_all_listing_model? view;
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
  bool zam = false;

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
        "${default_API.baseUrl + post_api.urlwishlist}?page=$currentPage",
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
        if (passengers.length <= 1) {
          passengers.clear();
        }
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
            automaticallyImplyLeading: false,
            title: Text("My_WhishList".tr),
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
                  ? GridView.builder(
                      itemCount: passengers.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.58,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final passenger = passengers[index];
                        return GestureDetector(
                            onTap: () {
                              Get.to(() => ProdutsDetails("${passenger.id!}",
                                  passenger.productName!));
                            },
                            child: buildtrendingproductcell(
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
                                          if (passenger.isWishlist == "1") {
                                            Loader.showLoading();
                                            dislike(index);
                                          }
                                        }
                                      },
                                      child: passenger.isWishlist == "0"
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
                              productImage:
                                  passengers[index].productimage!.imageUrl!,
                              productName: passengers[index].productName!,
                              productPrice: passengers[index].productPrice!,
                              productdiscountprice:
                                  passengers[index].discountedPrice!,
                              ret: passengers[index].rattings!.isNotEmpty
                                  ? "${passengers[index].rattings![0].avgRatting}"
                                  : "0.0",
                            ));
                      },
                    )
                  : buildNodat(imge: icon_global.icwishlistdata),
            ),
          ),
        );
      },
    );
  }
}
