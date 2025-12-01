// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class IsOurVoterRepo {
  Future<Either<Failure, Map<String, dynamic>>> ourVoter({
    required dynamic ourVoter,
  });
}
