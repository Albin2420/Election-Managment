import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/domain/repositories/voters/voters_repo.dart';
import 'package:get/get.dart';

class VotersRepoImpl extends VotersRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchAllVoters({
    required int pageNumber,
  }) async {
    final url = "${Url.baseUrl}/${Url.fetchAllvoters}/?page=$pageNumber";

    try {
      final response = await DioClient.dio.get(url);
      if (response.statusCode == 200) {
        final results = response.data['results'] as List;

        final List<VoterModel> voters = results
            .map((item) => VoterModel.fromJson(item as Map<String, dynamic>))
            .toList();

        return right({
          "isTherenayNext": response.data['next'] != null ? true : false,
          "voters": voters,
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
