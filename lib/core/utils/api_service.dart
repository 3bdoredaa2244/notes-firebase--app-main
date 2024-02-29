import 'package:dio/dio.dart';
import 'package:firebase_training/core/constants.dart';

class ApiService {
  final Dio dio = Dio();
  Future<Response> post({
    required body,
    required String url,
  }) async {
    Response response = await dio.post(url,
        data: body,
        options: Options(
            contentType: "application/json",
            headers: {'Authorization': "key=$serverKey"}));
    return response;
  }
}
