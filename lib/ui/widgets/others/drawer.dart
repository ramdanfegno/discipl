import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/repositories/product_repo.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:habitoz_fitness_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authentication_bloc/authentication_bloc.dart';
import '../dialog/custom_dialog.dart';

class CustomDrawer extends StatefulWidget {
  final String userName;
  final bool isGuest;

  const CustomDrawer({Key? key, required this.userName, required this.isGuest})
      : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
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
                profileimage()!,
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 12,
                ),
                InkWell(
                    onTap: (){
                      _profileBloc.add(LoadProfile());
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const ProfileScreen();
                      }));
                    },
                    child: drawerTile(HabitozIcons.user, 'Profile')!),
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
                    ? drawerTile(HabitozIcons.shutdown, 'Logout')!
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

  Widget? profileimage() {
    return Row(
      children: [
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 4,
        ),
        Container(
          height: SizeConfig.blockSizeHorizontal * 20,
          width: SizeConfig.blockSizeHorizontal * 20,
          decoration: BoxDecoration(
              color: Constants.appbarColor, shape: BoxShape.circle),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 3,
        ),
        Text(
          widget.userName,
          style: TextStyle(
              fontFamily: Constants.fontMedium,
              fontSize: SizeConfig.blockSizeHorizontal * 5.5),
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

  Widget buildLogout(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: () {
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
                  },
                  no: () {
                    Navigator.pop(context, false);
                  },
                );
              });
        },
        child: Container(
          color: Colors.white,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
          alignment: Alignment.centerLeft,
          child: const Text('Logout',
              style: TextStyle(
                  color: Color.fromRGBO(34, 34, 34, 1),
                  fontSize: 16,
                  fontFamily: Constants.fontSemiBold)),
        ),
      ),
    );
  }

}
