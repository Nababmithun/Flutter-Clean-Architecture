import 'package:clean_architecture_mvvm/src/core/network/internet_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/core/config/app_config.dart';
import 'src/core/routes/app_pages.dart';
import 'src/core/routes/app_routes.dart';
import 'src/core/services/hive_service.dart';
import 'src/presentation/controllers/app_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // open 'app' box
  await HiveService.init();
  //Start listening for connectivity
  InternetChecker.startListening();
  runApp(const MegaStarter());
}

class MegaStarter extends StatelessWidget {
  const MegaStarter({super.key});

  @override
  Widget build(BuildContext context) {
    final initialLocale = HiveService.instance.getLocale();
    return GetMaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      locale: initialLocale,
      translations: AppTranslations(),
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'BD'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.teal,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.teal,
      ),
    );
  }
}
