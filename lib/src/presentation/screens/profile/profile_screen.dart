import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/animations/animations.dart';
import '../../../core/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("🌐 Choose Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("English"),
                onTap: () {
                  Get.updateLocale(const Locale('en', 'US'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("বাংলা"),
                onTap: () {
                  Get.updateLocale(const Locale('bn', 'BD'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      body: Obx(() {
        final u = auth.user.value;
        return u == null
            ? const Center(child: Text('Not logged in'))
            : SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ===== Avatar & Name =====
              AppAnimations.scaleIn(
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Text(
                    u.name.isNotEmpty ? u.name[0].toUpperCase() : '?',
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AppAnimations.fadeIn(
                child: Text(
                  u.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Text(u.email, style: Theme.of(context).textTheme.bodyMedium),
              const Divider(height: 40),

              // ===== Profile Options =====
              AppAnimations.slideUp(
                child: _buildTile(
                  icon: Icons.edit_outlined,
                  title: "Edit Profile",
                  subtitle: "Update your profile details",
                  onTap: () => Get.toNamed(Routes.editProfile),
                ),
              ),
              AppAnimations.slideUp(
                child: _buildTile(
                  icon: Icons.lock_outline,
                  title: "Change Password",
                  subtitle: "Update your account password",
                  onTap: () => Get.toNamed(Routes.changePassword),
                ),
              ),
              AppAnimations.slideUp(
                child: _buildTile(
                  icon: Icons.language,
                  title: "Language Settings",
                  subtitle: "Switch between English & Bangla",
                  onTap: () => _showLanguageDialog(context),
                ),
              ),
              AppAnimations.slideUp(
                child: _buildTile(
                  icon: Icons.subscriptions_outlined,
                  title: "Subscription",
                  subtitle: "Manage your plan and payments",
                  onTap: () => Get.toNamed(Routes.subscription),
                ),
              ),
              AppAnimations.slideUp(
                child: _buildTile(
                  icon: Icons.delete_outline,
                  title: "Delete Account",
                  subtitle: "Permanently remove your account",
                  onTap: () async {
                    final confirm = await _confirmDialog(
                      context,
                      "Are you sure?",
                      "This action is irreversible!",
                    );
                    if (confirm == true) {
                      // TODO: Call delete account API
                      Get.snackbar("Deleted", "Your account has been removed");
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),

              // Logout Button (Text now white)
              AppAnimations.fadeIn(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () async {
                    final ok = await auth.logout();
                    if (ok) {
                      Get.offAllNamed(Routes.login);
                    } else {
                      Get.snackbar('Error', auth.error.value ?? 'Logout failed');
                    }
                  },
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 18, color: Colors.white), //white text
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Future<bool?> _confirmDialog(BuildContext context, String title, String msg) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text("Confirm")),
        ],
      ),
    );
  }
}
