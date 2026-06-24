import 'package:dio/dio.dart';
import 'api_constants.dart';

class DioClient {
  late final Dio _dio;
  DioClient(){
    _dio=Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    _dio.interceptors.add(
        InterceptorsWrapper(
            onRequest: (options, handler) {
              options.queryParameters['apiKey']=ApiConstants.apiKey;
              return handler.next(options);
            })
    );

    //to log the request and response in the console
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ));
  }

  ///function to get data from the api
  Future<Response> get(
      String path,{
        Map<String,dynamic>? queryParameters,
      }) async{
    try{
      final response= await _dio.get(path,queryParameters: queryParameters);
      return response;
    }catch(e){
      rethrow;
    }
  }
}