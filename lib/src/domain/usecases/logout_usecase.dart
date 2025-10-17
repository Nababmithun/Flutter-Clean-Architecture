import '../../core/utils/result.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repo;
  const LogoutUseCase(this.repo);

  Future<Result<void>> call() {
    return repo.logout();
  }
}
