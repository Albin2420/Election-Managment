import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class CastVoterRepo {
  Future<Either<Failure, Map<String, dynamic>>> markasCastVoter({
    required List<String> list,
  });
}
