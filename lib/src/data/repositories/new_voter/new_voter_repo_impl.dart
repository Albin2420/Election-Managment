import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/domain/repositories/new_voter/new_voter_repo.dart';

class NewVoterRepoImpl extends NewVoterRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> createNewvoter({
    required dynamic newVoter,
  }) async {
    final url = "${Url.baseUrl}/${Url.newvoter}";

    try {
      log("📤 Sending Request Data:\n$newVoter");

      final response = await DioClient.dio.post(url, data: newVoter);
      if (response.statusCode == 201) {
        return right(response.data as Map<String, dynamic>);
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
