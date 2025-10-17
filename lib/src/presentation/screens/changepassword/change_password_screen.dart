import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/animations/animations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPass = TextEditingController();
  final _newPass = TextEditingController();
  final _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildPasswordField("Old Password", _oldPass),
            const SizedBox(height: 16),
            _buildPasswordField("New Password", _newPass),
            const SizedBox(height: 16),
            _buildPasswordField("Confirm Password", _confirmPass),
            const SizedBox(height: 32),
            AppAnimations.scaleIn(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.lock_reset),
                  label: const Text("Update Password", style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    if (_newPass.text == _confirmPass.text) {
                      Get.snackbar("Success", "Password updated successfully");
                    } else {
                      Get.snackbar("Error", "Passwords do not match");
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

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return AppAnimations.slideUp(
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock_outline),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
