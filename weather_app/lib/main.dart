import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/blocs/settings_bloc.dart';
import 'package:weather_app/blocs/simple_bloc_observer.dart';
import 'package:weather_app/blocs/theme_bloc.dart';
import 'package:weather_app/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/weather_screen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<SettingBloc>(
          create: (context) => SettingBloc(),
        ),
      ],
      child: MyApp(weatherRepository: weatherRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather',
          theme: state.themeData,
          home: BlocProvider(
            create: (context) =>
                WeatherBloc(weatherRepository: weatherRepository),
            child: WeatherScreen(),
          ),
        );
      },
    );
  }
}
