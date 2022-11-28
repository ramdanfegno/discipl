part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationFetchInitial extends LocationState {}

/// Show loading widget
class LocationFetchLoading extends LocationState {}

class LocationFetchSuccess extends LocationState {
  final List<ZoneResult> locationList;
  final String? errorMsg;
  final bool isLoading;
  final int pageNo;

  const LocationFetchSuccess({
    required this.locationList,
    required this.isLoading,
    required this.pageNo,
    this.errorMsg
  });
}

class LocationFetchFailure extends LocationState {
  final String message;
  final List<ZoneResult> locationList;

  const LocationFetchFailure({required this.message,required this.locationList});
}
