import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/domain/repositories/statitics/status_repo.dart';

class StatusRepoImpl extends StatussRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> getstatus() async {
    final url = "${Url.baseUrl}/${Url.status}";

    try {
      final response = await DioClient.dio.get(url);

      if (response.statusCode == 200) {
        return right({
          "totalVoters": response.data['total_voters'],
          "totalVoted": response.data['total_voted'],
          "ourVoters": response.data['total_our_voters'],
          "ourVoted": response.data['total_our_voted'],
        });
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
