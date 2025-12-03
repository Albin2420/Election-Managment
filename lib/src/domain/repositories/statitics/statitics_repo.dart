// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class StatiticsRepo {
  Future<Either<Failure, Map<String, dynamic>>> getstatus();
}
