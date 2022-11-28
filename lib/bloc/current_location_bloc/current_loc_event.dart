part of 'current_loc_bloc.dart';

abstract class CurrentLocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCurrentLoc extends CurrentLocEvent {
  final bool forceRefresh;
  LoadCurrentLoc({required this.forceRefresh});
}
