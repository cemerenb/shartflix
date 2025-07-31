import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shartflix/shared/utils/context/constants/url.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (o) => log(o.toString()),
      ),
    );
  }

  Dio get dio => _dio;
}
