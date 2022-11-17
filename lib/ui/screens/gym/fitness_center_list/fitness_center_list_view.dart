import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitnes_center_details/fitness_center_list_detail_page.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitness_center_list/components/gym_list_view_tile.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class FitnessCenterListView extends StatefulWidget {
  const FitnessCenterListView({Key? key}) : super(key: key);

  @override
  _FitnessCenterListViewState createState() => _FitnessCenterListViewState();
}

class _FitnessCenterListViewState extends State<FitnessCenterListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appBarTitle: 'Fitness Center List',
        isHomeAppBar: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 7.5,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 4,
                  right: SizeConfig.blockSizeHorizontal * 4),
              child: Container(
                height: SizeConfig.blockSizeHorizontal * 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        SizeConfig.blockSizeHorizontal * 3),
                    border: Border.all(color: Colors.black)),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                          color: Constants.secondaryColor,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.5),
                      icon: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 4),
                        child: Icon(
                          HabitozIcons.epSearch,
                          color: Constants.secondaryColor,
                          size: SizeConfig.blockSizeHorizontal * 4.5,
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 7,
            ),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 4,
                ),
                Text(
                  'Showing 23 results for Fitness centers in Kochi',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 3.4,
                      fontFamily: Constants.fontMedium,
                      color: Constants.fontColor1),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 3,
                ),
                Text(
                  'Change',
                  style: TextStyle(
                      color: Constants.primaryColor,
                      fontFamily: Constants.fontBold,
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                ),
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return GymListViewTile(
                    gymName: 'Name of Gymnasium',
                    rating: '4.4',
                    gymnasium: 'Gymnasium',
                    isFreeTrialAvailable: true,
                    place: 'Vazhakala',
                    distance: '5',
                    onListTilePressed: () {

                      /*============Gym detail Page===============*/

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FitnessCenterListDetailPage(
                                  )));
                    },
                  );
                }),


          ],
        ),
      ),
    );
  }
}
