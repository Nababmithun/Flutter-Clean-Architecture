import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/home_controller.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import '../profile/profile_screen.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Get.find<HomeController>();
    final app = Get.find<AppController>();

    final pages = <Widget>[
      const HomeScreen(),
      const HistoryScreen(),
      const ProfileScreen(),
    ];

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('app_title'.tr),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.language),
                onSelected: (v) {
                  if (v == 'bn') app.changeToBangla();
                  if (v == 'en') app.changeToEnglish();
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'bn', child: Text('bangla'.tr)),
                  PopupMenuItem(value: 'en', child: Text('english'.tr)),
                ],
              ),
            ],
          ),
          body: IndexedStack(index: home.currentIndex.value, children: pages),
          bottomNavigationBar: NavigationBar(
            selectedIndex: home.currentIndex.value,
            onDestinationSelected: home.setIndex,
            destinations: [
              NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: 'home'.tr),
              NavigationDestination(icon: const Icon(Icons.history), label: 'history'.tr),
              NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: 'profile'.tr),
            ],
          ),
        ));
  }
}
