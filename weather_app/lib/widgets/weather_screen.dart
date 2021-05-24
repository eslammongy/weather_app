import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/widgets/setting_screen.dart';
import 'package:weather_app/widgets/widgets.dart';

import 'gradient.dart';

class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherScreen> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff353535),
      appBar: AppBar(
        backgroundColor: Color(0xff282828),
        title: Text(
          'Weather',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(WeatherRequested(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoadSuccessState) {
              BlocProvider.of<ThemeBloc>(context).add(
                WeatherChanged(weatherCondition: state.weather.condition),
              );
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          builder: (context, state) {
            if (state is WeatherInitialState) {
              return Center(
                  child: Text(
                'Please Enter a City Name !!',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ));
            }
            if (state is WeatherLoadInProgressState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoadSuccessState) {
              final weather = state.weather;

              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return GradientContainer(
                    color: themeState.materialColor,
                    child: RefreshIndicator(
                      onRefresh: () {
                        BlocProvider.of<WeatherBloc>(context).add(
                          WeatherRefreshRequested(city: weather.location),
                        );
                        return _refreshCompleter.future;
                      },
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 100.0),
                            child: Center(
                              child: Location(location: weather.location),
                            ),
                          ),
                          Center(
                            child: LastUpdated(dateTime: weather.lastUpdated),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.0),
                            child: Center(
                              child: CombinedWeatherTemperature(
                                weather: weather,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is WeatherLoadFailureState) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
          },
        ),
      ),
    );
  }
}
