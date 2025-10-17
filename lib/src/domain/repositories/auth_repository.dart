import '../../core/utils/result.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Result<(String token, User user)>> login({
    required String email,
    required String password,
  });

  Future<Result<(String token, User user)>> register({
    required String name,
    required String email,
    required String password,
    String? mobile,
    String? gender,
  });

  Future<Result<void>> logout();

  Future<Result<User>> me();
}
