import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:election_management/src/core/url.dart';
import 'package:get/get.dart';
import 'package:election_management/src/presentation/controller/AppstartupController/app_startup_controller.dart';

class DioClient {
  static final Dio dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final ctrl = Get.find<AppStartupController>();
          final token = ctrl.accessToken.value;

          log("my data ----->:${options.data}");

          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Content-Type'] = 'application/json';
          log("🌍 API -> ${options.method} URL: ${options.uri}");

          return handler.next(options);
        },

        onError: (DioException error, handler) async {
          log("❌ API Error Status: ${error.response}");

          if (error.response?.statusCode == 403) {
            log("🔴 Token expired — Attempting refresh...");

            final refreshed = await _handleTokenRefresh();

            if (refreshed) {
              // 🔁 Retry last failed request
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

  /// 🔄 Token Refresh Logic
  static Future<bool> _handleTokenRefresh() async {
    try {
      final ctrl = Get.find<AppStartupController>();
      final refreshToken = ctrl.refreshToken.value;

      if (refreshToken.isEmpty) {
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
          ctrl.accessToken.value = newAccess;
          await ctrl.saveTokens(accessTk: newAccess);
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
