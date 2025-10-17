import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _NotificationBar(controller: c),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('welcome'.tr, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                const Text('This is a clean starter with MVVM + GetX + Dio + Hive.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationBar extends StatelessWidget {
  final HomeController controller;
  const _NotificationBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              const Icon(Icons.notifications_active_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  controller.notifications.isNotEmpty ? controller.notifications.first : 'notification'.tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  controller.notifications.shuffle();
                  controller.notifications.refresh();
                },
              )
            ],
          ),
        ));
  }
}
