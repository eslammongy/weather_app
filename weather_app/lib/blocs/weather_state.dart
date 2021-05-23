import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/model/models.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadInProgressState extends WeatherState {}

class WeatherLoadSuccessState extends WeatherState {
  final Weather weather;

  const WeatherLoadSuccessState({@required this.weather})
      : assert(weather != null);
  @override
  List<Object> get props => [weather];
}

class WeatherLoadFailureState extends WeatherState {
  // final Weather weather;

  // const WeatherLoadFailureState({@required this.weather})
  //     : assert(weather != null);
}
