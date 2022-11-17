import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class GymDetailContainer extends StatelessWidget {
  final String gymName, place, distance, gymnasium, description;

  const GymDetailContainer(
      {Key? key,
      required this.gymName,
      required this.place,
      required this.distance,
      required this.gymnasium,
      required this.description})
      : super(key: key);

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
                Icons.location_pin,
                color: Constants.primaryColor,
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
                width: SizeConfig.blockSizeHorizontal * 10,
              ),
              Text('$distance Kms away your location',
                  style: TextStyle(
                      color: Constants.blackLowerShade,
                      fontSize: SizeConfig.blockSizeHorizontal * 4,
                      fontFamily: Constants.fontRegular)),
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
              Text(gymnasium,
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4,
                      fontFamily: Constants.fontBold)),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 16,
              ),
              SizedBox(
                child: RatingBar.builder(
                    itemSize: SizeConfig.blockSizeHorizontal * 5,
                    initialRating: 3,
                    minRating: 1,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 0.5),
                    allowHalfRating: true,
                    itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Constants.starColor,
                        ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    }),
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 2.3,
              ),
              Text(
                '10 Reviwes',
                style: TextStyle(
                    fontFamily: Constants.fontRegular,
                    fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                    color: Constants.appbarColor),
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal*5,
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal*93,
              child: Text(description,style: TextStyle(color: Constants.appbarColor),))
        ],
      ),
    );
  }
}
