part of 'app_settings_bloc.dart';

@immutable
abstract class AppSettingsEvent {}

class LoadAppSettingsEvent extends AppSettingsEvent {}

class SwitchWeatherUnitEvent extends AppSettingsEvent {}
