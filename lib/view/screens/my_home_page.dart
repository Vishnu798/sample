import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inditab_task/view/widget/event_data_listing.dart';
import 'package:inditab_task/view/widget/filter_widget.dart';
import 'package:inditab_task/view/widget/no_internet_widget.dart';
import 'package:inditab_task/viewModal/controller/home_controller.dart';
import '../widget/shimmer_loading.dart';

class MyHomePage extends GetView<HomePageController> {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor:
              controller.isDarkModeEnable.value ? Colors.black : null,
          appBar: AppBar(
            title: Text(title),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              return controller.getData();
            },
            child: Obx(() {
              if (controller.isFetched.value &&
                  controller.isInternetAvailable.value &&
                  controller.data.isNotEmpty) {
                return ListView(
                  children: [
                    FilterWidget(controller: controller),
                    EventDataListing(controller: controller)
                  ],
                );
              } else if (controller.isFetched.value &&
                  !controller.isInternetAvailable.value) {
                return NoInternet(
                  controller: controller,
                );
              } else if (controller.isFetched.value &&
                  controller.isInternetAvailable.value &&
                  controller.data.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      FilterWidget(controller: controller),
                      const Text("No data Found"),
                    ],
                  ),
                );
              } else {
                return const ShimmerLoading();
              }
            }),
          )),
    );
  }
}
