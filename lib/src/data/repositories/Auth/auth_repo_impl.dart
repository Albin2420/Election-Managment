import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/core/network/error_handler.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:election_management/src/domain/repositories/Auth/auth_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String userName,
    required String password,
  }) async {
    final url = "${Url.baseUrl}/${Url.login}";

    try {
      final requestData = {"username": userName, "password": password};

      log("🌍 API -> POST URL: $url \ndata : $requestData");

      final response = await _dio.post(url, data: requestData);

      if (response.statusCode == 200) {
        final data = response.data;

        return right({
          "access_token": data['access'],
          "refresh_token": data['refresh'],
        });
      }

      return left(
        Failure(code: response.statusCode ?? -1, message: "Unexpected error"),
      );
    } on DioException catch (e) {
      return left(handleDioError(e));
    } catch (e) {
      log("💥 Unexpected error -> $e");

      return const Left(Failure(code: -1, message: "Something went wrong"));
    }
  }
}
