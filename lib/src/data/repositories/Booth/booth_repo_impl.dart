import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:election_management/src/core/network/dio_client.dart';
import 'package:election_management/src/core/network/failure.dart';
import 'package:election_management/src/core/url.dart';
import 'package:dio/dio.dart';
import 'package:election_management/src/domain/repositories/Booth/booth_repo.dart';

class BoothRepoImpl extends BoothRepo {
  @override
  Future<Either<Failure, Map<String, dynamic>>> getMyboothDetails() async {
    final url = "${Url.baseUrl}/${Url.myBooth}";

    try {
      final response = await DioClient.dio.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final item = data[0];

        return right({
          "lsg_booth": item['id'],
          "wardNumber": item['ward']['number'],
          "boothNumber": item['number'],
          "totalVoters": item['total_voters'],
          "boothName": item['name'],
          "wardName": item['ward']['name'],
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
