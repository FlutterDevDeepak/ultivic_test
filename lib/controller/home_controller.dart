import 'package:get/get.dart';

class HomeController extends GetxController {


  RxBool isShowSelectedItem = false.obs;

  RxList dataList = [].obs;

  void showSelectedItem(bool value) {
    isShowSelectedItem.value = value;
  }
}
