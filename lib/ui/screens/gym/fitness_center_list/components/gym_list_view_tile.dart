import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/fitness_center_list_model.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class GymListViewTile extends StatelessWidget {
  final FitnessCenterModel? fcData;
  final Function() onListTilePressed;

  const GymListViewTile(
      {Key? key, required this.fcData, required this.onListTilePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String categoryNames = '';
    for (int i = 0; i < fcData!.category!.length; i++) {
      if (fcData!.category![i].name != null &&
          fcData!.category![i].name != '') {
        if (i != 0) {
          categoryNames += ',';
        }
        categoryNames += fcData!.category![i].name!;
      }
    }
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
                width: SizeConfig.blockSizeHorizontal * 34.8,
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
                        (fcData!.name != null) ? fcData!.name! : '',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                            fontFamily: Constants.fontBold),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      /*Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeHorizontal * 1),
                        child: Icon(
                          HabitozIcons.star,
                          size: SizeConfig.blockSizeHorizontal * 3.8,
                          color: Constants.starColor,
                        ),
                      ),*/
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1,
                      ),

                      /// need to get data here

                      Text(
                        (fcData!.rating != null) ? fcData!.rating! : '',
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

                  /// need to verify data here

                  Text(
                    categoryNames,
                    style: TextStyle(
                        color: Constants.appbarColor,
                        fontFamily: Constants.fontRegular,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal * 1,
                  ),

                  /// need to get data here

                  Text(
                    'Free trial not available',
                    style: TextStyle(
                        fontFamily: Constants.fontRegular,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                        color: (false)
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

                      /// need to verify data here

                      Text(
                        (fcData!.institution!.zone != null)
                            ? fcData!.institution!.zone!.name!
                            : 'Location',
                        style: TextStyle(
                            color: Constants.appbarColor,
                            fontFamily: Constants.fontRegular,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1,
                      ),
                      /*Container(
                        width: SizeConfig.blockSizeHorizontal * 0.3,
                        height: SizeConfig.blockSizeHorizontal * 6,
                        color: Constants.appbarColor,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 1,
                      ),

                      /// need to get data here
                      Text(
                        '5 Kms away',
                        style: TextStyle(
                            color: Constants.appbarColor,
                            fontFamily: Constants.fontRegular,
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                      )*/
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
