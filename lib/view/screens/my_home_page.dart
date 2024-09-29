import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inditab_task/view/widget/event_data_listing.dart';
import 'package:inditab_task/view/widget/filter_widget.dart';
import 'package:inditab_task/viewModal/controller/home_controller.dart';
import 'package:intl/intl.dart';

class MyHomePage extends GetView<HomePageController> {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return controller.getData();
          },
          child: ListView(
            children: [
              FilterWidget(controller: controller),
              EventDataListing(controller: controller)
            ],
          ),
        ));
  }
}
