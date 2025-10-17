import 'package:dio/dio.dart';

import '../../core/services/hive_service.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final HiveService hive;
  AuthRepositoryImpl(this.remote, this.hive);

  @override
  Future<Result<(String token, User user)>> login({
    required String email,
    required String password,
  }) async {
    try {
      final r = await remote.login(email, password);
      final token = r.data['token'] as String?;
      final user = User.fromJson(r.data['user'] as Map<String, dynamic>);
      if (token == null) return const Err('Missing token');
      await hive.saveToken(token);
      return Ok((token, user));
    } on DioException catch (e) {
      final msg = e.response?.data?['message']?.toString() ?? e.message ?? 'Login failed';
      return Err(msg);
    } catch (e) {
      return Err('Login failed: $e');
    }
  }

  @override
  Future<Result<(String token, User user)>> register({
    required String name,
    required String email,
    required String password,
    String? mobile,
    String? gender,
  }) async {
    try {
      final r = await remote.register(
        name: name,
        email: email,
        password: password,
        mobile: mobile,
        gender: gender,
      );
      final token = r.data['token'] as String?;
      final user = User.fromJson(r.data['user'] as Map<String, dynamic>);
      if (token == null) return const Err('Missing token');
      await hive.saveToken(token);
      return Ok((token, user));
    } on DioException catch (e) {
      final msg = e.response?.data?['message']?.toString() ?? e.message ?? 'Register failed';
      return Err(msg);
    } catch (e) {
      return Err('Register failed: $e');
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await remote.logout();
      await hive.saveToken(null);
      return const Ok(null);
    } on DioException catch (e) {
      final msg = e.response?.data?['message']?.toString() ?? e.message ?? 'Logout failed';
      return Err(msg);
    } catch (e) {
      return Err('Logout failed: $e');
    }
  }

  @override
  Future<Result<User>> me() async {
    try {
      final r = await remote.me();
      final user = User.fromJson(r.data as Map<String, dynamic>);
      return Ok(user);
    } on DioException catch (e) {
      final msg = e.response?.data?['message']?.toString() ?? e.message ?? 'Profile fetch failed';
      return Err(msg);
    } catch (e) {
      return Err('Profile fetch failed: $e');
    }
  }
}
