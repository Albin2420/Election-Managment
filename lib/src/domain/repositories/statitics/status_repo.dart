// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class StatussRepo {
  Future<Either<Failure, Map<String, dynamic>>> getstatus();
}
