import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/entities/location.dart';
import 'package:weather_app/features/weather/domain/entities/weather_details.dart';

import '../../../../core/error/failure.dart';

abstract class WeatherRepository {
  Future<Either<Failure, List<Location>>> searchLocation(String query,
      {bool isLatLong});

  bool isDegreeCelsius();

  bool switchTempUnit();

  void setCurrentDayIndex(int index);

  int getSelectedDayIndex();

  WeatherDetails? getCachedWeatherData();

  Future<Either<Failure, WeatherDetails>> getDefaultWeatherDetails();

  Future<Either<Failure, WeatherDetails>> refreshCurrentWeatherDetails();

  Future<Either<Failure, WeatherDetails>> getWeatherDetails(String woeId);
}
