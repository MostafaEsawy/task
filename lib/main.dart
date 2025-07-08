

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/repos/weather_repo.dart';
import 'package:task/presentation/cubit/weather_cubit.dart';
import 'package:task/presentation/view/search_view.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherCubit cubit = WeatherCubit(WeatherRepository());
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider.value(
        value: cubit..loadCachedWeather(),
        child: SearchView(),
      ),
    );
  
  }
}
