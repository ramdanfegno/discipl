import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/bloc/home_screen_bloc/home_bloc.dart';
import 'package:habitoz_fitness_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/models/zone_list_model.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/profile_screen_view.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/color_loader.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late UserProfile? userProfile;
  late ProfileBloc? _profileBloc;
  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            isHomeAppBar: false,
            appBarTitle: 'My Profile',
            onBackPressed: (){
              Navigator.pop(context);
            },
          ),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileFetchSuccess) {
                if(state.errorMsg != null){
                  showToast(state.errorMsg!);
                }
                updateHome(context);
                return profileView(state.userProfile, state.isLoading,state.data);
              }
              if (state is ProfileFetchFailure) {
                return buildErrorView(state.message);
              }
              if (state is ProfileFetchLoading) {
                return buildLoadingView();
              }
              return Container();
            },
          ),
      ),
    );
  }

  showToast(String msg){
    Fluttertoast.showToast(msg: msg);
  }

  updateHome(BuildContext context) async {
    ZoneResult? zoneResult = await userRepository.getZoneDetailsLocal();
    BlocProvider.of<HomeBloc>(context).add(LoadHome(forceRefresh: true, zone: zoneResult));
  }

  Widget profileView(UserProfile? userProfile,bool? isLoading,Map<String,dynamic> data){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ProfileScreenView(
            userProfile: userProfile,
            data: data,
            onImagePicked: (){
              pickImage(context);
            },
          ),

          (isLoading != null && isLoading) ?
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.2),
            alignment: Alignment.center,
            child: ColorLoader5(),
          ) : Container()

        ],
      ),
    );
  }

  Future pickImage(BuildContext context) async{
    try{
      print('pickImage');
      final image = await ImagePicker().pickImage(source:ImageSource.gallery,imageQuality: 60);
      if(image != null){
        print('image not null');
        final imageTemporary = File(image.path);
        Map<String,dynamic> data = {
          'image' : imageTemporary
        };
        showToast('Updating profile picture');

        Response? response = await userRepository.updateProfileImage(data);
        if(response != null){
          print('updateProfileImage 123');
          print(response.statusCode);
          print(response.statusMessage);
          print(response.data);
          if(response.statusCode == 200){
            _profileBloc!.add(LoadProfile());
          }
          else{
            showToast('Error updating profile picture');
          }
        }
        else{
          showToast('Error updating profile picture');
        }
        //_profileBloc!.add(UpdateProfileImage(details: data));
        //Fluttertoast.showToast(msg: 'Updating profile image....');
      }
    }
    on PlatformException {
      return "Failed to Pick";
    }
  }


  Widget buildErrorView(String msg){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text(
          msg,
          style: const TextStyle(
            color: Constants.fontColor1,
            fontSize: 22,
            fontFamily: Constants.fontRegular
          ),
        ),
      ),
    );
  }

  Widget buildLoadingView(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: ColorLoader5(),
      ),
    );
  }
}


