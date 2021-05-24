import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/model/models.dart';
import 'package:weather_app/repositories/repositories.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherInitialState());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield* weatherRequestedEventToState(event);
    }
    if (event is WeatherRefreshRequested) {
      yield* weatherRefreshRequestedEventToState(event);
    }
  }

  Stream<WeatherState> weatherRequestedEventToState(
      WeatherRequested event) async* {
    yield WeatherLoadInProgressState();
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoadSuccessState(weather: weather);
    } catch (_) {
      yield WeatherLoadFailureState();
    }
  }

  Stream<WeatherState> weatherRefreshRequestedEventToState(
      WeatherRefreshRequested event) async* {
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoadSuccessState(weather: weather);
    } catch (_) {}
  }
}
