import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/domain/repositories/statitics/statitics_repo.dart';

class StatiticsRepoImpl extends StatiticsRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> getstatus() async {
    final url = "${Url.baseUrl}/${Url.statistics}";

    try {
      final response = await DioClient.dio.get(url);

      if (response.statusCode == 200) {
        return right({});
      } else {
        return Left(Failure(message: "${response.statusMessage}"));
      }
    } on DioException catch (e) {
      log("❌ Dio error: ${e.message}");
      return left(
        Failure(
          message:
              e.response?.data?['detail']?.toString() ??
              "Something went wrong!",
        ),
      );
    } catch (e) {
      log("💥 Unexpected error: $e");
      return left(Failure(message: "$e"));
    }
  }
}
