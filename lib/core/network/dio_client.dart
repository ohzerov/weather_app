import 'package:dio/dio.dart';
import 'package:weatherapp/core/constants.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio
      ..options.baseUrl = 'http://api.weatherapi.com/v1/'
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 3)
      ..options.queryParameters = {'key': apiKey};
  }
  Dio get dio => _dio;
}
