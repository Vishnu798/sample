import 'package:flutter/widgets.dart';
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
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    sortDataValue.value = "Sort by";
    List<Data> dataList = await _repository.getData();
    if (dataList.isNotEmpty) {
      data.value = dataList;
      dataView.value = dataList;
    }
    isFetched.value = true;
  }

  void fliterDataByWeek(DateTime date) {
    // data.value = [];
    isFetched.value = false;
    int curTime = date.millisecondsSinceEpoch;
    int currentTimeAfterWeek =
        date.add(const Duration(days: 7)).millisecondsSinceEpoch;
    selectedDate.value = currentTimeAfterWeek;
    textEditingController.text =
        '${DateFormat('d MMM, y').format(DateTime.fromMillisecondsSinceEpoch(curTime))} to ${DateFormat('d MMM, y').format(DateTime.fromMillisecondsSinceEpoch(currentTimeAfterWeek))}';
    List<Data> sortdData = [];
    for (int i = 0; i < dataView.length; i++) {
      if (dataView[i].date >= curTime &&
          dataView[i].date <= currentTimeAfterWeek) {
        sortdData.add(dataView[i]);
      }
    }
    data.value = sortdData;
    isFetched.value = true;
  }

  filterDataByDay(DateTime date) {
    isFetched.value = false;
    int curTime = date.millisecondsSinceEpoch;
    textEditingController.text = DateFormat('d MMM, y')
        .format(DateTime.fromMillisecondsSinceEpoch(curTime));
    List<Data> sortdData = [];
    for (int i = 0; i < dataView.length; i++) {
      if (dataView[i].date == curTime) {
        sortdData.add(dataView[i]);
      }
    }
    data.value = sortdData;
    isFetched.value = true;
  }

  filterDataByMonth(DateTime date) {
    isFetched.value = false;
    int firstDay = DateTime(date.year, date.month, 1).millisecondsSinceEpoch;
    int lastDay = DateTime(date.year, date.month + 1, 1)
        .subtract(const Duration(days: 1))
        .millisecondsSinceEpoch;

    List<Data> sortdData = [];
    for (int i = 0; i < dataView.length; i++) {
      if (dataView[i].date >= firstDay && dataView[i].date <= lastDay) {
        sortdData.add(dataView[i]);
      }
    }
    data.value = sortdData;
    isFetched.value = true;
  }

  onDropdownSelect(String newValue) {
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
}
