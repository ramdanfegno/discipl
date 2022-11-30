
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/bloc/home_screen_bloc/home_bloc.dart';
import 'package:habitoz_fitness_app/bloc/location_bloc/location_bloc.dart';
import 'package:habitoz_fitness_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:habitoz_fitness_app/models/home_page_model.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/models/zone_list_model.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../bloc/fc_detail_bloc/fc_detail_bloc.dart';
import '../../../bloc/fc_list_bloc/fc_list_bloc.dart';
import '../../widgets/others/color_loader.dart';
import '../../widgets/others/drawer.dart';
import '../bmi/profile_screen.dart';
import 'home_screen_view.dart';

class HomeScreen extends StatefulWidget {
  final bool isLoggedIn,isGuest;
  final String? userName;
  const HomeScreen({Key? key,required this.isGuest,required this.isLoggedIn,this.userName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late bool isProfileCompleted;
  late FCDetailBloc _fcDetailBloc;
  late FCListBloc _fcListBloc;
  late HomeBloc _homeBloc;
  late ProfileBloc _profileBloc;
  ZoneResult? _zone;
  final UserRepository userRepository = UserRepository();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isProfileCompleted = false;
    _fcListBloc = BlocProvider.of<FCListBloc>(context);
    _fcDetailBloc = BlocProvider.of<FCDetailBloc>(context);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    updateProfileDetails();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        isGuest: widget.isGuest,
        userName: widget.userName!,
      ),
      appBar: CustomAppBar(
        drawerClicked: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        appBarTitle: '',
        isHomeAppBar: true,
        onBackPressed: (){
          //Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeFetchSuccess) {
            if(state.errorMsg != null){
              showToast(state.errorMsg!);
            }
            return homeView(state.homeDate, state.isLoading,state.zone);
          }
          if (state is HomeFetchFailure) {
            return buildErrorView(state.message);
          }
          if (state is HomeFetchLoading) {
            return buildLoadingView();
          }
          return Container();
        },
      ),
    );
  }

  Widget homeView(HomePageModel? homePageData,bool? isLoading,ZoneResult? zoneResult){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [

          HomeScreenView(
            homeData: homePageData,
            fcDetailBloc: _fcDetailBloc,
            fcListBloc: _fcListBloc,
            isProfileCompleted: (widget.isLoggedIn) ? false : true,
            zoneResult: zoneResult,
            onLocationChanged: (val){
              _zone = val;
              _homeBloc.add(LoadHome(forceRefresh: true,zone: _zone!));
            },
            onProfileClicked: (){
              _profileBloc.add(LoadProfile());
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ProfileScreen();
              }));
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


  showToast(String msg){
    Fluttertoast.showToast(msg: msg);
  }

  updateProfileDetails() async {
    try{
      //store profile details
      Response? response2 = await userRepository.getUserProfile(true);
      print('updateProfileDetails');
      print(response2!.statusCode);
      print(response2.data);
      print(response2.statusMessage);
      if(response2 != null && response2.statusCode == 200){
        UserProfile userProfile = UserProfile.fromJson(response2.data);
        await userRepository.storeProfileDetails(userProfile);
      }
    }catch(e){
      print(e.toString());
    }
  }
}
