import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/animations/animations.dart';
import '../../controllers/auth_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  String? _gender;

  @override
  void initState() {
    super.initState();
    final user = Get.find<AuthController>().user.value;
    _name.text = user?.name ?? '';
    _email.text = user?.email ?? '';
    _mobile.text = user?.mobile ?? '';
    _gender = user?.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AppAnimations.fadeIn(
              child: CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50, color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 30),
            _buildField("Full Name", _name, Icons.person_outline),
            const SizedBox(height: 16),
            _buildField("Email", _email, Icons.email_outlined),
            const SizedBox(height: 16),
            _buildField("Mobile", _mobile, Icons.phone_android),
            const SizedBox(height: 16),
            AppAnimations.slideUp(
              child: DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(
                  labelText: "Gender",
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
            AppAnimations.scaleIn(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.snackbar("Profile Updated", "Your profile was updated successfully");
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Save Changes", style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, IconData icon) {
    return AppAnimations.slideUp(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
