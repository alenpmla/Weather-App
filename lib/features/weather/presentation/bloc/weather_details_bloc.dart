import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/features/weather/domain/entities/weather_details.dart';

import '../../domain/repositories/weather_repository.dart';

part 'weather_details_event.dart';
part 'weather_details_state.dart';

class WeatherDetailsBloc
    extends Bloc<WeatherDetailsEvent, WeatherDetailsState> {
  final WeatherRepository repository;

  WeatherDetailsBloc({required this.repository})
      : super(WeatherDetailsLoading()) {
    on<GetWeatherDetailsEvent>((event, emit) async {
      emit(WeatherDetailsLoading());
      var failureOrSuccess = await repository.getWeatherDetails(event.woeId);
      add(ChangeCurrentDay(0));
      var currentDay = repository.getSelectedDayIndex();
      failureOrSuccess.fold(
        (failure) => emit(WeatherDetailsFailure()),
        (weatherDetails) {
          emit(WeatherDetailsSuccess(
              weatherDetails, currentDay));
        },
      );
    });

    on<GetDefaultWeatherDetailsEvent>((event, emit) async {
      emit(WeatherDetailsLoading());
      var failureOrSuccess = await repository.getDefaultWeatherDetails();
      var currentDay = repository.getSelectedDayIndex();
      failureOrSuccess.fold(
        (failure) => emit(WeatherDetailsFailure()),
        (locationList) {
          emit(
              WeatherDetailsSuccess(locationList, currentDay));
        },
      );
    });

    on<RefreshCurrentWeatherDetails>((event, emit) async {
      var failureOrSuccess = await repository.refreshCurrentWeatherDetails();
      var currentDay = repository.getSelectedDayIndex();
      failureOrSuccess.fold(
        (failure) => emit(WeatherDetailsFailure()),
        (weatherDetails) {
          emit(WeatherDetailsSuccess(
              weatherDetails, currentDay));
        },
      );
    });

    on<ChangeCurrentDay>((event, emit) async {
      repository.setCurrentDayIndex(event.dayIndex);
      WeatherDetails? weatherDetails = repository.getCachedWeatherData();
      var currentDay = repository.getSelectedDayIndex();
      if (weatherDetails != null) {
        emit(
            WeatherDetailsSuccess(weatherDetails, currentDay));
      }
    });
  }
}
