import 'package:get/get.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/me_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final MeUseCase meUseCase;

  AuthController({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.meUseCase,
  });

  final Rxn<User> user = Rxn<User>();
  final isBusy = false.obs;
  final error = RxnString();

  Future<bool> login(String email, String password) async {
    isBusy.value = true;
    error.value = null;
    final r = await loginUseCase(email, password);
    isBusy.value = false;
    return r.when(
      ok: (pair) {
        user.value = pair.$2;
        return true;
      },
      err: (msg) {
        error.value = msg;
        return false;
      },
    );
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String? mobile,
    String? gender,
  }) async {
    isBusy.value = true;
    error.value = null;
    final r = await registerUseCase(
      name: name,
      email: email,
      password: password,
      mobile: mobile,
      gender: gender,
    );
    isBusy.value = false;
    return r.when(
      ok: (pair) {
        user.value = pair.$2;
        return true;
      },
      err: (msg) {
        error.value = msg;
        return false;
      },
    );
  }

  Future<void> fetchMe() async {
    final r = await meUseCase();
    r.when(ok: (u) => user.value = u, err: (msg) => error.value = msg);
  }

  Future<bool> logout() async {
    final r = await logoutUseCase();
    return r.when(ok: (_) => true, err: (msg) {
      error.value = msg;
      return false;
    });
  }
}
