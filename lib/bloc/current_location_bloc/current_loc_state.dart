part of 'current_loc_bloc.dart';

abstract class CurrentLocState extends Equatable {
  const CurrentLocState();

  @override
  List<Object> get props => [];
}

/// Initial splash screen
class CurrentLocInitial extends CurrentLocState {}

/// Show loading widget
class FetchCurrentLocLoading extends CurrentLocState {}

///Profile Fetch Success
class CurrentLocSuccess extends CurrentLocState {
  final double? latitude,longitude;
  final String? place;
  const CurrentLocSuccess({
    required this.place,
    required this.latitude,
    required this.longitude,
  });
}

///Profile Fetch Failure
class CurrentLocFailure extends CurrentLocState {
  final String message;
  const CurrentLocFailure({required this.message});
}
