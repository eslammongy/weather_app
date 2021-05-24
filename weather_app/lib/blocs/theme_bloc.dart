import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/model/models.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            themeData: ThemeData.light(), materialColor: Colors.blue));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is WeatherChanged) {
      yield mapweatherConditionToThemeDate(event.weatherCondition);
    }
  }

  ThemeState mapweatherConditionToThemeDate(WeatherCondition weatherCondition) {
    ThemeState theme;

    switch (weatherCondition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        theme = ThemeState(
          themeData: ThemeData(
            primaryColor: Colors.orangeAccent,
          ),
          materialColor: Colors.yellow,
        );
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        theme = ThemeState(
          themeData: ThemeData(
            primaryColor: Colors.lightBlueAccent,
          ),
          materialColor: Colors.lightBlue,
        );
        break;
      case WeatherCondition.heavyCloud:
        theme = ThemeState(
          themeData: ThemeData(
            primaryColor: Colors.blueGrey,
          ),
          materialColor: Colors.grey,
        );
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        theme = ThemeState(
          themeData: ThemeData(
            primaryColor: Colors.indigoAccent,
          ),
          materialColor: Colors.indigo,
        );
        break;
      case WeatherCondition.thunderstorm:
        theme = ThemeState(
          themeData: ThemeData(
            primaryColor: Colors.deepPurpleAccent,
          ),
          materialColor: Colors.deepPurple,
        );
        break;
      case WeatherCondition.unknown:
        theme = ThemeState(
          themeData: ThemeData.light(),
          materialColor: Colors.lightBlue,
        );
        break;
    }
    return theme;
  }
}
