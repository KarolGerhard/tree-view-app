import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: FilledButton.icon(
              onPressed: () {
                debugPrint("clicou");
                Get.toNamed('/assets');
              },
              icon: const Icon(Icons.account_box),
              label: const Text("Jaguar Unit")),
        ),
      ),
    );
  }
}
