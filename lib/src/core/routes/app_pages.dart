import 'package:get/get.dart';

import '../../presentation/bindings/auth_binding.dart';
import '../../presentation/bindings/home_binding.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/home/home_shell.dart';
import '../../presentation/screens/home/history_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: HomeBinding(), // ensures core deps are ready
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeShell(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.history,
      page: () => const HistoryScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
      binding: HomeBinding(),
    ),
  ];
}
