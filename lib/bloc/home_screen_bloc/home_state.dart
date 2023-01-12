part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

/// Initial splash screen
class HomeFetchInitial extends HomeState {}

/// Show loading widget
class HomeFetchLoading extends HomeState {}

///Profile Fetch Success
class HomeFetchSuccess extends HomeState {
  final HomePageModel? homeDate;
  final String? errorMsg;
  final bool isLoading;
  final ZoneResult? zone;
  const HomeFetchSuccess({
    required this.homeDate,
    required this.isLoading,
    required this.zone,
    this.errorMsg
  });
}

///Profile Fetch Failure
class HomeFetchFailure extends HomeState {
  final String message;
  const HomeFetchFailure({required this.message});
}

class HomeUnAuth extends HomeState{
  final Widget dialbox;
  const HomeUnAuth({required this.dialbox});
}
