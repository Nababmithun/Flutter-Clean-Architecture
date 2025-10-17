import 'package:get/get.dart';

import '../../core/network/dio_client.dart';
import '../../core/services/hive_service.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/me_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../controllers/app_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Core singletons
    if (!Get.isRegistered<DioClient>()) {
      Get.put<DioClient>(DioClient(), permanent: true);
    }
    if (!Get.isRegistered<HiveService>()) {
      Get.put<HiveService>(HiveService.instance, permanent: true);
    }

    // Data & repo
    if (!Get.isRegistered<AuthRemoteDataSource>()) {
      Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSource(Get.find()));
    }
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(
          () => AuthRepositoryImpl(Get.find(), Get.find()));
    }

    // Use cases
    if (!Get.isRegistered<LoginUseCase>()) {
      Get.lazyPut(() => LoginUseCase(Get.find()));
    }
    if (!Get.isRegistered<RegisterUseCase>()) {
      Get.lazyPut(() => RegisterUseCase(Get.find()));
    }
    if (!Get.isRegistered<LogoutUseCase>()) {
      Get.lazyPut(() => LogoutUseCase(Get.find()));
    }
    if (!Get.isRegistered<MeUseCase>()) {
      Get.lazyPut(() => MeUseCase(Get.find()));
    }

    // Controllers
    if (!Get.isRegistered<AppController>()) {
      Get.put(AppController(), permanent: true);
    }
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController(
        loginUseCase: Get.find(),
        registerUseCase: Get.find(),
        logoutUseCase: Get.find(),
        meUseCase: Get.find(),
      ), permanent: true);
    }
    Get.lazyPut(() => HomeController());
  }
}
