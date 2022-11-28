part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadHome extends HomeEvent {
  final bool forceRefresh;
  LoadHome({required this.forceRefresh});
}
