import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inditab_task/view/widget/fliter_dropdown_widget.dart';
import 'package:inditab_task/viewModal/controller/home_controller.dart';

class FilterWidget extends StatelessWidget {
  final HomePageController controller;
  const FilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: FilterDropdownWidget(controller: controller),
      subtitle: Obx(() {
        if (controller.sortDataValue.value == "Week" ||
            controller.sortDataValue.value == "Day") {
          return GestureDetector(
            onTap: () async {
              DateTime? date = await datePickerWidget(context);
              if (date != null) {
                controller.applyFilter(date);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 11.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.textEditingController.text,
                          style: const TextStyle(fontSize: 17),
                        ),
                        GestureDetector(
                            onTap: () async {
                              DateTime? date = await datePickerWidget(context);

                              if (date != null) {
                                controller.applyFilter(date);
                              }
                            },
                            child: const Icon(Icons.calendar_month))
                      ],
                    ),
                    const Divider(
                      thickness: 2.0,
                      color: Colors.black,
                    )
                  ],
                ),
              
            ),
          );
        } else {
          return Container(
            height: 0,
          );
        }
      }),
    );
  }

  Future<DateTime?> datePickerWidget(BuildContext context) {
    return showDatePicker(
        context: context,
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime(2026, 12, 12));
  }
}
