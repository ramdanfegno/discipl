import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/disciple_icons_icons.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:habitoz_fitness_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../../utils/routes.dart';
import '../../../utils/web_View.dart';
import '../dialog/custom_dialog.dart';

class CustomDrawer extends StatefulWidget {
  final String? userName;
  final bool isGuest;
  final Function() closeDrawer;
  

  const CustomDrawer(
      {Key? key,
      required this.userName,
      required this.isGuest,
      required this.closeDrawer})
      : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late ProfileBloc _profileBloc;
  String? _profileImage, _userName;
  final UserRepository userRepository = UserRepository();
  final uriFaceBook = Uri.parse('fb://https://www.facebook.com/thediscipl');

  void runWeb(String url) {
    runWebView(url);
  }

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    getProfileImage();
  }

  getProfileImage() async {
    print('getProfileImage');
    UserProfile? userProfile = await userRepository.getProfileDetailsLocal();
    if (userProfile != null) {
      if (userProfile.image != null) {
        _profileImage = userProfile.image;
      }
      if (userProfile.user != null && userProfile.user!.firstName != null) {
        _userName = userProfile.user!.firstName;
      }

      print(_profileImage);
      print(_userName);

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
                          _closeDrawer();

                          _profileBloc.add(LoadProfile());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ProfileScreen();
                          }));
                          widget.closeDrawer();
                        },
                        child: drawerTile(HabitozIcons.user, 'Profile')!)
                    : Container(),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 8,
                ),
                InkWell(
                  onTap: (){
                 runWeb('http://wp-habitoz.uat.fegno.com/legal/privacy-policy.pdf');
                  },
                    child: drawerTile(HabitozIcons.fileEarMarkText, 'Terms & Conditions')!),
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
                            DiscipleIcons.logout, 'Logout')!)
                    : Container(),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 20,
                ),
              ],
            ),
            Positioned(
              bottom: SizeConfig.blockSizeHorizontal * 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 24,
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
                          InkWell(
                            child: Icon(
                              HabitozIcons.fb,
                              size: SizeConfig.blockSizeHorizontal * 5.5,
                              color: Constants.primaryColor,
                            ),
                            onTap: (){
                              _launchUrl();
                            },
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
                            DiscipleIcons.linkedin,
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
                      image: NetworkImage(_profileImage!), fit: BoxFit.cover)
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
          child: SizedBox(
            width: SizeConfig.blockSizeHorizontal * 50,
            child: Text(
              (_userName != null) ? _userName! : 'LOGIN / SIGNUP',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: Constants.fontMedium,
                  fontSize: SizeConfig.blockSizeHorizontal * 5.5),
            ),
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
        Icon(tileIcon,size: 20,),
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

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  runWebView(String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WebViewScreen(
          url: url,
          canPop: true,
          onBackPressed: (val) {
            if (val != null) {
              Fluttertoast.showToast(msg: val, toastLength: Toast.LENGTH_SHORT);
            }
          },
          onWebViewCompleted: (val) async {
            print('onWebViewCompleted');
            print(val);
          });
    }));
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(uriFaceBook)) {
      throw 'Could not launch $uriFaceBook';
    }
  }
}
