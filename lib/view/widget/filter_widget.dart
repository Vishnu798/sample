import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inditab_task/viewModal/controller/home_controller.dart';

class FilterWidget extends StatelessWidget {
  final HomePageController controller;
  const FilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
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
            () => controller.sortDataValue.value == "Month"? DropdownMenu<String>(
                onSelected: (value) {
                  int monthIndex =
                      controller.months.indexOf(value!);
                  selectYear(context, monthIndex);
                },
                initialSelection: controller.selectedMonth.value,
                dropdownMenuEntries: controller.months
                    .map((e) => DropdownMenuEntry(value: e, label: e))
                    .toList()):Container(height: 0,),
          )
        
        ],
      ),
      subtitle: Obx(() {
          if (controller.sortDataValue.value == "Week" ||
            controller.sortDataValue.value == "Day") {
          return TextField(
            controller: controller.textEditingController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? date = await datePickerWidget(context);

                      if (date != null &&
                          controller.sortDataValue.value == "Week") {
                        controller.fliterDataByWeek(date);
                      } else if (date != null &&
                          controller.sortDataValue.value == "Day") {
                        controller.filterDataByDay(date);
                      }
                      
                    },
                    icon: const Icon(Icons.calendar_month))),
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

  Future<dynamic> selectYear(BuildContext context, int monthIndex) {
    controller.selectedMonth.value = controller.months[monthIndex];
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 10, 1),
              lastDate: DateTime(DateTime.now().year + 10, 1),
              selectedDate: DateTime.now(),
              onChanged: (DateTime dateTime) {
                controller
                    .filterDataByMonth(DateTime(dateTime.year, monthIndex+1));
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}
