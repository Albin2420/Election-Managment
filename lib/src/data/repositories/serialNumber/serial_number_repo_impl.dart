import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/data/model/voterstatus.dart';

import 'package:election_management/src/domain/repositories/serialNumber/serial_number_repo.dart';

class SerialNumberRepoImpl extends SerialNumberRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> getBySerialnumber({
    required int start,
    required int end,
  }) async {
    final url = "${Url.baseUrl}/${Url.serialNumber}?end=$end&start=$start";

    try {
      final response = await DioClient.dio.get(url);

      if (response.statusCode == 200) {
        final voters = response.data
            .map((e) => VoterStatus.fromJson(e))
            .toList();

        return right({"voter_status": voters});
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
