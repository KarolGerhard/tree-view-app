import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/home/home_binding.dart';
import 'app/modules/home/home_page.dart';
import 'app/routes/app_pages.dart';
import 'app/modules/assets/presentation/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeApp.theme,
      initialBinding: HomeBinding(),
      home: HomePage(),
      getPages: AppPages.pages,
    );
  }
}