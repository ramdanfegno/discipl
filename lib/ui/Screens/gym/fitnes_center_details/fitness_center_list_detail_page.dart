import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitnes_center_details/components/gym_detail_tile.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitnes_center_details/components/gym_image_container.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/components/gym_address_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/components/gym_enquiry_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/components/gym_plan_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/components/gym_working_time_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/request_callback_page.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/bulletin_tile_widget.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/circular_sliding_tile.dart';

import '../../../../utils/habitoz_icons.dart';

class FitnessCenterListDetailPage extends StatefulWidget {
  const FitnessCenterListDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FitnessCenterListDetailPage> createState() =>
      _FitnessCenterListDetailPageState();
}

class _FitnessCenterListDetailPageState
    extends State<FitnessCenterListDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /*=====Gym image carousel=========*/
              const GymImageContainer(),

              /*=========Gym Detail Container=========*/

              const GymDetailContainer(
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipisci elit, '
                    'sed eiusmod Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod',
                gymnasium: 'Gymnasium',
                gymName: 'Name of Gymnasium',
                place: 'Vazhakala',
                distance: '5',
              ),

              /*=======Gym address Tile========*/

              const GymAddressTile(
                address:
                    'Ghala heights Chittethukkara, ernakulam, KP Kurian Rd, beside Jain flat, Kakkanad, Kerala 682037',
              ),

              /*=======Gym time Tile========*/

              const GymWorkingTimeTile(
                time: '9:00-11:30',
              ),

              /*=======Gym amenities Tile========*/

              const CircularSlidingTile(
                iconTitle: 'Elevator',
                hasHeading: true,
                heading: 'Amenities',
                circularIcons: HabitozIcons.elevator,
              ),

              /*=======Gym services Tile========*/

              const BulletinTileWidget(
                bulletinHeading: 'Other Services',
                title: 'Zumba',
              ),

              /*=======Gym rules Tile========*/

              const BulletinTileWidget(
                  bulletinHeading: 'Rules',
                  title: 'Cell phones are prohibited from use in the gym.'),

              /*=======Gym plan Tile========*/

              const GymPlanTile(
                plan: '2000',
                planTitle: 'Lorem ipsum dolor sit amet',
              ),

              /*=======Gym enquiry Tile========*/

              GymEnquiryTile(
                requestButtonClicked: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RequestCallBackPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
