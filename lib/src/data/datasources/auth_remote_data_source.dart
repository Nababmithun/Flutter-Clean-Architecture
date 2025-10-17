import 'package:dio/dio.dart';

import '../../core/network/api_endpoints.dart';
import '../../core/network/dio_client.dart';

class AuthRemoteDataSource {
  final DioClient client;
  AuthRemoteDataSource(this.client);

  Future<Response<dynamic>> login(String email, String password) {
    return client.dio.post(ApiEndpoints.login, data: {
      'email': email,
      'password': password,
    });
  }

  Future<Response<dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? mobile,
    String? gender,
  }) {
    return client.dio.post(ApiEndpoints.register, data: {
      'name': name,
      'email': email,
      'password': password,
      if (mobile != null) 'mobile': mobile,
      if (gender != null) 'gender': gender,
    });
  }

  Future<Response<dynamic>> logout() {
    return client.dio.post(ApiEndpoints.logout);
  }

  Future<Response<dynamic>> me() {
    return client.dio.get(ApiEndpoints.me);
  }
}
