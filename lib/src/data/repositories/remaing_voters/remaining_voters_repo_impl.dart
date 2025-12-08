import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/domain/repositories/remaining_voters_repo/remaining_voters_repo.dart';

class RemainingVotersRepoImpl extends RemainingVotersRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> remaingVoters({
    required bool isvoted,
    required bool isourVoter,
    required int pageNumber,
  }) async {
    final url =
        "${Url.baseUrl}/${Url.fetchAllvoters}/?has_voted=$isvoted&is_our_voter=$isourVoter&page=$pageNumber";

    try {
      final response = await DioClient.dio.get(url);

      if (response.statusCode == 200) {
        final voters = response.data['results']
            .map((e) => VoterModel.fromJson(e))
            .toList();

        return right({
          "searchResult": voters,
          "count": response.data['count'],
          "next": response.data['next'],
          "previous": response.data['previous'],
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
