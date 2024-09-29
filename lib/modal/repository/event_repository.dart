import 'dart:convert';

import 'package:inditab_task/modal/api/api_service.dart';
import 'package:inditab_task/modal/modals/event_model.dart';

class EventRepository {
 final ApiService _apiService = ApiService();
  Future<List<Data>> getData() async {
    try {
      final response = await _apiService.fetchData();
      List<Data> dataList = [];
      if (response.statusCode == 200) {
        Event eventData = Event.fromJson(jsonDecode(response.body));
        if (eventData.status) {
          dataList = eventData.data;
        }
      }
      return dataList;
    } catch (e) {
      throw Exception("Error in fetching data : $e");
    }
  }
}
