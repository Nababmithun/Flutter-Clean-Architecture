import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Obx(() {
      final u = auth.user.value;
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (u != null) ...[
            CircleAvatar(radius: 40, child: Text(u.name.isNotEmpty ? u.name[0] : '?')),
            const SizedBox(height: 12),
            Text(u.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(u.email),
            const Divider(height: 32),
          ] else
            const Text('Not logged in'),
          ElevatedButton.icon(
            onPressed: () async {
              final ok = await auth.logout();
              if (ok) {
                Get.offAllNamed(Routes.login);
              } else {
                Get.snackbar('Error', auth.error.value ?? 'Logout failed');
              }
            },
            icon: const Icon(Icons.logout),
            label: Text('logout'.tr),
          ),
        ],
      );
    });
  }
}
