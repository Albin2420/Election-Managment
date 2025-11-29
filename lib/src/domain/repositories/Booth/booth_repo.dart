// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class BoothRepo {
  Future<Either<Failure, Map<String, dynamic>>> getMyboothDetails();
}
