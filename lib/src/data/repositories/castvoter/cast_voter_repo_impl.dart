import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/data/model/votermodel.dart';

import 'package:election_management/src/domain/repositories/castvoter/cast_voter_repo.dart';

class CastVoterRepoImpl extends CastVoterRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> markasCastVoter({
    required List<String> list,
  }) async {
    final url = "${Url.baseUrl}/${Url.castVoter}";

    try {
      final requestData = jsonEncode({"voter_id": list, "value": true});

      log("📤 Sending Request Data:\n$requestData");

      final response = await DioClient.dio.post(url, data: requestData);

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
