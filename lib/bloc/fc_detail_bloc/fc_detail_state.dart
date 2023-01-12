part of 'fc_detail_bloc.dart';

abstract class FCDetailState extends Equatable {
  const FCDetailState();

  @override
  List<Object> get props => [];
}

/// Initial splash screen
class FCDetailFetchInitial extends FCDetailState {}

/// Show loading widget
class FCDetailFetchLoading extends FCDetailState {}

///Profile Fetch Success
class FCDetailFetchSuccess extends FCDetailState {
  final FitnessCenterModel? details;
  final String? errorMsg;
  final bool isLoading;
  const FCDetailFetchSuccess({
    required this.details,
    required this.isLoading,
    this.errorMsg
  });
}

///Profile Fetch Failure
class FCDetailFetchFailure extends FCDetailState {
  final String message;
  const FCDetailFetchFailure({required this.message});
}

class FCDetailUnAuth extends FCDetailState{
  final Widget dialBox;
  const FCDetailUnAuth({required this.dialBox});
}
