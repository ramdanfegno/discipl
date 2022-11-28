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
  const HomeFetchSuccess({
    required this.homeDate,
    required this.isLoading,
    this.errorMsg
  });
}

///Profile Fetch Failure
class HomeFetchFailure extends HomeState {
  final String message;
  const HomeFetchFailure({required this.message});
}
