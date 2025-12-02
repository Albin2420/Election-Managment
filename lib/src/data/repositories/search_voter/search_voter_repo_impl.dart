import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/data/model/votermodel.dart';

import 'package:election_management/src/domain/repositories/search_voter/search_voter_repo.dart';

class SearchVoterRepoImpl extends SearchVoterRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> searchVoters({
    required String key,
  }) async {
    final url = "${Url.baseUrl}/${Url.fetchAllvoters}/?q=$key";

    try {
      final response = await DioClient.dio.get(url);

      if (response.statusCode == 200) {
        final voters = response.data['results']
            .map((e) => VoterModel.fromJson(e))
            .toList();

        return right({"searchResult": voters});
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
