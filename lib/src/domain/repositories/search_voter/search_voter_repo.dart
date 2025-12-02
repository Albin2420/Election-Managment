// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class SearchVoterRepo {
  Future<Either<Failure, Map<String, dynamic>>> searchVoters({
    required String key,
  });
}
