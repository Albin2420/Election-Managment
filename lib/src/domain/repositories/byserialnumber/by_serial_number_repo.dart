// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class BySerialNumberRepo {
  Future<Either<Failure, Map<String, dynamic>>> getVotersbyserialNum({
    required dynamic list,
  });
}
