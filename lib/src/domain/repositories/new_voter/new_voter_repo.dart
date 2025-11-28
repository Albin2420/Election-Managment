// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class NewVoterRepo {
  Future<Either<Failure, Map<String, dynamic>>> createNewvoter({
    required dynamic newVoter,
  });
}
