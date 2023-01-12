import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:habitoz_fitness_app/models/fitness_center_list_model.dart';
import 'package:habitoz_fitness_app/models/home_page_model.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../../../utils/disciple_icons_icons.dart';

class GymDetailContainer extends StatelessWidget {
  final String gymName, place, distance, description;
  final List<Amenities> category;

  const GymDetailContainer({
    Key? key,
    required this.gymName,
    required this.place,
    required this.distance,
    required this.description,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 5,
          ),
          Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 4,
              ),
              Text(
                gymName,
                style: TextStyle(
                    fontFamily: Constants.fontBold,
                    fontSize: SizeConfig.blockSizeHorizontal * 5),
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal * 5,
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 3,
          ),
          Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 2.5,
              ),
              const Icon(
                DiscipleIcons.location_red_small_size,
                size: 16,
                color: Constants.primaryColor,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 1,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 26,
                child: Text(
                  place,
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4,
                      fontFamily: Constants.fontMedium),
                ),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 20,
              ),
              Row(
                children: [
                  Text(
                      (distance == '1')
                          ? '$distance Km away your location'
                          : '$distance Kms away your location',
                      style: const TextStyle(
                          color: Constants.blackLowerShade,
                          fontSize: 13,
                          fontFamily: Constants.fontRegular)),
                ],
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 3,
          ),
          Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 4,
              ),

              /*Text('',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4,
                      fontFamily: Constants.fontBold)),*/
              /*SizedBox(
                width: SizeConfig.blockSizeHorizontal * 16,
              ),*/
              /* SizedBox(
                child: RatingBar.builder(
                    itemSize: SizeConfig.blockSizeHorizontal * 5,
                    initialRating: 3,
                    minRating: 0,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 0.5),
                    allowHalfRating: true,
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Constants.starColor,
                        ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    }),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 1,
              ),
              const Text(
                '10 Reviwes',
                style: TextStyle(
                    fontFamily: Constants.fontRegular,
                    fontSize: 13,
                    color: Constants.appbarColor),
              )*/
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 5,
          ),
          SizedBox(
              width: SizeConfig.blockSizeHorizontal * 93,
              child: Text(
                description,
                style: const TextStyle(color: Constants.appbarColor),
              ))
        ],
      ),
    );
  }
}
