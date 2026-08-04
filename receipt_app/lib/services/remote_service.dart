import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:receipt_app/models/meals_response.dart';

class RemoteService {

  static const baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10)
    )
  );


  RemoteService(){
    if(kDebugMode){
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true
        )
      );
    }
  }

  Future<List<Meals>?> fetchMealsByCategory(String category) async {
    try {
      final response = await _dio.get(
        "filter.php",
        queryParameters: {"c": category}
      );
      return MealsResponse.fromJson(response.data).meals;

    } on DioException catch(dio) {
      throw "Gagal mengambil data berdasarkan kategori";
    } catch(exc) {
      throw "Kesalahan tidak terduga";
    }

  }


  Future<Meals?> fetchMealById(String id) async {
    try {
      final response = await _dio.get(
        "lookup.php",
        queryParameters: {"i": id}
      );
      return MealsResponse.fromJson(response.data).meals?.first;

    } on DioException catch(dio) {
      throw "Gagal mengambil data berdasarkan id";
    } catch(exc) {
      throw "Kesalahan tidak terduga";
    }

  }

}