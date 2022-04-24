part of 'app_settings_bloc.dart';

@immutable
abstract class AppSettingsState {}

class AppSettingsInitial extends AppSettingsState {}

class AppSettingsSuccess extends AppSettingsState {
  final bool isCelsius;

  AppSettingsSuccess(this.isCelsius);
}
