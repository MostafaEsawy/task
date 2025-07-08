
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:task/core/errors/failures.dart';
import 'package:task/core/services/shared_prefrence_cach.dart';
import 'package:task/core/model/weather_model.dart';


class WeatherRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.weatherapi.com/v1/current.json';
  final String _apiKey = '6f27a7b9512c4882a45162444252101';

  Future<Either<Failure, WeatherModel>> fetchWeather(String city) async {
    try {
      final response = await _dio.get(_baseUrl, queryParameters: {
        'key': _apiKey,
        'q': city,
      });

      final data = response.data;
      if (data.containsKey('error')) {
        final errorCode = data['error']['code'];
        return left(ServerFailure(
          errorCode == 1006 ? "Invalid city name." : data['error']['message'],
        ));
      }

      final weather = WeatherModel.fromJson(data);
      await LocalStorage.cacheWeather(weather);
      return right(weather);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.unknown) {
        return left(ConnectionFailure());
      } else {
        return left(ServerFailure("Server error"));
      }
    } catch (_) {
      return left(ServerFailure("Unexpected error"));
    }
  }
}