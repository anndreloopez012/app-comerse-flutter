import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:get/get.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/api/category_menu.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'cat_vise_produt.dart';

// ignore: must_be_immutable
class CategoriesMenuePage extends StatefulWidget {
  String? cateid;
  String? catename;

  // ignore: use_key_in_widget_constructors
  CategoriesMenuePage([this.cateid, this.catename]);

  @override
  State<CategoriesMenuePage> createState() => _CategoriesMenuePageState();
}

class _CategoriesMenuePageState extends State<CategoriesMenuePage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  categorie_menu_model? category;
  final ScrollController _scrollController = ScrollController();

  getaddaddres() async {
    try {
      var map = {"cat_id": widget.cateid};
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlsubcategory, data: map);

      Loader.hideLoading();
      var finallist = await response.data;
      category = categorie_menu_model.fromJson(finallist);

      return category;
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
            title: Text(widget.catename!),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: FutureBuilder(
                future: getaddaddres(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      decoration: BoxDecoration(
                        color: themeModel.isdark.value
                            ? GlobalData.whitecolor
                            : GlobalData.ofwhite,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: category!.data!.subcategory!.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                              title: Text(category!
                                  .data!.subcategory![index].subcategoryName!),
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: themeModel.isdark.value
                                          ? GlobalData.fullwhite
                                          : GlobalData.fullblk,
                                      borderRadius: GlobalRadious.radious_,
                                      border: Border.all(
                                          color: GlobalData.fullwhite,
                                          width: 0.5)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    itemCount: category!
                                        .data!
                                        .subcategory![index]
                                        .innersubcategory!
                                        .length,
                                    itemBuilder: (context, index1) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return CateViseProducts(
                                                "${category!.data!.subcategory![index].innersubcategory![index1].id}",
                                                "${category!.data!.subcategory![index].innersubcategory![index1].innersubcategoryName}",
                                              );
                                            },
                                          ));
                                        },
                                        child: ListTile(
                                          tileColor: GlobalData.whitecolor,
                                          trailing: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 16),
                                          title: Text(category!
                                              .data!
                                              .subcategory![index]
                                              .innersubcategory![index1]
                                              .innersubcategoryName!),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]);
                        },
                      ),
                    );
                  }
                  return Center(
                    child:
                        CircularProgressIndicator(color: GlobalData.bluebtn),
                  );
                },
              )),
        );
      },
    );
  }
}
