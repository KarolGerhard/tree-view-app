import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/home/home_binding.dart';
import 'app/modules/home/home_page.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialBinding: HomeBinding(),
      home: HomePage(),
      getPages: AppPages.pages,
    );
  }
}