import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultivic_test/controller/home_controller.dart';
import 'package:ultivic_test/models/selected_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getCity();
    homeController.dataList.value =
        List.generate(100, (index) => "City $index");
    homeController.isSelected.value =
        List<bool>.filled(homeController.dataList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: TextField(
                    onChanged: (String v) {
                      homeController.searchData(v);
                    },
                  )),
                  Checkbox(
                      value: homeController.isShowSelectedItem.value,
                      onChanged: (v) {
                        homeController.showSelectedItem(v!);
                      }),
                ],
              ),
              Expanded(
                child: homeController.filterList.isEmpty
                    ? ListView.builder(
                        itemCount: homeController.dataList.length,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            return CheckboxListTile(
                              value: homeController.isSelected[index],
                              onChanged: (v) {
                                homeController.isSelected[index] = v!;
                                if (homeController.selectedItem
                                    .contains(homeController.dataList[index])) {
                                  // homeController.deleteCity(
                                  //   index,
                                  // );
                                  homeController.selectedItem
                                      .remove(homeController.dataList[index]);
                                } else {
                                  homeController.selectedItem
                                      .add(homeController.dataList[index]);
                                  // homeController.updateCity(
                                  //     index,
                                  //     DataModel(
                                  //         isSelected: homeController
                                  //             .isSelected[index]));
                                }
                                debugPrint(
                                    homeController.selectedItem.toString());
                              },
                              title: Text(homeController.dataList[index]),
                            );
                          });
                        },
                      )
                    : ListView.builder(
                        itemCount: homeController.filterList.length,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            return CheckboxListTile(
                              value: homeController.isSelected[index],
                              onChanged: (v) {
                                homeController.isSelected[index] = v!;
                                if (homeController.selectedItem
                                    .contains(homeController.dataList[index])) {
                                  homeController.selectedItem
                                      .remove(homeController.dataList[index]);
                                } else {
                                  homeController.selectedItem
                                      .add(homeController.dataList[index]);
                                }

                                debugPrint(
                                    homeController.selectedItem.toString());
                              },
                              title: Text(homeController.filterList[index]),
                            );
                          });
                        },
                      ),
              ),
              homeController.isShowSelectedItem.value == true
                  ? SizedBox(
                      child: Text(homeController.selectedItem
                          .map((element) => element)
                          .toString()))
                  : Container()
            ],
          ),
        );
      }),
    );
  }
}
