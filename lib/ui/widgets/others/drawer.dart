import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:habitoz_fitness_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../../utils/routes.dart';
import '../dialog/custom_dialog.dart';

class CustomDrawer extends StatefulWidget {
  final String? userName;
  final bool isGuest;

  const CustomDrawer({Key? key, required this.userName, required this.isGuest})
      : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late ProfileBloc _profileBloc;
  String? _profileImage, _userName;
  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    getProfileImage();
  }

  getProfileImage() async {
    UserProfile? userProfile = await userRepository.getProfileDetailsLocal();
    if (userProfile != null) {
      if (userProfile.image != null) {
        _profileImage = userProfile.image;
      }
      if (userProfile.user != null && userProfile.user!.firstName != null) {
        _userName = userProfile.user!.firstName;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 10,
                ),
                profileImage()!,
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 12,
                ),
                (!widget.isGuest)
                    ? InkWell(
                        onTap: () {
                          _profileBloc.add(LoadProfile());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ProfileScreen();
                          }));
                        },
                        child: drawerTile(HabitozIcons.user, 'Profile')!)
                    : Container(),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 8,
                ),
                drawerTile(HabitozIcons.fileEarMarkText, 'Terms & Conditions')!,
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 8,
                ),
                drawerTile(
                    HabitozIcons.fluentBookContacts20Regular, 'Contact Us')!,
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 8,
                ),
                (!widget.isGuest)
                    ? InkWell(
                        onTap: () {
                          buildLogout(context);
                        },
                        child: drawerTile(
                            Icons.power_settings_new_outlined, 'Logout')!)
                    : Container(),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 20,
                ),
              ],
            ),
            Positioned(
              bottom: SizeConfig.blockSizeHorizontal * 20,
              child: Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 26,
                  ),
                  Column(
                    children: [
                      Text(
                        'Follow Us',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                            fontFamily: Constants.fontMedium),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      Row(
                        children: [
                          Icon(
                            HabitozIcons.fb,
                            size: SizeConfig.blockSizeHorizontal * 5.5,
                            color: Constants.primaryColor,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 3,
                          ),
                          Icon(
                            HabitozIcons.insta,
                            size: SizeConfig.blockSizeHorizontal * 5.5,
                            color: Constants.primaryColor,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 3,
                          ),
                          Icon(
                            HabitozIcons.youtube,
                            size: SizeConfig.blockSizeHorizontal * 5.5,
                            color: Constants.primaryColor,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 6,
                          ),
                          Icon(
                            HabitozIcons.linkedin,
                            size: SizeConfig.blockSizeHorizontal * 5.5,
                            color: Constants.primaryColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget? profileImage() {
    return Row(
      children: [
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 4,
        ),
        Container(
          height: SizeConfig.blockSizeHorizontal * 20,
          width: SizeConfig.blockSizeHorizontal * 20,
          decoration: BoxDecoration(
              color: Constants.appbarColor,
              shape: BoxShape.circle,
              image: (_profileImage != null)
                  ? DecorationImage(
                      image: NetworkImage(_profileImage!), fit: BoxFit.fill)
                  : const DecorationImage(
                      image: AssetImage('assets/images/png/user_image.png'))),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 3,
        ),
        InkWell(
          onTap: () {
            if (widget.isGuest) {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationRetry(msg: 'Log in'));
              Navigator.pushNamedAndRemoveUntil(
                  context, HabitozRoutes.app, (route) => false);
            }
          },
          child: Text(
            (_userName != null) ? _userName! : 'LOGIN / SIGNUP',
            style: TextStyle(
                fontFamily: Constants.fontMedium,
                fontSize: SizeConfig.blockSizeHorizontal * 5.5),
          ),
        ),
      ],
    );
  }

  Widget? drawerTile(IconData tileIcon, String tileText) {
    return Row(
      children: [
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 7,
        ),
        Icon(tileIcon),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 4,
        ),
        Text(
          tileText,
          style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4.5),
        )
      ],
    );
  }

  buildLogout(BuildContext context) {
    print('buildLogout');
    showDialog(
        context: context,
        //barrierDismissible: false,
        builder: (_) {
          return CustomDialog(
            title: 'Log Out',
            subtitle: 'Do you want to log out? ',
            yesTitle: 'Yes',
            noTitle: 'Cancel',
            yes: () {
              //logout
              Navigator.pop(context, true);
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLoggedOut());
              Navigator.pushNamedAndRemoveUntil(
                  context, HabitozRoutes.app, (route) => false);
            },
            no: () {
              Navigator.pop(context, false);
            },
          );
        });
  }
}
