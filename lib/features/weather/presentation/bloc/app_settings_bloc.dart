import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  final WeatherRepository repository;

  AppSettingsBloc({required this.repository}) : super(AppSettingsInitial()) {
    on<LoadAppSettingsEvent>((event, emit) {
      bool isCelsius = repository.isDegreeCelsius();
      emit(AppSettingsSuccess(isCelsius));
    });

    on<SwitchWeatherUnitEvent>((event, emit) async {
      bool isCelsius = repository.switchTempUnit();
      emit(AppSettingsSuccess(isCelsius));
    });
  }
}
