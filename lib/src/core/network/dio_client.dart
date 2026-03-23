import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:election_management/src/core/url.dart';
import 'package:election_management/src/data/services/storage_service.dart';
import 'package:election_management/src/presentation/controller/AppstartupController/app_startup_controller.dart';
import 'package:get/get.dart';

class DioClient {
  static final Dio dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await StorageService.getAccessToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Content-Type'] = 'application/json';
          log("🌍 API -> ${options.method} URL: ${options.uri}");

          return handler.next(options);
        },

        onError: (DioException error, handler) async {
          log("❌ API Error Status: ${error.response?.statusCode}");

          if (error.response?.statusCode == 403) {
            log("🔴 Token expired — Attempting refresh...");

            final refreshed = await _handleTokenRefresh();

            if (refreshed) {
              final RequestOptions requestOptions = error.requestOptions;
              final response = await dio.fetch(requestOptions);

              return handler.resolve(response);
            } else {
              log("🚪 Refresh failed → Logout user");
              final ctrl = Get.find<AppStartupController>();
              ctrl.logout();

              return handler.next(error);
            }
          }

          return handler.next(error);
        },

        onResponse: (response, handler) {
          log("✅ API Response: ${response.statusCode}");
          return handler.next(response);
        },
      ),
    );

  static Future<bool> _handleTokenRefresh() async {
    try {
      final refreshToken = await StorageService.getRefreshToken();

      if (refreshToken == null) {
        log("⚠ No refresh token available");
        return false;
      }

      log("🔄 Calling Refresh Token API...");

      final response = await dio.post(
        "${Url.baseUrl}/${Url.refreshToken}",
        data: {"refresh": refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccess = response.data["access"] ?? "";

        if (newAccess.isNotEmpty) {
          await StorageService.saveTokens(accessToken: newAccess);
          log("✔ Token Refresh Success");
          return true;
        }
      } else {
        log("❌ Refresh API failed");
        return false;
      }
      return false;
    } catch (e) {
      log("💥 Refresh Token Exception: $e");
      return false;
    }
  }
}
