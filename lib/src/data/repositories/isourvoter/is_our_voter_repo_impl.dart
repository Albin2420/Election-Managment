import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/domain/repositories/isourvoter/is_our_voter_repo.dart';

class IsOurVoterRepoImpl extends IsOurVoterRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> ourVoter({
    required dynamic ourVoter,
  }) async {
    final url = "${Url.baseUrl}/${Url.isOurvoter}";

    try {
      log("📤 Sending Request Data:\n$ourVoter");

      final response = await DioClient.dio.post(url, data: ourVoter);
      if (response.statusCode == 201) {
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
