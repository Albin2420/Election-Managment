// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class VotersRepo {
  Future<Either<Failure, Map<String, dynamic>>> fetchAllVoters({
    required int pageNumber,
  });
}
