part of 'search_zone_bloc.dart';

abstract class SearchZoneEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitiate extends SearchZoneEvent {
  final String searchQ;
  final bool forceRefresh;

  SearchInitiate({required this.searchQ, required this.forceRefresh});

  @override
  List<Object> get props => [searchQ];

  @override
  String toString() {
    return 'SearchInitiate { searchQ: $searchQ}';
  }
}
