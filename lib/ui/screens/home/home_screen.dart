import 'dart:html';

import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/screens/home/components/banner_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/home/components/invite_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/home/components/percentage_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/home/components/rectangle_banner_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/home/components/square_banner_tile.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/circular_sliding_tile.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../widgets/others/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late bool isProfileCompleted;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isProfileCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(
        isGuest: false,
        userName: 'Ramdan Salim',
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeHorizontal * 6,
                      ),

                      /*========Location Widget==========*/

                      locationWidget()!,
                      SizedBox(
                        height: SizeConfig.blockSizeHorizontal * 4,
                      ),

                      /*========Percentage Widget==========*/

                      (!isProfileCompleted)
                          ? const PercentageTIile(
                              value: 0.3,
                            )
                          : Container(),

                      /*========Workout type  Widget==========*/

                      const CircularSlidingTile(
                          hasHeading: false,
                          heading: '',
                          circularIcons: HabitozIcons.fb,
                          iconTitle: 'Gym'),
                      SizedBox(
                        height: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      BannerTile(hasTitle: false),
                      RectangleBannerTile(),
                      SquareBannerTile(
                        description: 'Lost 8 kg in 2 months',
                        fitnessCenter: 'Name of fitness center',
                      ),
                      BannerTile(
                        hasTitle: true,
                        title: 'Best Offers',
                      ),
                      InviteTile()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget? locationWidget() {
    return Row(
      children: [
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 4,
        ),
        const Text(
          'Select your Location :',
          style: TextStyle(fontFamily: Constants.fontRegular),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 12,
        ),
        const Icon(
          Icons.location_on,
          color: Constants.primaryColor,
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 3,
        ),
        const Text('Kakkanad',
            style: TextStyle(fontFamily: Constants.fontRegular)),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 7,
        ),
        Icon(
          HabitozIcons.downArrow,
          size: SizeConfig.blockSizeHorizontal * 2.7,
        )
      ],
    );
  }
}
