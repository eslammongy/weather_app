import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/widgets/widgets.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff353535),
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
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
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitialState) {
              return Center(
                child: Text('Please Select a City Name'),
              );
            }
            if (state is WeatherLoadInProgressState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherLoadSuccessState) {
              final weather = state.weather;

              return ListView(
                children: [
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
                      )),
                ],
              );
            }

            if (state is WeatherLoadFailureState) {
              return Text(
                "Something Went Wrong!!",
                style: TextStyle(color: Colors.red),
              );
            }

            return Text(
              "Something Went Wrong!!",
              style: TextStyle(color: Colors.red),
            );
          },
        ),
      ),
    );
  }
}
