import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/animations/animations.dart';
import '../../../core/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final _passwordController = TextEditingController();
  bool _confirmChecked = false;

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Account"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Warning Section
            AppAnimations.scaleIn(
              child: Icon(Icons.delete_forever, color: Colors.redAccent, size: 100),
            ),
            const SizedBox(height: 20),
            AppAnimations.fadeIn(
              child: Text(
                "Are you sure you want to delete your account?",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            AppAnimations.fadeIn(
              child: Text(
                "This action cannot be undone. All your data, history, and account information will be permanently deleted.",
                style: TextStyle(color: Colors.red[400], fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 40),

            // Password Confirmation
            AppAnimations.slideUp(
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Enter your password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Checkbox confirm
            AppAnimations.fadeIn(
              child: CheckboxListTile(
                value: _confirmChecked,
                activeColor: Colors.redAccent,
                onChanged: (v) => setState(() => _confirmChecked = v ?? false),
                title: const Text(
                  "I understand that this action is irreversible.",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Delete Button
            AppAnimations.scaleIn(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.delete_outline, color: Colors.white),
                  label: const Text("Delete My Account", style: TextStyle(fontSize: 18, color: Colors.white)),
                  onPressed: !_confirmChecked
                      ? null
                      : () async {
                    final confirm = await _showConfirmDialog(context);
                    if (confirm == true) {
                      // Delete API
                     // final success = await auth.deleteAccount(_passwordController.text);
                      Get.offAllNamed(Routes.login);
                      Get.snackbar("Deleted", "Your account has been permanently removed");
                  /*    if (success) {
                        Get.offAllNamed(Routes.login);
                        Get.snackbar("Deleted", "Your account has been permanently removed");
                      } else {
                        Get.snackbar("Error", auth.error.value ?? "Failed to delete account");
                      }*/
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showConfirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text("Confirm Deletion"),
        content: const Text(
          "Do you really want to delete your account? This action is irreversible and all data will be lost.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
