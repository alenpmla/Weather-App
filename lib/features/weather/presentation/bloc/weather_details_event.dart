part of 'weather_details_bloc.dart';

@immutable
abstract class WeatherDetailsEvent {}

class GetWeatherDetailsEvent extends WeatherDetailsEvent {
  final String woeId;

  GetWeatherDetailsEvent(this.woeId);
}

class CityChangedEvent extends WeatherDetailsEvent {
  final String woeId;

  CityChangedEvent(this.woeId);
}

class GetDefaultWeatherDetailsEvent extends WeatherDetailsEvent {}

class RetryOnFailureEvent extends WeatherDetailsEvent {}

class RefreshCurrentWeatherDetails extends WeatherDetailsEvent {}

class ChangeCurrentDay extends WeatherDetailsEvent {
  final int dayIndex;

  ChangeCurrentDay(this.dayIndex);
}
