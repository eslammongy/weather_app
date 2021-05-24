import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/settings_event.dart';
import 'package:weather_app/blocs/settings_state.dart';

class SettingBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingBloc()
      : super(SettingsState(temperatureUnits: TemperatureUnits.celsius));

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is TemperatureUnitsToggled) {
      yield SettingsState(
          temperatureUnits: state.temperatureUnits == TemperatureUnits.celsius
              ? TemperatureUnits.fahrenheit
              : TemperatureUnits.celsius);
    }
  }
}
