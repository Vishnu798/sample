import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inditab_task/view/screens/my_home_page.dart';
import 'package:inditab_task/view/screens/splash.dart';
import 'package:inditab_task/viewModal/binding/splash_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashPage(), bindings: [
          SplashBinding(),
          // HomePageBinding()
        ]),
        GetPage(name: '/home', page: () => MyHomePage(title: "Inditab Task"))
      ],
    );
  }
}
