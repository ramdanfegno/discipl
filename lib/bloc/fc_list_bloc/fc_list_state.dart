part of 'fc_list_bloc.dart';

abstract class FCListState extends Equatable {
  const FCListState();

  @override
  List<Object> get props => [];
}

/// Initial splash screen
class FCListingFetchInitial extends FCListState {}

/// Show loading widget
class FCListingFetchLoading extends FCListState {}

///Profile Fetch Success
class FCListingFetchSuccess extends FCListState {
  final List<FitnessCenterModel> fcList;
  final String? errorMsg;
  final bool isLoading;
  final int pageNo;

  const FCListingFetchSuccess({
    required this.fcList,
    required this.isLoading,
    required this.pageNo,
    this.errorMsg
  });
}

///Profile Fetch Failure
class FCListingFetchFailure extends FCListState {
  final String message;
  final List<FitnessCenterModel>? fcList;

  const FCListingFetchFailure({required this.message,required this.fcList});
}
