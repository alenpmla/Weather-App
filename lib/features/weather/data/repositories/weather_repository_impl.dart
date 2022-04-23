import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/features/weather/data/datasources/weather_data_source.dart';
import 'package:weather_app/features/weather/domain/entities/location.dart';
import 'package:weather_app/features/weather/domain/entities/weather_details.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/weather_repository.dart';
import '../model/weather_detail_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataSource weatherDataSource;
  final LocationService locationService;
  static const String defaultLocation = "638242";
  String? currentWoeId;
  bool isCelsius = true;
  int currentDay = 0;
  WeatherDetails? cachedWeatherDetails;

  WeatherRepositoryImpl(
      {required this.weatherDataSource, required this.locationService});

  @override
  Future<Either<Failure, WeatherDetails>> getWeatherDetails(
      String woeId) async {
    try {
      currentWoeId = woeId;
      final weatherDetailsModel =
          await weatherDataSource.getWeatherDetails(woeId);
      final WeatherDetails weatherDetails =
          weatherDetailsModel.toWeatherDetail();
      cachedWeatherDetails = weatherDetails;
      return Right(weatherDetails);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Location>>> searchLocation(String query,
      {bool isLatLong = false}) async {
    try {
      final locationList =
          await weatherDataSource.searchLocationWithQuery(query);
      return Right(locationList.map((e) => e.toLocation()).toList());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WeatherDetails>> getDefaultWeatherDetails() async {
    try {
      Position position = await locationService.getLocation();
      String latLong = "${position.latitude},${position.longitude}";
      final locationList =
          await weatherDataSource.searchLocationWithLatLng(latLong);
      WeatherDetailModel weatherDetails;
      if (locationList.isNotEmpty) {
        weatherDetails = await weatherDataSource
            .getWeatherDetails("${locationList.first.woeId}");
      } else {
        weatherDetails =
            await weatherDataSource.getWeatherDetails(defaultLocation);
      }
      _saveCurrentData(weatherDetails);
      return Right(weatherDetails.toWeatherDetail());
    } on LocationException {
      WeatherDetailModel weatherDetails;
      weatherDetails =
          await weatherDataSource.getWeatherDetails(defaultLocation);
      _saveCurrentData(weatherDetails);
      return Right(weatherDetails.toWeatherDetail());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  void _saveCurrentData(WeatherDetailModel weatherDetails) {
    currentWoeId = weatherDetails.woeId.toString();
    cachedWeatherDetails = weatherDetails.toWeatherDetail();
  }

  @override
  Future<Either<Failure, WeatherDetails>> refreshCurrentWeatherDetails() async {
    try {
      if (currentWoeId != null) {
        final weatherDetails =
            await weatherDataSource.getWeatherDetails(currentWoeId!);
        cachedWeatherDetails = weatherDetails.toWeatherDetail();
        return Right(weatherDetails.toWeatherDetail());
      } else {
        return Left(ServerFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  bool isDegreeCelsius() {
    return isCelsius;
  }

  @override
  void switchTempUnit() {
    isCelsius = !isCelsius;
  }

  @override
  WeatherDetails? getCachedWeatherData() {
    return cachedWeatherDetails;
  }

  @override
  int getSelectedDayIndex() {
    return currentDay;
  }

  @override
  void setCurrentDayIndex(int index) {
    currentDay = index;
  }
}
