import 'package:dio/dio.dart';

class HttpClient {
  final Dio dio;

  HttpClient() : dio = Dio() {

    dio.options.baseUrl = 'https://viacep.com.br/ws/';
  }
}
