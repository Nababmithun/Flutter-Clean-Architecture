import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const _boxName = 'app';
  static const _kToken = 'token';
  static const _kLocale = 'locale';

  static late Box _box;
  static HiveService instance = HiveService._internal();

  HiveService._internal();

  static Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  // Auth token
  String? get token => _box.get(_kToken);
  Future<void> saveToken(String? value) async {
    if (value == null) {
      await _box.delete(_kToken);
    } else {
      await _box.put(_kToken, value);
    }
  }

  // Locale (e.g., 'en_US' | 'bn_BD')
  Future<void> saveLocale(Locale locale) async {
    await _box.put(_kLocale, '${locale.languageCode}_${locale.countryCode ?? ''}');
  }

  Locale getLocale() {
    final raw = _box.get(_kLocale, defaultValue: 'en_US') as String;
    final parts = raw.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : null);
  }
}
