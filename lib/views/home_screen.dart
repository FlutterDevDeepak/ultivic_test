import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ultivic_test/controller/home_controller.dart';

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
    homeController.dataList.value =
        List.generate(100, (index) => "City $index");
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
                  const TextField(),
                  Checkbox(
                      value: homeController.isShowSelectedItem.value,
                      onChanged: (v) {
                        homeController.showSelectedItem(v!);
                      }),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: homeController.dataList.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      value: false,
                      onChanged: (v) {},
                    );
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
