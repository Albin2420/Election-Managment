// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class RemainingVotersRepo {
  Future<Either<Failure, Map<String, dynamic>>> remaingVoters({
    bool? isourVoter,
    bool? isvoted,
  });
}
