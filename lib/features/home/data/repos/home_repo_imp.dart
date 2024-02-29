import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_training/core/errors/failures.dart';
import 'package:firebase_training/core/utils/api_service.dart';
import 'package:firebase_training/features/home/data/repos/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final ApiService apiService;

  HomeRepoImp({required this.apiService});
  @override
  Future<Either<Failures, Response>> sendMessage({required body}) async {
    try {
      var response = await apiService.post(
          body: body, url: 'https://fcm.googleapis.com/fcm/send');
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailures.fromDioError(e),
        );
      }
      return left(
        ServerFailures(
          e.toString(),
        ),
      );
    }
  }
}
