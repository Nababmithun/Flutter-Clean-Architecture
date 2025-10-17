import 'package:clean_architecture_mvvm/src/presentation/screens/changepassword/change_password_screen.dart';
import 'package:clean_architecture_mvvm/src/presentation/screens/deleteaccount/delete_account_screen.dart';
import 'package:clean_architecture_mvvm/src/presentation/screens/editprofile/edit_profile_screen.dart';
import 'package:clean_architecture_mvvm/src/presentation/screens/notification/notifications_screen.dart';
import 'package:clean_architecture_mvvm/src/presentation/screens/subscription/subscription_screen.dart';
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

    GetPage(
      name: Routes.editProfile,
      page: () => const EditProfileScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePasswordScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.subscription,
      page: () => const SubscriptionScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.notifications,
      page: () => const NotificationsScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.deleteAccount,
      page: () => const DeleteAccountScreen(),
      binding: HomeBinding(),
    ),
  ];
}
