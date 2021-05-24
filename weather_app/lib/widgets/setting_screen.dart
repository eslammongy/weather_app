import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/blocs.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff353535),
      appBar: AppBar(
        title: Text('Settings'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => WeatherScreen(),
        //       ),
        //     );
        //   },
        // ),
      ),
      body: ListView(
        children: <Widget>[
          BlocBuilder<SettingBloc, SettingsState>(builder: (context, state) {
            return ListTile(
              title: Text(
                'Temperature Units',
                style: TextStyle(color: Colors.white),
              ),
              isThreeLine: true,
              subtitle: Text(
                'Use metric measurements for temperature units.',
                style: TextStyle(color: Colors.grey),
              ),
              trailing: Switch(
                value: state.temperatureUnits == TemperatureUnits.celsius,
                onChanged: (_) => BlocProvider.of<SettingBloc>(context)
                    .add(TemperatureUnitsToggled()),
              ),
            );
          }),
        ],
      ),
    );
  }
}
