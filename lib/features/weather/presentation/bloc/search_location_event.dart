part of 'search_location_bloc.dart';

@immutable
abstract class SearchLocationEvent {}

class SearchLocationWithQueryEvent extends SearchLocationEvent {
  final String query;

  SearchLocationWithQueryEvent(this.query);
}


class SetDefaultLocation extends SearchLocationEvent {

  SetDefaultLocation();
}
