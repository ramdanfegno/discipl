import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/profile_screen_view.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/color_loader.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late UserProfile? userProfile;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            isHomeAppBar: false,
            appBarTitle: 'My Profile',
          ),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileFetchSuccess) {
                if(state.errorMsg != null){
                  showToast(state.errorMsg!);
                }
                return profileView(state.userProfile, state.isLoading);
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

  Widget profileView(UserProfile? userProfile,bool? isLoading){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          ProfileScreenView(userProfile: userProfile),

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


