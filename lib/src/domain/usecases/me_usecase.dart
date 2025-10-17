import '../../core/utils/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class MeUseCase {
  final AuthRepository repo;
  const MeUseCase(this.repo);

  Future<Result<User>> call() {
    return repo.me();
  }
}
