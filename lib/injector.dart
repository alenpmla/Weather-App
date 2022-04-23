import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:weather_app/core/services/http_service.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/features/weather/data/datasources/weather_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_details_bloc.dart';

import 'core/utils/config_reader.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(
    () => WeatherDetailsBloc(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherDataSource: sl(), locationService: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherDataSource>(
    () => WeatherDataSourceImpl(httpService: sl()),
  );

  //core
  sl.registerLazySingleton(() => ConfigReader());
  sl.registerLazySingleton<HttpService>(
    () => HttpServiceImpl(sl(), sl()),
  );

  //external
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton<LocationService>(
    () => LocationServiceImpl(),
  );
}
