import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/cman_widget_product.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/products_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as getx;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dio/dio.dart';

import '../../../api/all_model/search_model.dart';
import '../../../coman_widget/widget_image.dart';

class SerchePage extends StatefulWidget {
  const SerchePage({Key? key}) : super(key: key);

  @override
  State<SerchePage> createState() => _SerchePageState();
}

class _SerchePageState extends State<SerchePage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  getx.GetStorage box = getx.GetStorage();
  search_model? searchlist;
  List<Data> _foundereusers = [];
  TextEditingController te = TextEditingController();

  Future getsearchlistapi() async {
    try {
      var map = {
        "user_id": box.read('user_id') ?? "",
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlsearchlist, data: map);

      var finallist = await response.data;

      searchlist = search_model.fromJson(finallist);
      return searchlist;
    } catch (e) {
      Loader.hideLoading();

      Loader.showErroDialog(description: "No Data Found");

    }
  }

  onserach(String serach) {
    setState(() {
      if (te.text.isNotEmpty) {
        _foundereusers = searchlist!.data!
            .where((user) => user.productName!.toString().contains(serach))
            .toList();
      } else {
        _foundereusers.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          primary: true,
          title: Text("Search".tr),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: te,
                  onChanged: (value) => onserach(value),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: "Search_here".tr,
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            left: 2.w,
                            right: 2.w,
                          ),
                          child: Image(
                            image: const AssetImage(icon_global.icserch),
                            height: 18,
                            width: 18,
                            color: themeModel.isdark.value
                                ? GlobalData.darkgray
                                : GlobalData.fullwhite,
                          )),
                      hintStyle: TextStyle(
                          fontSize: 15.sp,
                          color: themeModel.isdark.value
                              ? GlobalData.darkgray
                              : GlobalData.fullwhite,
                          fontFamily: GlobalData.fontlistregular),
                      fillColor: themeModel.isdark.value
                          ? GlobalData.whitecolor
                          : GlobalData.fullblk,
                      filled: true,
                      focusColor: Colors.white),
                ),
                Container(
                    height: 81.h,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8),
                    child: FutureBuilder(
                      future: getsearchlistapi(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return _foundereusers.isNotEmpty
                              ? ListView.separated(
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 1.5.h,
                                  );
                                },
                                itemCount: _foundereusers.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => Get.to(ProdutsDetails(
                                      "${_foundereusers[index].id!}",
                                      _foundereusers[index].productName!,
                                    )),
                                    child: Container(
                                      height: 12.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5,
                                              color: GlobalData.whitecolor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 21.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        _foundereusers[
                                                                index]
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
                                                    MainAxisAlignment
                                                        .center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    _foundereusers[index]
                                                        .productName!,
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    textAlign:
                                                        TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontFamily: GlobalData
                                                          .fontlistregular,
                                                      color: themeModel
                                                              .isdark.value
                                                          ? GlobalData
                                                              .fullblk
                                                          : GlobalData
                                                              .fullwhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                              : buildNodat(imge: icon_global.icimgsearch);
                        }
                        return bulidcircu();
                      },
                    )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
