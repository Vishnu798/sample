import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inditab_task/modal/modals/event_model.dart';
import 'package:inditab_task/modal/repository/event_repository.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  RxList<Data> data = <Data>[].obs;
  RxList<Data> dataView = <Data>[].obs;
  final EventRepository _repository = EventRepository();
  RxString sortDataValue = "Sort by".obs;
  TextEditingController textEditingController = TextEditingController(text: "");
  RxBool isDarkModeEnable = false.obs;
  List<String> items = [
    'Sort by',
    'Day',
    'Week',
    'Month',
  ];
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  RxInt selectedDate = 0.obs;
  RxString selectedMonth = "".obs;
  RxBool isFetched = false.obs;
  RxBool isInternetAvailable = true.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    isFetched.value = false;
    isInternetAvailable.value = true;
    data.value = [];
    checkUserConnection();
    sortDataValue.value = "Sort by";
    List<Data> dataList = await _repository.getData();
    if (dataList.isNotEmpty) {
      data.value = dataList;
      dataView.value = dataList;
    }
    isFetched.value = true;
  }

  void fliterDataByWeek(DateTime date) {
    isFetched.value = false;
    data.value = [];
    int curTime = date.millisecondsSinceEpoch;
    int timeAfterWeek =
        date.add(const Duration(days: 7)).millisecondsSinceEpoch;
    selectedDate.value = timeAfterWeek;
    textEditingController.text =
        '${DateFormat('d MMM, y').format(DateTime.fromMillisecondsSinceEpoch(curTime))} to ${DateFormat('d MMM, y').format(DateTime.fromMillisecondsSinceEpoch(timeAfterWeek))}';

    for (int i = 0; i < dataView.length; i++) {
      if (dataView[i].date >= curTime && dataView[i].date <= timeAfterWeek) {
        data.add(dataView[i]);
      }
    }

    isFetched.value = true;
  }

  void filterDataByDay(DateTime date) {
    isFetched.value = false;
    data.value = [];

    int curTime = date.millisecondsSinceEpoch;
    textEditingController.text = DateFormat('d MMM, y')
        .format(DateTime.fromMillisecondsSinceEpoch(curTime));

    for (int i = 0; i < dataView.length; i++) {
      if (dataView[i].date == curTime) {
        data.add(dataView[i]);
      }
    }

    isFetched.value = true;
  }

  void filterDataByMonth(DateTime date) {
    isFetched.value = false;
    data.value = [];
    int firstDay = DateTime(date.year, date.month, 1).millisecondsSinceEpoch;
    int lastDay = DateTime(date.year, date.month + 1, 1)
        .subtract(const Duration(days: 1))
        .millisecondsSinceEpoch;

    for (int i = 0; i < dataView.length; i++) {
      if (dataView[i].date >= firstDay && dataView[i].date <= lastDay) {
        data.add(dataView[i]);
      }
    }

    isFetched.value = true;
  }

  void onDropdownSelect(String newValue) {
    sortDataValue.value = newValue;
    if (newValue == 'Week') {
      fliterDataByWeek(DateTime.now());
    } else if (newValue == "Day") {
      filterDataByDay(DateTime.now());
    } else if (newValue == "Month") {
      selectedMonth.value = months[DateTime.now().month - 1];
      filterDataByMonth(DateTime.now());
    } else {
      getData();
    }
  }

  Future<void> checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isInternetAvailable.value = true;
      }
    } on SocketException catch (_) {
      isInternetAvailable.value = false;
      isFetched.value = true;
    }
  }

  void applyFilter(DateTime date) {
    if (sortDataValue.value == "Week") {
      fliterDataByWeek(date);
    } else if (sortDataValue.value == "Day") {
      filterDataByDay(date);
    }
  }

  Future<dynamic> selectYear(BuildContext context, int monthIndex) {
    selectedMonth.value = months[monthIndex];
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
                filterDataByMonth(DateTime(dateTime.year, monthIndex + 1));
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}
