import 'package:flutter/material.dart';
import 'package:inditab_task/viewModal/controller/home_controller.dart';
import 'package:intl/intl.dart';

class EventDataListing extends StatelessWidget {
  final HomePageController controller;
  const EventDataListing({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                  Text(DateFormat('E, d MMM, y').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          controller.data[index].date)))
                ],
              ),
            ),
          );
        });
  }
}
