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

class VendorsViewAllPage extends StatefulWidget {
  const VendorsViewAllPage({super.key});

  @override
  State<VendorsViewAllPage> createState() => _VendorsViewAllPageState();
}

class _VendorsViewAllPageState extends State<VendorsViewAllPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();

  store.GetStorage box = store.GetStorage();
  String right = "0";
  late int totalPages;
  List<Data> passengers = [];
  bool? isRefresh;
  bool mss = false;
  late int totalPa;
  late int too;
  vendors_model? vender;
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
    var response = await Dio()
        .get("${default_API.baseUrl + post_api.urlvendors}?page=$currentPage");
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
            title: Text("Vendors".tr),
          ),
          body: Container(
            margin: const EdgeInsets.only(
              right: 12,
              left: 12,
            ),
            child: SmartRefresher(
              controller: refreshController,
              primary: true,
              header: CustomHeader(
                builder: (context, mode) {
                  if (mode == LoadStatus.loading) {
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
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(VendorsPage(
                              1,
                              "${passengers[index].id}",
                              "${passengers[index].name}",
                            ));
                          },
                          child: Container(
                            height: 12.h,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: GlobalData.whitecolor),
                                color: themeModel.isdark.value
                                    ? GlobalData.whitecolor
                                    : GlobalData.fullblk,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 25.w,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      image: passengers[index].imageUrl!.isEmpty
                                          ? const DecorationImage(
                                              image: AssetImage(
                                                  "image/${icon_global.icpalceholder}"),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: NetworkImage(
                                                  passengers[index].imageUrl!),
                                              fit: BoxFit.cover)),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            child: Text(
                                          passengers[index].name!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily:
                                                GlobalData.fontlistsemibold,
                                            color: themeModel.isdark.value
                                                ? GlobalData.ofblack
                                                : GlobalData.fullwhite,
                                          ),
                                        )),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 0, right: 0, top: 6),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 14,
                                                width: 14,
                                                child: Image(
                                                    image: const AssetImage(
                                                        icon_global
                                                            .icfillstar),
                                                    color: GlobalData.orange),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const SizedBox(
                                                child: Text("0.0"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                  child: const Icon(Icons.arrow_forward_ios),
                                ),
                              ],
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
