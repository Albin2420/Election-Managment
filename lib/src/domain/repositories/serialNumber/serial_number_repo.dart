// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class SerialNumberRepo {
  Future<Either<Failure, Map<String, dynamic>>> getBySerialnumber({
    required int start,
    required int end,
  });
}
