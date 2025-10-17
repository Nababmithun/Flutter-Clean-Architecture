import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/animations/animations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = List.generate(
      10,
          (i) => {
        "title": "Notification ${i + 1}",
        "subtitle": "This is a message for notification ${i + 1}",
        "time": "${i + 1} mins ago"
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        itemBuilder: (_, i) {
          final n = notifications[i];
          return AppAnimations.fadeIn(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.notifications, color: Colors.teal),
                title: Text(n['title']!),
                subtitle: Text(n['subtitle']!),
                trailing: Text(n['time']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            ),
          );
        },
      ),
    );
  }
}
