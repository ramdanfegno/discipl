import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class GymImageContainer extends StatelessWidget {
  const GymImageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.blockSizeHorizontal * 90,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(SizeConfig.blockSizeHorizontal * 4),
                  bottomRight:
                      Radius.circular(SizeConfig.blockSizeHorizontal * 4))),
        ),
        Positioned(
          top: SizeConfig.blockSizeHorizontal * 6,
          right: SizeConfig.blockSizeHorizontal * 4,
          child: Container(
            height: SizeConfig.blockSizeHorizontal * 12,
            width: SizeConfig.blockSizeHorizontal * 12,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Icon(
              HabitozIcons.clarityShareLine,
              color: Constants.primaryColor,
              size: SizeConfig.blockSizeHorizontal*6.5,
            ),
          ),
        )
      ],
    );
  }
}
