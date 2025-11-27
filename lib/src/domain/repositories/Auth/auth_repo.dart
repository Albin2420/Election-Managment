// abstact repo

import 'package:dartz/dartz.dart';
import '../../../core/network/failure.dart';

abstract class LoginRepo {
  Future<Either<Failure, Map<String, dynamic>>> login({
    required String userName,
    required String password,
  });
}
