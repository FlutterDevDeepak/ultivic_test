import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ultivic_test/models/selected_data_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCity();
  }

  RxBool isShowSelectedItem = false.obs;
  RxList<bool> isSelected = <bool>[].obs;

  RxList<String> selectedItem = <String>[].obs;

  RxList dataList = [].obs;
  RxList filterList = [].obs;

  void showSelectedItem(bool value) {
    isShowSelectedItem.value = value;
  }

  searchData(String v) {
    RxList tempList = [].obs;
    if (v.isEmpty) {
      tempList = dataList;
    } else {
      tempList.value = dataList
          .where((user) => user.toLowerCase().contains(v.toLowerCase()))
          .toList();
    }
    filterList.value = tempList;
  }

  RxList<DataModel> selectedSaveData = <DataModel>[].obs;

  addCity(DataModel model) async {
    var box = await Hive.openBox<DataModel>('city');
    box.add(model);
    debugPrint("done");
  }

  Future getCity() async {
    final box = await Hive.openBox<DataModel>('city');
    selectedSaveData.value = box.values.toList();
    print("data${selectedSaveData.toString()}");
  }

  deleteCity(int position) async {
    final box = Hive.box<DataModel>('city');
    box.deleteAt(position);
    selectedSaveData.removeAt(position);
  }

  updateCity(int position, DataModel model) async {
    var box = await Hive.openBox<DataModel>('city');
    box.putAt(position, model);
  }
}
