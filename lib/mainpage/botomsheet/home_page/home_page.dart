import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/category_model.dart';
import 'package:customer_ecomerce/api/all_model/home_banner_model.dart';
import 'package:customer_ecomerce/api/all_model/home_model.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/widget_image.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/products_details.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/products_view_all.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/search.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/vendors_page.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/vendors_view_all.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../coman_widget/cman_widget_product.dart';
import '../../../login/login_page.dart';
import 'all_brands_page.dart';
import 'categories_all.dart';
import 'categories_menue.dart';
import 'notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  GetStorage box = GetStorage();
  home_banner_model? banner;
  home_model? home;
  category_model? cate;
  success_or_no_model? favorite;
  String mes = "";

  Future fetchData() async {
    var responseBanner =
        await Dio().get(default_API.baseUrl + post_api.urlbanner);
    if (responseBanner.statusCode == 200) {
      banner = home_banner_model.fromJson(responseBanner.data);
    } else {
      Text("${responseBanner.statusMessage}");
    }
    // return banner;
    var responseCate =
        await Dio().get(default_API.baseUrl + post_api.urlcategory);

    if (responseCate.statusCode == 200) {
      cate = category_model.fromJson(responseCate.data);
    } else {
      Text("${responseCate.statusMessage}");
    }

    // return cate;
    var map = {"user_id": box.read('user_id') ?? ""};
    var responseHome =
        await Dio().post(default_API.baseUrl + post_api.urlhome, data: map);
    if (responseHome.statusCode == 200) {
      home = home_model.fromJson(responseHome.data);
    } else {
      Text("${responseHome.statusMessage}");
    }
    box.write("doller", home!.currency!);
    box.write("pos", home!.currencyPosition!);
    return home;
  }

  Future homefeeds() async {
    try {
      var map = {"user_id": box.read('user_id') ?? ""};
      var response =
          await Dio().post(default_API.baseUrl + post_api.urlhome, data: map);

      home = home_model.fromJson(response.data);
      box.write("doller", home!.currency!);
      box.write("pos", home!.currencyPosition!);
      return home;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);

    }
  }

  like(int index) async {
    Loader.showLoading();
    try {
      var map = {
        "product_id": home!.featuredProducts![index].id,
        "user_id": box.read('user_id')
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlmakfavorite, data: map);
      var finallist = await response.data;
      favorite = success_or_no_model.fromJson(finallist);

      setState(() {
        homefeeds();
      });
      Loader.hideLoading();
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);

    }
  }

  dislike(int index) async {
    Loader.showLoading();
    try {
      var map = {
        "product_id": home!.featuredProducts![index].id,
        "user_id": box.read('user_id')
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlmakunfavorite, data: map);

      var finallist = await response.data;
      favorite = success_or_no_model.fromJson(finallist);

      setState(() {
        homefeeds();
      });
      Loader.hideLoading();
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);

    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 6.h,
            primary: true,
            leading: GestureDetector(
              onTap: () => Get.to(() => const SerchePage()),
              child: Padding(
                  padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 0.5.h),
                  child: Image(
                    image: const AssetImage(icon_global.icserch),
                    color: themeModel.isdark.value
                        ? GlobalData.fullblk
                        : GlobalData.fullwhite,
                  )),
            ),
            title: Text("E_Commerce".tr),
            actions: [
              GestureDetector(
                onTap: () {
                  if (box.read('user_id') == null) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return const LoginPage();
                      },
                    ));
                  } else {
                    Get.to(() => const NotificationPage());
                    // Get.to(() => AddNewCardScreen());
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: buildSvgimage(
                        imgnem: icon_global.icnoti,
                        drkclr: GlobalData.fullwhite)),
              ),
            ],
          ),
          body: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.h,
                              width: double.infinity,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: banner!.sliders!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 94.w,
                                        mainAxisSpacing: 10),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      final Uri url = Uri.parse(
                                          banner!.sliders![index].link!);
                                      if (!await launchUrl(url)) {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: GlobalRadious.radious_,
                                          image: DecorationImage(
                                              image: NetworkImage(banner!
                                                  .sliders![index].imageUrl!),
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Categories".tr,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily:
                                                GlobalData.fontlistsemibold)),
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(() => 
                                              CategoriesViewAll(cate!.data!));
                                        },
                                        child: Text("View_all".tr,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontFamily: GlobalData
                                                    .fontlistregular))),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                SizedBox(
                                    height: 15.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          indent: 1.2.h,
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cate!.data!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () =>
                                              Get.to(() => CategoriesMenuePage(
                                            "${cate!.data![index].id!}",
                                            cate!.data![index].categoryName!,
                                          )),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 14.h,
                                                width: 29.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        GlobalRadious.radious_,
                                                    border:
                                                        GlobalRadious.border,
                                                    color: GlobalData
                                                        .circleColors[index]),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(
                                                      4, 8, 4, 6),
                                                  child: Column(
                                                    children: [
                                                      Image(
                                                          image: NetworkImage(
                                                              cate!.data![index]
                                                                  .imageUrl!),
                                                          fit: BoxFit.cover,
                                                          height: 8.h,
                                                          width: 16.w),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                            cate!.data![index]
                                                                .categoryName!,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: themeModel
                                                                        .isdark
                                                                        .value
                                                                    ? GlobalData
                                                                        .fullblk
                                                                    : GlobalData
                                                                        .fullblk,
                                                                fontFamily:
                                                                    GlobalData
                                                                        .fontlistmedium,
                                                                fontSize:
                                                                    16.sp)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Divider(height: 1, color: GlobalData.grey),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Featured_Products".tr,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily:
                                                GlobalData.fontlistsemibold)),
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(() => () => ViewAllProducts(1));
                                        },
                                        child: Text("View_all".tr,
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                fontFamily: GlobalData
                                                    .fontlistregular))),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                /////////featured products
                                SizedBox(
                                    height: 36.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          endIndent: 1.5.h,
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemCount: home!.featuredProducts!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(() => ProdutsDetails(
                                                "${home!.featuredProducts![index].id!}",
                                                home!.featuredProducts![index].productName!));
                                          },
                                          child: buildtrendingproductcell(
                                              ret: home!
                                                      .featuredProducts![index]
                                                      .rattings!
                                                      .isNotEmpty
                                                  ? "${home!.featuredProducts![index].rattings![0].avgRatting}"
                                                  : "0.0",
                                              productImage: home!
                                                  .featuredProducts![index]
                                                  .productimage!
                                                  .imageUrl!,
                                              productName: home!
                                                  .featuredProducts![index]
                                                  .productName!,
                                              productPrice: home!
                                                  .featuredProducts![index]
                                                  .productPrice!,
                                              productdiscountprice: home!
                                                  .featuredProducts![index]
                                                  .discountedPrice!,
                                              widget: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 8, right: 8),
                                                  height: 25,
                                                  width: 25,
                                                  child: GestureDetector(
                                                      onTap: () async {
                                                        if (box.read(
                                                                "user_id") ==
                                                            null) {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                            builder: (context) {
                                                              return const LoginPage();
                                                            },
                                                          ));
                                                        } else {
                                                          if (home!
                                                                  .featuredProducts![
                                                                      index]
                                                                  .isWishlist ==
                                                              "0") {
                                                            like(index);
                                                          } else {
                                                            dislike(index);
                                                          }
                                                        }
                                                      },
                                                      child: Image(
                                                        image: AssetImage(home!
                                                                    .featuredProducts![
                                                                        index]
                                                                    .isWishlist ==
                                                                "0"
                                                            ? icon_global
                                                                .icheart
                                                            : icon_global
                                                                .icbalckheart),
                                                        width: 25,
                                                        height: 25,
                                                      )))),
                                        );
                                      },
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Divider(height: 1, color: GlobalData.grey),
                            SizedBox(
                              height: 1.8.h,
                            ),
                            SizedBox(
                              height: 26.h,
                              width: double.infinity,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: banner!.topbanner!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 94.w,
                                        mainAxisSpacing: 10),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (banner!.topbanner![index].type ==
                                          "category") {
                                        Get.to(() => CategoriesMenuePage(
                                          banner!.topbanner![index].catId!,
                                          banner!
                                              .topbanner![index].categoryName!,
                                        ));
                                      }
                                      if (banner!.topbanner![index].type ==
                                          "product") {
                                        Get.to(() => ProdutsDetails(
                                          banner!.topbanner![index].productId!,
                                          banner!
                                              .topbanner![index].categoryName!,
                                        ));
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: GlobalRadious.radious_,
                                          image: DecorationImage(
                                              image: NetworkImage(banner!
                                                  .topbanner![index].imageUrl!),
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Divider(height: 1, color: GlobalData.grey),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Vendors".tr,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily:
                                                GlobalData.fontlistsemibold)),
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(() => const VendorsViewAllPage());
                                        },
                                        child: Text("View_all".tr,
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                fontFamily: GlobalData
                                                    .fontlistregular))),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                    height: 16.2.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 10,
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemCount: home!.vendors!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(() => VendorsPage(
                                              1,
                                              "${home!.vendors![index].id}",
                                              "${home!.vendors![index].name}",
                                              "${home!.vendors![index].imageUrl}",
                                            ));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 16.h,
                                                width: 32.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        GlobalRadious.radious_,
                                                    border:
                                                        GlobalRadious.border,
                                                    color:
                                                        GlobalData.fullwhite),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 6),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        height: 10.h,
                                                        width: 20.w,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image: home!
                                                                    .vendors![
                                                                        index]
                                                                    .imageUrl!
                                                                    .isEmpty
                                                                ? const DecorationImage(
                                                                    image: AssetImage(
                                                                        "image/${icon_global.icpalceholder}"),
                                                                    fit: BoxFit
                                                                        .cover)
                                                                : DecorationImage(
                                                                    image: NetworkImage(home!
                                                                        .vendors![
                                                                            index]
                                                                        .imageUrl!),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                            child: Text(
                                                          home!.vendors![index]
                                                              .name!,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 14.5.sp,
                                                              fontFamily: GlobalData
                                                                  .fontlistregular,
                                                              color: themeModel
                                                                      .isdark
                                                                      .value
                                                                  ? GlobalData
                                                                      .fullblk
                                                                  : GlobalData
                                                                      .fullblk),
                                                        )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Divider(height: 1, color: GlobalData.grey),
                            SizedBox(
                              height: 1.5.h,
                            ),

                            ///new arrivals
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("New_arrivals".tr,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily:
                                                GlobalData.fontlistsemibold)),
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(() => ViewAllProducts(2));
                                        },
                                        child: Text("View_all".tr,
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                fontFamily: GlobalData
                                                    .fontlistregular))),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                SizedBox(
                                    height: 36.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          endIndent: 1.5.h,
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemCount: home!.newProducts!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Get.to(() => ProdutsDetails(
                                                "${home!.newProducts![index].id}",
                                                "${home!.newProducts![index].productName}",
                                              ));
                                            },
                                            child: buildtrendingproductcell(
                                              ret: home!.newProducts![index]
                                                      .rattings!.isNotEmpty
                                                  ? "${home!.newProducts![index].rattings![0].avgRatting}"
                                                  : "0.0",
                                              widget: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 8, right: 8),
                                                  height: 25,
                                                  width: 25,
                                                  child: GestureDetector(
                                                      onTap: () async {
                                                        if (box.read(
                                                                "user_id") ==
                                                            null) {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                            builder: (context) {
                                                              return const LoginPage();
                                                            },
                                                          ));
                                                        } else {
                                                          if (home!
                                                                  .newProducts![
                                                                      index]
                                                                  .isWishlist ==
                                                              "0") {
                                                            like(index);
                                                          } else {
                                                            dislike(index);
                                                          }
                                                        }
                                                      },
                                                      child: home!
                                                                  .featuredProducts![
                                                                      index]
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
                                                            ))),
                                              productImage: home!
                                                  .newProducts![index]
                                                  .productimage!
                                                  .imageUrl!,
                                              productName: home!
                                                  .newProducts![index]
                                                  .productName!,
                                              productPrice: home!
                                                  .newProducts![index]
                                                  .productPrice!,
                                              productdiscountprice: home!
                                                  .newProducts![index]
                                                  .discountedPrice!,
                                            ));
                                      },
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Divider(height: 1, color: GlobalData.grey),
                            SizedBox(
                              height: 2.h,
                            ),
                           SizedBox(
                              height: 2.h,
                            ),

                            SizedBox(
                              height: 46.h,
                              width: double.infinity,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: banner!.leftbanner!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 94.w,
                                        mainAxisSpacing: 0),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (banner!.leftbanner![index].type ==
                                          "category") {
                                        Get.to(() => CategoriesMenuePage(
                                          banner!.leftbanner![index].catId!,
                                          banner!
                                              .leftbanner![index].categoryName!,
                                        ));
                                      } else if (banner!
                                              .leftbanner![index].type ==
                                          "product") {
                                        Get.to(() => ProdutsDetails(
                                          banner!.leftbanner![index].productId!,
                                          banner!
                                              .leftbanner![index].categoryName!,
                                        ));
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: GlobalRadious.radious_,
                                          image: DecorationImage(
                                              image: NetworkImage(banner!
                                                  .leftbanner![index]
                                                  .imageUrl!),
                                              fit: BoxFit.fill)),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              height: 28.h,
                              width: double.infinity,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: banner!.bottombanner!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: 94.w,
                                        mainAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (banner!.bottombanner![index].type ==
                                          "category") {
                                        Get.to(() => CategoriesMenuePage(
                                          banner!.bottombanner![index].catId!,
                                          banner!.bottombanner![index]
                                              .categoryName!,
                                        ));
                                      } else if (banner!
                                              .bottombanner![index].type ==
                                          "product") {
                                        Get.to(() => ProdutsDetails(
                                          banner!
                                              .bottombanner![index].productId!,
                                          banner!.bottombanner![index]
                                              .categoryName!,
                                        ));
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: GlobalRadious.radious_,
                                          image: DecorationImage(
                                              image: NetworkImage(banner!
                                                  .bottombanner![index]
                                                  .imageUrl!),
                                              fit: BoxFit.fill)),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Divider(height: 1, color: GlobalData.grey),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Brands".tr,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily:
                                            GlobalData.fontlistsemibold)),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(() => const AllBrandsView());
                                    },
                                    child: Text("View_all".tr,
                                        style: TextStyle(
                                            fontSize: 17.sp,
                                            fontFamily:
                                                GlobalData.fontlistregular))),
                              ],
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            SizedBox(
                                height: 14.h,
                                width: double.infinity,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      indent: 1.2.h,
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: home!.brands!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => VendorsPage(
                                          2,
                                          "${home!.brands![index].id}",
                                          "${home!.brands![index].brandName}",
                                        ));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 14.h,
                                            width: 29.w,
                                            decoration: BoxDecoration(
                                                border: GlobalRadious.border,
                                                shape: BoxShape.circle,
                                                color: GlobalData
                                                    .randomGenerator()),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 10.h,
                                                  width: 20.w,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              home!
                                                                  .brands![
                                                                      index]
                                                                  .imageUrl!))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )),
                            SizedBox(
                              height: 2.h,
                            ),
                            Divider(height: 1, color: GlobalData.grey),
                            SizedBox(
                              height: 1.5.h,
                            ),

                            ///Hot Deals
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Hot_Deals".tr,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily:
                                            GlobalData.fontlistsemibold)),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(() => ViewAllProducts(3));
                                    },
                                    child: Text("View_all".tr,
                                        style: TextStyle(
                                            fontSize: 17.sp,
                                            fontFamily:
                                                GlobalData.fontlistregular))),
                              ],
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                          SizedBox(
                                height: 36.h,
                                width: double.infinity,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      endIndent: 1.5.h,
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: home!.hotProducts!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProdutsDetails(
                                            "${home!.hotProducts![index].id}",
                                            "${home!.hotProducts![index].productName}",
                                          ));
                                        },
                                        child: buildtrendingproductcell(
                                          ret: home!.hotProducts![index]
                                                  .rattings!.isNotEmpty
                                              ? "${home!.hotProducts![index].rattings![0].avgRatting}"
                                              : "0.0",
                                          widget: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 8, right: 8),
                                              height: 25,
                                              width: 25,
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    if (box.read("user_id") ==
                                                        null) {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return const LoginPage();
                                                        },
                                                      ));
                                                    } else {
                                                      if (home!
                                                              .hotProducts![
                                                                  index]
                                                              .isWishlist ==
                                                          "0") {
                                                        like(index);
                                                      } else {
                                                        dislike(index);
                                                      }
                                                    }
                                                  },
                                                  child:
                                                      home!.hotProducts![index]
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
                                                            ))),
                                          productImage: home!
                                              .hotProducts![index]
                                              .productimage!
                                              .imageUrl!,
                                          productName: home!
                                              .hotProducts![index].productName!,
                                          productPrice: home!
                                              .hotProducts![index]
                                              .productPrice!,
                                          productdiscountprice: home!
                                              .hotProducts![index]
                                              .discountedPrice!,
                                        ));
                                  },
                                )),
                            SizedBox(
                              height: 2.h,
                            ),
                            Divider(height: 1, color: GlobalData.grey),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 26.h,
                        width: double.infinity,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: banner!.largebanner!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisExtent: 100.w,
                                  mainAxisSpacing: 0),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (banner!.largebanner![index].type ==
                                    "category") {
                                  Get.to(() => CategoriesMenuePage(
                                    banner!.largebanner![index].catId!,
                                    banner!.largebanner![index].categoryName!,
                                  ));
                                } else if (banner!.largebanner![index].type ==
                                    "product") {
                                  Get.to(() => ProdutsDetails(
                                    banner!.largebanner![index].productId!,
                                    banner!.largebanner![index].categoryName!,
                                  ));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(banner!
                                            .largebanner![index].imageUrl!),
                                        fit: BoxFit.fill)),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Divider(height: 1, color: GlobalData.grey),
                    ],
                  ),
                );
              }
              return bulidcircu();
            },
          ),
        );
      },
    );
  }
}
