import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inditab_task/viewModal/controller/home_controller.dart';
import 'package:intl/intl.dart';

class EventDataListing extends StatelessWidget {
  final HomePageController controller;
  const EventDataListing({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isFetched.value
        ? controller.data.isNotEmpty? ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(controller.data[index].title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.data[index].description),
                      Text(DateFormat('E, MMM d, y').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              controller.data[index].date)))
                    ],
                  ),
                ),
              );
            }):const Center(child: Text("No Data Found"),)
        : const Center(
            child: CircularProgressIndicator(),
          ));
  }
}
