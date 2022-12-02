part of 'search_center_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchDisplay extends SearchState {
  final List<FitnessCenterModel> fcList;

  SearchDisplay({required this.fcList});

  @override
  List<Object> get props => [fcList];

  @override
  String toString() =>
      'SearchDisplay displayName: ${fcList.length.toString()}';
}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class SearchLoading extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
