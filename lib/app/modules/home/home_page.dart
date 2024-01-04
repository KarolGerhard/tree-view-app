import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tree_view_desafio/app/modules/assets/presentation/utils/theme.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  // final String assetName = 'assets/images/logo-tractian.svg';
  final Widget svgIcon = SvgPicture.asset(
  'assets/images/logo-tractian.svg',
  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  semanticsLabel: 'Tractian Logo'
 
);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: svgIcon,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () => Get.toNamed('/assets', arguments: 'jaguar'),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ThemeApp.theme.primaryColor,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.category, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Jaguar Unit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                GestureDetector(
                  onTap: () => Get.toNamed('/assets', arguments: 'tobias'),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 100, 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ThemeApp.theme.primaryColor,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.category, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Tobias Unit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                GestureDetector(
                  onTap: () => Get.toNamed('/assets', arguments: "apex"),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ThemeApp.theme.primaryColor,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.category, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Apex Unit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                     
                 
                
              //   FilledButton.icon(
              //       onPressed: () {
              //         debugPrint("clicou");
              //         Get.toNamed('/assets');
              //       },
              //       icon: const Icon(Icons.account_box),
              //       label: const Text("Jaguar Unit")),
              ], 
            
            ),
          ),
        ),
      ),
    );
  }
}
