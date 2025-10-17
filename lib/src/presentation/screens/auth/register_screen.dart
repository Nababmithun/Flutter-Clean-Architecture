import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController(text: 'J');
  final _email = TextEditingController(text: 'j@example.com');
  final _password = TextEditingController(text: 'secret');
  final _mobile = TextEditingController(text: '01758248588');
  String? _gender = 'female';

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: Text('register'.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _name, decoration: InputDecoration(labelText: 'name'.tr)),
            const SizedBox(height: 12),
            TextField(controller: _email, decoration: InputDecoration(labelText: 'email'.tr)),
            const SizedBox(height: 12),
            TextField(controller: _password, decoration: InputDecoration(labelText: 'password'.tr)),
            const SizedBox(height: 12),
            TextField(controller: _mobile, decoration: InputDecoration(labelText: 'mobile'.tr)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: InputDecoration(labelText: 'gender'.tr),
              items: const [
                DropdownMenuItem(value: 'male', child: Text('Male')),
                DropdownMenuItem(value: 'female', child: Text('Female')),
              ],
              onChanged: (v) => setState(() => _gender = v),
            ),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: auth.isBusy.value
                      ? null
                      : () async {
                          final ok = await auth.register(
                            name: _name.text,
                            email: _email.text,
                            password: _password.text,
                            mobile: _mobile.text,
                            gender: _gender,
                          );
                          if (ok) {
                            Get.offAllNamed(Routes.home);
                          } else {
                            Get.snackbar('Error', auth.error.value ?? 'Registration failed');
                          }
                        },
                  child: auth.isBusy.value
                      ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text('register'.tr),
                )),
          ],
        ),
      ),
    );
  }
}
