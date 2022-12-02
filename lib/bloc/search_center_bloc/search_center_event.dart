part of 'search_center_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitiate extends SearchEvent {
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
