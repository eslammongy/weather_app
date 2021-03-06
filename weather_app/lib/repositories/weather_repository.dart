import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/models.dart';
import 'package:weather_app/repositories/repositories.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);

    return weatherApiClient.fetchWeather(locationId);
  }
}
