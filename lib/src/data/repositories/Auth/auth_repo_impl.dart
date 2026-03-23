import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:election_management/src/domain/repositories/Auth/auth_repo.dart';
import 'package:dio/dio.dart';

class LoginRepoImpl extends LoginRepo {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String userName,
    required String password,
  }) async {
    final url = "${Url.baseUrl}/${Url.login}";
    try {
      final requestData = jsonEncode({
        "username": userName,
        "password": password,
      });

      log("🚀 Sending login request -> $url \ndata :$requestData");

      final response = await _dio.post(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: requestData,
      );

      if (response.statusCode == 200) {
        log("✅ Response Status of $url: ${response.statusCode}");

        final responseBody = response.data as Map<String, dynamic>;

        return right({
          "access_token": responseBody['access'],
          "refresh_token": responseBody['refresh'],
        });
      } else {
        log("❌ Response Status of $url: ${response.statusCode}");
        return Left(Failure(message: "statuscode:${response.statusCode}"));
      }
    } on DioException catch (e) {
      log("❌ Dio error in $url: ${e.message}");

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return left(Failure(message: "Server not reachable"));
      }

      if (e.response != null) {
        log("❌ Dio error response : ${e.response?.data}");
        return left(Failure(message: "${e.response?.data['detail']}"));
      } else {
        return left(Failure(message: "${e.message}"));
      }
    } catch (e) {
      log("💥 Unexpected error in $url : $e:");
      return Left(Failure(message: "$e"));
    }
  }
}
