part of 'search_zone_bloc.dart';

abstract class SearchZoneState extends Equatable {
  const SearchZoneState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchZoneState {}

class SearchDisplay extends SearchZoneState {
  final List<ZoneResult> locationList;

  SearchDisplay({required this.locationList});

  @override
  List<Object> get props => [locationList];

  @override
  String toString() =>
      'SearchDisplay displayName: ${locationList.length.toString()}';
}

class SearchFailure extends SearchZoneState {
  final String message;

  SearchFailure({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class SearchLoading extends SearchZoneState {}

class SearchEmpty extends SearchZoneState {}

class SearchError extends SearchZoneState {
  final String message;

  SearchError({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
