import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class GymListViewTile extends StatelessWidget {
  final String gymName, rating, gymnasium, place, distance;
  final bool isFreeTrialAvailable;
  final Function() onListTilePressed;

  const GymListViewTile(
      {Key? key,
      required this.gymName,
      required this.rating,
      required this.gymnasium,
      required this.isFreeTrialAvailable,
      required this.place,
      required this.distance,
      required this.onListTilePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: SizeConfig.blockSizeHorizontal * 3.5),
      child: InkWell(
        onTap: () {
          onListTilePressed();
        },
        child: SizedBox(
          child: Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 4,
              ),
              Container(
                height: SizeConfig.blockSizeHorizontal * 35.8,
                width: SizeConfig.blockSizeHorizontal * 37.8,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(
                        SizeConfig.blockSizeHorizontal * 2)),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        gymName,
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                            fontFamily: Constants.fontBold),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeHorizontal * 1),
                        child: Icon(
                          HabitozIcons.star,
                          size: SizeConfig.blockSizeHorizontal * 3.8,
                          color: Constants.starColor,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1,
                      ),
                      Text(
                        rating,
                        style: TextStyle(
                            color: Constants.fontColor3,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                            fontFamily: Constants.fontRegular),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 1,
                  ),
                  Text(
                    gymnasium,
                    style: TextStyle(
                        color: Constants.appbarColor,
                        fontFamily: Constants.fontRegular,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 1,
                  ),
                  Text(
                    (isFreeTrialAvailable)
                        ? 'Free trial available'
                        : 'Free trial not available',
                    style: TextStyle(
                        fontFamily: Constants.fontRegular,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                        color: (isFreeTrialAvailable)
                            ? Constants.fontColor3
                            : Constants.primaryColor),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Constants.primaryColor,
                        size: SizeConfig.blockSizeHorizontal * 3.8,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1,
                      ),
                      Text(
                        place,
                        style: TextStyle(
                            color: Constants.appbarColor,
                            fontFamily: Constants.fontRegular,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 0.3,
                        height: SizeConfig.blockSizeHorizontal * 6,
                        color: Constants.appbarColor,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1,
                      ),
                      Text(
                        '$distance Kms away',
                        style: TextStyle(
                            color: Constants.appbarColor,
                            fontFamily: Constants.fontRegular,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
