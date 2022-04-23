part of 'weather_details_bloc.dart';

@immutable
abstract class WeatherDetailsState {}

class WeatherDetailsEmpty extends WeatherDetailsState {}

class WeatherDetailsLoading extends WeatherDetailsState {}

class WeatherDetailsFailure extends WeatherDetailsState {}

class WeatherDetailsSuccess extends WeatherDetailsState {
  final WeatherDetails weatherDetails;
  final bool isCelsius;
  final int selectedDay;

  WeatherDetailsSuccess(this.weatherDetails, this.isCelsius, this.selectedDay);
}
