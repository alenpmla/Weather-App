part of 'search_location_bloc.dart';

@immutable
abstract class SearchLocationState {}


class SearchLocationLoading extends SearchLocationState {}

class SearchLocationSuccess extends SearchLocationState {
  final List<Location> locationList;

  SearchLocationSuccess(this.locationList);
}

class SearchLocationFailure extends SearchLocationState {}

class SearchLocationEmpty extends SearchLocationState {}
