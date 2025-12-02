import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/domain/repositories/byserialnumber/by_serial_number_repo.dart';

class BySerialNumberRepoImpl extends BySerialNumberRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> getVotersbyserialNum({
    required dynamic list,
  }) async {
    final url = "${Url.baseUrl}/${Url.byserialNumber}";

    try {
      final requestData = jsonEncode({"serial_numbers": list});

      log("📤 Sending Request Data:\n$requestData");

      final response = await DioClient.dio.post(url, data: requestData);

      if (response.statusCode == 200) {
        final data = response.data as List;
        final voters = data.map((e) => VoterModel.fromJson(e)).toList();

        return right({"votersbySerial": voters});
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
