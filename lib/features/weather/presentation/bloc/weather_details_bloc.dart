import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/error/failure.dart';
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
      _checkAndEmitSuccess(failureOrSuccess, emit);
    });

    on<CityChangedEvent>((event, emit) async {
      emit(CityChangedLoading());
      var failureOrSuccess = await repository.getWeatherDetails(event.woeId);
      add(ChangeCurrentDay(0));
      _checkAndEmitSuccess(failureOrSuccess, emit);
    });

    on<GetDefaultWeatherDetailsEvent>((event, emit) async {
      emit(WeatherDetailsLoading());
      var failureOrSuccess = await repository.getDefaultWeatherDetails();
      _checkAndEmitSuccess(failureOrSuccess, emit);
    });

    on<RefreshCurrentWeatherDetails>((event, emit) async {
      var failureOrSuccess = await repository.refreshCurrentWeatherDetails();
      _checkAndEmitSuccess(failureOrSuccess, emit);
    });

    on<ChangeCurrentDay>((event, emit) async {
      repository.setCurrentDayIndex(event.dayIndex);
      WeatherDetails? weatherDetails = repository.getCachedWeatherData();
      var currentDay = repository.getSelectedDayIndex();
      if (weatherDetails != null) {
        emit(WeatherDetailsSuccess(weatherDetails, currentDay));
      }
    });
  }

  void _checkAndEmitSuccess(Either<Failure, WeatherDetails> failureOrSuccess,
      Emitter<WeatherDetailsState> emit) {
    var currentDay = repository.getSelectedDayIndex();
    failureOrSuccess.fold(
      (failure) => emit(WeatherDetailsFailure()),
      (locationList) {
        emit(WeatherDetailsSuccess(locationList, currentDay));
      },
    );
  }
}
