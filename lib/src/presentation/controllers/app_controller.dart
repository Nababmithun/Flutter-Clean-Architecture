import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/services/hive_service.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'app_title': 'Mega Starter',
          'login': 'Login',
          'register': 'Register',
          'email': 'Email',
          'password': 'Password',
          'name': 'Name',
          'mobile': 'Mobile',
          'gender': 'Gender',
          'logout': 'Logout',
          'home': 'Home',
          'history': 'History',
          'profile': 'Profile',
          'notification': 'Notifications',
          'language': 'Language',
          'bangla': 'Bangla',
          'english': 'English',
          'welcome': 'Welcome',
        },
        'bn_BD': {
          'app_title': 'মেগা স্টার্টার',
          'login': 'লগইন',
          'register': 'রেজিস্ট্রেশন',
          'email': 'ইমেইল',
          'password': 'পাসওয়ার্ড',
          'name': 'নাম',
          'mobile': 'মোবাইল',
          'gender': 'লিঙ্গ',
          'logout': 'লগআউট',
          'home': 'হোম',
          'history': 'হিস্টোরি',
          'profile': 'প্রোফাইল',
          'notification': 'নোটিফিকেশন',
          'language': 'ভাষা',
          'bangla': 'বাংলা',
          'english': 'ইংরেজি',
          'welcome': 'স্বাগতম',
        },
      };
}

class AppController extends GetxController {
  final _locale = const Locale('en', 'US').obs;
  Locale get locale => _locale.value;

  @override
  void onInit() {
    _locale.value = HiveService.instance.getLocale();
    super.onInit();
  }

  void changeToEnglish() {
    _change(const Locale('en', 'US'));
  }

  void changeToBangla() {
    _change(const Locale('bn', 'BD'));
  }

  void _change(Locale l) {
    _locale.value = l;
    Get.updateLocale(l);
    HiveService.instance.saveLocale(l);
  }
}
