import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/animations/animations.dart';
import '../../../core/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _mobile = TextEditingController();
  String? _gender = 'female';

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: AppAnimations.scaleIn(
                  child: Icon(Icons.person_add_alt_1, size: 100, color: Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(height: 16),
              AppAnimations.fadeIn(
                child: Text(
                  'Create Account 🚀',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              _buildInput('Full Name', Icons.person_outline, _name),
              const SizedBox(height: 16),
              _buildInput('Email', Icons.email_outlined, _email),
              const SizedBox(height: 16),
              _buildInput('Password', Icons.lock_outline, _password, obscure: true),
              const SizedBox(height: 16),
              _buildInput('Mobile', Icons.phone_android, _mobile),
              const SizedBox(height: 16),
              AppAnimations.slideUp(
                child: DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    prefixIcon: const Icon(Icons.wc),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'male', child: Text('Male')),
                    DropdownMenuItem(value: 'female', child: Text('Female')),
                  ],
                  onChanged: (v) => setState(() => _gender = v),
                ),
              ),
              const SizedBox(height: 32),
              Obx(() => AppAnimations.fadeIn(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
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
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Register', style: TextStyle(fontSize: 18)),
                  ),
                ),
              )),
              const SizedBox(height: 16),
              AppAnimations.fadeIn(
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Already have an account? Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, IconData icon, TextEditingController controller, {bool obscure = false}) {
    return AppAnimations.slideUp(
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
