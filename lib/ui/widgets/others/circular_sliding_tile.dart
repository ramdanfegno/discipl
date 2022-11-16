import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class CircularSlidingTile extends StatelessWidget {
  final bool hasHeading;
  final String heading,iconTitle;
  final IconData circularIcons;

  const CircularSlidingTile(
      {Key? key,
      required this.hasHeading,
      required this.heading,
      required this.circularIcons, required this.iconTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: (hasHeading) ? SizeConfig.blockSizeHorizontal * 10 : 0,
          ),
          Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 3,
              ),
              Text(
                (hasHeading) ? heading : '',
                style: TextStyle(fontFamily: Constants.fontBold),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 4,
          ),
          Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 1,
              ),
              Expanded(
                child: SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 27,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1.5,
                              right: SizeConfig.blockSizeHorizontal * 1.5),
                          child: Column(
                            children: [
                              Container(
                                height: SizeConfig.blockSizeHorizontal*20,
                                width: SizeConfig.blockSizeHorizontal * 20,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Constants.primaryColor),
                                child: Center(
                                    child: Icon(
                                  circularIcons,
                                  color: Colors.white,
                                  size: SizeConfig.blockSizeHorizontal * 9,
                                )),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal*2,
                              ),
                              Text(iconTitle,style: TextStyle(
                                fontFamily: Constants.fontMedium
                              ),),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }
}
