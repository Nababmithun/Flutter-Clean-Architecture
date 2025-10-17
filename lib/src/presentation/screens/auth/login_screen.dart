import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(text: 'j@example.com');
  final _password = TextEditingController(text: 'secret');
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: Text('login'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(labelText: 'email'.tr),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _password,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'password'.tr,
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: auth.isBusy.value
                      ? null
                      : () async {
                          final ok = await auth.login(_email.text, _password.text);
                          if (ok) {
                            Get.offAllNamed(Routes.home);
                          } else {
                            Get.snackbar('Error', auth.error.value ?? 'Login failed');
                          }
                        },
                  child: auth.isBusy.value
                      ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text('login'.tr),
                )),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Get.toNamed(Routes.register),
              child: Text('register'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
