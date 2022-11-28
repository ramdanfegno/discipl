part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadLocationPage extends LocationEvent {
  final bool forceRefresh;
  final int pageNo;
  final String? searchQ;
  final bool isLoading;

  LoadLocationPage({required this.forceRefresh,required this.pageNo,this.searchQ,required this.isLoading});
}

class SearchLocationPage extends LocationEvent {
  final bool forceRefresh;
  final String? searchQ;
  final int pageNo;

  SearchLocationPage({required this.forceRefresh,required this.searchQ,required this.pageNo});
}

class PaginateLocationPage extends LocationEvent {
  final bool forceRefresh;
  final int pageNo;
  final String? searchQ;
  final List<ZoneResult>? locationList;

  PaginateLocationPage({required this.forceRefresh,this.searchQ,required this.pageNo,required this.locationList});
}
