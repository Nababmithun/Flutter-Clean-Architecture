import '../../core/utils/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repo;
  const RegisterUseCase(this.repo);

  Future<Result<(String token, User user)>> call({
    required String name,
    required String email,
    required String password,
    String? mobile,
    String? gender,
  }) {
    return repo.register(
      name: name,
      email: email,
      password: password,
      mobile: mobile,
      gender: gender,
    );
  }
}
