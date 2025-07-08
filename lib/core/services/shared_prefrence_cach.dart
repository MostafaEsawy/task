

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/core/model/weather_model.dart';

class LocalStorage {
  static const _weatherKey = 'cached_weather';

  static Future<void> cacheWeather(WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(weather.toMap());
    await prefs.setString(_weatherKey, jsonString);
    print('[CACHE] Weather cached');
  }

  static Future<WeatherModel?> getCachedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_weatherKey);
    if (jsonString != null) {
      print('[CACHE] Found cached weather: $jsonString');
      final data = json.decode(jsonString);
      return WeatherModel.fromCache(data);
    }
    print('[CACHE] No cached weather found');
    return null;
  }

  static Future<void> clearCachedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_weatherKey);
    print('[CACHE] Weather cache cleared');
  }
}