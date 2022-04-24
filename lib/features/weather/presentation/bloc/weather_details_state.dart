part of 'weather_details_bloc.dart';

@immutable
abstract class WeatherDetailsState {}

class WeatherDetailsEmpty extends WeatherDetailsState {}

class InitialLoadingState extends WeatherDetailsState {}

class SecondaryLoadingState extends WeatherDetailsState {}

class WeatherDetailsFailure extends WeatherDetailsState {}

class WeatherDetailsSuccess extends WeatherDetailsState {
  final WeatherDetails weatherDetails;
  final int selectedDay;

  WeatherDetailsSuccess(this.weatherDetails, this.selectedDay);
}
