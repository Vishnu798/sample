import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inditab_task/viewModal/controller/home_controller.dart';

class FilterDropdownWidget extends StatelessWidget {
  final HomePageController controller;
  const FilterDropdownWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Obx(() => DropdownMenu<String>(
              initialSelection: controller.sortDataValue.value,
              onSelected: (newValue) {
                controller.onDropdownSelect(newValue!);
              },
              dropdownMenuEntries: controller.items
                  .map((e) => DropdownMenuEntry(value: e, label: e))
                  .toList())),
          Obx(
            () => controller.sortDataValue.value == "Month"
                ? DropdownMenu<String>(
                    onSelected: (value) {
                      int monthIndex = controller.months.indexOf(value!);
                      controller.selectYear(context, monthIndex);
                    },
                    initialSelection: controller.selectedMonth.value,
                    dropdownMenuEntries: controller.months
                        .map((e) => DropdownMenuEntry(value: e, label: e))
                        .toList())
                : Container(
                    height: 0,
                  ),
          )
        ],
      );
  }
}
