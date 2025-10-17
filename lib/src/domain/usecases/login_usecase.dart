import '../../core/utils/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repo;
  const LoginUseCase(this.repo);

  Future<Result<(String token, User user)>> call(String email, String password) {
    return repo.login(email: email, password: password);
  }
}
