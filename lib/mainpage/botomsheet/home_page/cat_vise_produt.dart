import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/innersubcater_model.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/products_details.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' as store;
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import '../../../coman_widget/cman_widget_product.dart';
import '../../../coman_widget/widget_image.dart';
import '../../../login/login_page.dart';

// ignore: must_be_immutable
class CateViseProducts extends StatefulWidget {
  String? id;
  String? name;

  // ignore: use_key_in_widget_constructors
  CateViseProducts([this.id, this.name]);

  @override
  State<CateViseProducts> createState() => _CateViseProductsState();
}

class _CateViseProductsState extends State<CateViseProducts> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  success_or_no_model? favorite;
  subcaategory_vice_protuct? vendor;
  store.GetStorage box = store.GetStorage();
  late int totalPages;
  List<Datasub> passengers = [];
  bool mss = false;
  int currentPage = 0;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> catviceapi({bool isRefresh = false}) async {
    Loader.showLoading();
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }
    Map map = {
      "innersubcategory_id": widget.id,
      "user_id": box.read('user_id')
    };

    var response = await Dio().post(
        "${default_API.baseUrl + post_api.urlinnersub}?page=$currentPage",
        data: map);

    if (response.statusCode == 200) {
      vendor = subcaategory_vice_protuct.fromJson(response.data);
      if (vendor!.status == 0) {
        Loader.hideLoading();
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

        setState(() {
          mss = true;
        });
        return true;
      } else {
        return true;
      }
    } else {
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
        catviceapi(isRefresh: true);
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
        catviceapi(isRefresh: true);
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
          ),
          body: Container(
            margin: const EdgeInsets.only(right: 12, left: 12),
            child: SmartRefresher(
                controller: refreshController,
                primary: true,
                header: CustomHeader(
                  builder: (context, mode) {
                    if (mode == LoadStatus.loading) {
                      const CircularProgressIndicator();
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
                  final result = await catviceapi(isRefresh: true);
                  if (result) {
                    refreshController.refreshFailed();
                  } else {
                    refreshController.refreshCompleted();
                  }
                },
                onLoading: () async {
                  final result = await catviceapi();
                  if (result) {
                    refreshController.loadNoData();
                  } else {
                    refreshController.loadComplete();
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
                                Get.to(ProdutsDetails(
                                    "${passengers[index].id!}",
                                    passengers[index].productName!));
                              },
                              child: buildtrendingproductcell(
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
                                        child: passengers[index].isWishlist ==
                                                "0"
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
                              ));
                        },
                      )
                    : buildNodat(imge: icon_global.icnodata)),
          ),
        );
      },
    );
  }
}
