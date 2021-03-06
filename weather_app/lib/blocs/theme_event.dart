import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/models.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition weatherCondition;

  const WeatherChanged({@required this.weatherCondition})
      : assert(weatherCondition != null);
  @override
  List<Object> get props => [weatherCondition];
}
