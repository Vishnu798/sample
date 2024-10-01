import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inditab_task/viewModal/controller/home_controller.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key, required this.controller});
  final HomePageController controller;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Internet Connection",
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
          ),
          IconButton(
              onPressed: () {
                controller.getData();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
    );
  }
}
