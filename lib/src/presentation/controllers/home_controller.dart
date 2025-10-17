import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

  void setIndex(int i) => currentIndex.value = i;

  // Simple in-memory notifications demo
  final notifications = <String>[
    'Welcome to Mega Starter',
    'This is a demo notification',
  ].obs;
}
