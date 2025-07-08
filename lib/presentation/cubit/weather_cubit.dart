

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:task/core/errors/failures.dart';
import 'package:task/core/services/shared_prefrence_cach.dart';
import 'package:task/core/model/weather_model.dart';
import 'package:task/data/repos/weather_repo.dart';
import 'package:task/presentation/cubit/weather_state.dart';
class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository repository;
  WeatherCubit(this.repository) : super(WeatherInitial());

  void fetchWeather(String city) async {
    emit(WeatherLoading());
    final Either<Failure, WeatherModel> result =
        await repository.fetchWeather(city);

    result.fold(
      (failure) async {
        final cached = await LocalStorage.getCachedWeather();
        if (cached != null) {
          emit(WeatherLoaded(cached));
        } else {
          emit(WeatherError(failure.message));
        }
      },
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  void loadCachedWeather() async {
    final cached = await LocalStorage.getCachedWeather();
    if (cached != null) {
      emit(WeatherLoaded(cached));
    }
  }
}