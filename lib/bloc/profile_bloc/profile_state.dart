part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

/// Initial splash screen
class ProfileFetchInitial extends ProfileState {}

/// Show loading widget
class ProfileFetchLoading extends ProfileState {}

///Profile Fetch Success
class ProfileFetchSuccess extends ProfileState {
  final UserProfile? userProfile;
  final String? errorMsg;
  final bool isLoading;
  const ProfileFetchSuccess({required this.userProfile,required this.isLoading,this.errorMsg});
}

///Profile Fetch Failure
class ProfileFetchFailure extends ProfileState {
  final String message;
  const ProfileFetchFailure({required this.message});
}
