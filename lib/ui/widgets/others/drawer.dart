import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final bool isGuest;

  const CustomDrawer({Key? key, required this.userName, required this.isGuest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                drawerTile(HabitozIcons.user, 'Profile')!,
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
                (!isGuest)
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
          userName,
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
}
