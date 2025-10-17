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
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Core singletons
    Get.put<DioClient>(DioClient(), permanent: true);
    Get.put<HiveService>(HiveService.instance, permanent: true);

    // Data sources & repo
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSource(Get.find()));
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find(), Get.find()));

    // Use cases
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => RegisterUseCase(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.lazyPut(() => MeUseCase(Get.find()));

    // Controller
    Get.lazyPut(() => AuthController(
          loginUseCase: Get.find(),
          registerUseCase: Get.find(),
          logoutUseCase: Get.find(),
          meUseCase: Get.find(),
        ));
  }
}
