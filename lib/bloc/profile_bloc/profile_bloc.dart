import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import '../../repositories/user_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc
    extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ProfileFetchInitial());

  ProfileState get initialState => ProfileFetchInitial();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState();
    }
    else if (event is UpdateProfile) {
      yield* _mapUpdateProfileToState(event.details);
    }
  }

  Stream<ProfileState> _mapLoadProfileToState() async* {
    try{
      yield ProfileFetchLoading();
      UserProfile? userProfile1 = await _userRepository.getProfileDetailsLocal();
      UserProfile? userProfile2;
      if(userProfile1 != null){
        yield ProfileFetchSuccess(userProfile: userProfile1,isLoading: false);
      }
      Response? response = await _userRepository.getUserProfile(true);
      if(response != null){
        if(response.statusCode == 200){
          userProfile2 = UserProfile.fromJson(response.data);
          yield ProfileFetchSuccess(userProfile: userProfile2,isLoading: false);
        }
      }
      if(userProfile1 == null){
        if(userProfile2 == null){
          yield const ProfileFetchFailure(message: 'No User details available');
        }
      }
      else{
        if(userProfile2 == null){
          yield ProfileFetchSuccess(userProfile: userProfile1,isLoading: false,errorMsg: 'Unable to load profile details');
        }
      }
    }
    catch(e){
      print(e.toString());
      yield ProfileFetchFailure(message: e.toString());
    }
  }

  Stream<ProfileState> _mapUpdateProfileToState(Map<String,dynamic> data) async* {
    try{
      UserProfile? userProfile1 = await _userRepository.getProfileDetailsLocal();
      UserProfile? userProfile2;
      if(userProfile1 != null){
        yield ProfileFetchSuccess(userProfile: userProfile1,isLoading: true);
      }
      else{
        yield ProfileFetchLoading();
      }

      Map<String,dynamic> details = {};
      Map<String,dynamic> user = {};

      if(data['first_name'] != null){
        user['first_name'] = data['first_name'];
        data.remove('first_name');
      }
      if(data['last_name'] != null){
        user['last_name'] = data['last_name'];
        data.remove('last_name');
      }
      if(data['email'] != null){
        user['email'] = data['email'];
        data.remove('email');
      }
      if(data['mobile'] != null){
        user['mobile'] = data['mobile'];
        data.remove('mobile');
      }

      if(user.isNotEmpty){
        details['user'] = user;
      }
      if(data.isNotEmpty){
        details.addAll(data);
      }
      print(data);

      Response? response = await _userRepository.updateUserDetails(data);
      if(response != null){
        if(response.statusCode == 200){
          Response? response2 = await _userRepository.getUserProfile(true);
          if(response2 != null){
            if(response2.statusCode == 200){
              userProfile2 = UserProfile.fromJson(response2.data);
              yield ProfileFetchSuccess(userProfile: userProfile2,isLoading: false);
            }
          }
        }
      }

      if(userProfile1 == null){
        if(userProfile2 == null){
          yield const ProfileFetchFailure(message: 'Something went wrong');
        }
      }
      else{
        if(userProfile2 == null){
          yield ProfileFetchSuccess(userProfile: userProfile1,isLoading: false,errorMsg: 'Unable update profile details');
        }
      }
    }
    catch(e){
      print(e.toString());
      yield ProfileFetchFailure(message: e.toString());
    }
  }
}