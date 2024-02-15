import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/vendors_model.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/vendors_page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' as store;
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllBrandsView extends StatefulWidget {
  const AllBrandsView({super.key});

  @override
  State<AllBrandsView> createState() => _AllBrandsViewState();
}

class _AllBrandsViewState extends State<AllBrandsView> {
  ThemeModel themeModel = Get.find<ThemeModel>();

  store.GetStorage box = store.GetStorage();

  late int totalPages;
  List<Data> passengers = [];
  bool? isRefresh;
  bool mss = false;
  late int totalPa;
  late int too;
  int currentPage = 0;
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );
  vendors_model? vender;

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
    var response = await Dio()
        .get("${default_API.baseUrl + post_api.urlbrands}?page=$currentPage");
    if (response.statusCode == 200) {
      vender = vendors_model.fromJson(response.data);
      if (vender!.status == 0) {
        Loader.hideLoading();
        SizedBox(
          width: 50.w,
          height: 50.h,
          child: const Image(image: AssetImage(icon_global.icnodata)),
        );

        return false;
      }
      if (vender!.status == 1) {
        Loader.hideLoading();
        if (isRefresh) {
          passengers = vender!.vendors!.data!;
        } else {
          passengers.addAll(vender!.vendors!.data!);
        }
        currentPage++;
        totalPages = vender!.vendors!.total!;
        too = vender!.vendors!.to!;
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
            title: Text("All_Brands".tr),
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
                  ? GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: passengers.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.18.w,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => VendorsPage(
                              2,
                              "${passengers[index].id}",
                              "${passengers[index].name}",
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: GlobalData.randomGenerator(),
                              borderRadius: GlobalRadious.radious_,
                            ),
                            margin: const EdgeInsets.all(5),
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image(
                                      image: NetworkImage(
                                          passengers[index].imageUrl!),
                                      height: 12.h,
                                      width: 20.w),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : passengers.isEmpty
                      ? Center(
                          heightFactor: 50.h,
                          widthFactor: 50.h,
                          child:
                              const Image(image: AssetImage(icon_global.icnodata)))
                      : Center(
                          heightFactor: 50.h,
                          widthFactor: 50.h,
                          child:
                              const Image(image: AssetImage(icon_global.icnodata))),
            ),
          ),
        );
      },
    );
  }
}
