import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

import '../../domain/entities/location.dart';

part 'search_location_event.dart';

part 'search_location_state.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  final WeatherRepository repository;

  SearchLocationBloc({required this.repository})
      : super(SearchLocationLoading()) {
    on<SearchLocationWithQueryEvent>((event, emit) async {
      var failureOrSuccess = await repository.searchLocation(event.query);
      failureOrSuccess.fold(
        (failure) => emit(SearchLocationFailure()),
        (locationList) {
          emit(SearchLocationSuccess(locationList));
        },
      );
    });
  }
}
