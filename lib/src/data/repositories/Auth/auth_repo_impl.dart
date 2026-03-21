import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:election_management/src/domain/repositories/Auth/auth_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Url.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  @override
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String userName,
    required String password,
  }) async {
    final url = Url.login;

    try {
      final requestData = jsonEncode({
        "username": userName,
        "password": password,
      });

      log("🌍 LOGIN API -> POST ${_dio.options.baseUrl}$url");

      final response = await _dio.post(url, data: requestData);

      if (response.statusCode == 200) {
        log("✅ Login Success");

        final responseBody = response.data as Map<String, dynamic>;

        return right({
          "access_token": responseBody['access'],
          "refresh_token": responseBody['refresh'],
        });
      } else {
        log("❌ Status: ${response.statusCode}");
        return Left(Failure(message: "Status code: ${response.statusCode}"));
      }
    } on DioException catch (e) {
      log("❌ Dio error: ${e.message}");

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        log("⏳ Login timeout (heavy API / server slow)");
        return left(
          Failure(message: "Server not reachable. Please try again."),
        );
      }

      if (e.type == DioExceptionType.unknown) {
        log("🌐 No internet connection");
        return left(Failure(message: "No internet connection."));
      }

      if (e.response != null) {
        log("❌ Server response: ${e.response?.data}");

        final message =
            e.response?.data?['detail'] ??
            e.response?.data?['message'] ??
            "Login failed";

        return left(Failure(message: message));
      }

      return left(Failure(message: e.message ?? "Unexpected error"));
    } catch (e) {
      log("💥 Unexpected error: $e");
      return Left(Failure(message: "Something went wrong"));
    }
  }
}
