import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_training/core/errors/failures.dart';

abstract class HomeRepo {
  Future<Either<Failures, Response>> sendMessage(
      {required Map<String, dynamic> body});
}
