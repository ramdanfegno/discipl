import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/fitness_center_list_model.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/size_config.dart';

class GymPlanTile extends StatelessWidget {
  final List<Plan> plan;

  const GymPlanTile({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 10,
          ),
          Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 4,
              ),
              const Text(
                'Our Plans',
                style: TextStyle(fontFamily: Constants.fontBold),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 3,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: plan.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        Text(
                          (plan[index].amount != null)
                              ? '${Constants.currencySymbol}${plan[index].amount.toString()}'
                              : '',
                          style: TextStyle(
                              fontFamily: Constants.fontBold,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.5),
                        ),
                        Text(
                          '/ Month',
                          style: TextStyle(
                              fontFamily: Constants.fontMedium,
                              fontSize: SizeConfig.blockSizeHorizontal * 5.5),
                        )
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeHorizontal * 1.5,
                          bottom: SizeConfig.blockSizeHorizontal * 1.5),
                      child: Row(
                        children: [
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 4,
                          ),
                          Icon(
                            HabitozIcons.tick,
                            size: SizeConfig.blockSizeHorizontal * 3.2,
                            color: Constants.tickColor,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2.5,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal*40,
                            child: Text(
                              (plan[index].duration != null)
                                  ? plan[index].duration!
                                  : '',
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: Constants.fontRegular,
                                  color: Constants.appbarColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeHorizontal * 1.5,
                          bottom: SizeConfig.blockSizeHorizontal * 1.5),
                      child: Row(
                        children: [
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 4,
                          ),
                          Icon(
                            HabitozIcons.tick,
                            size: SizeConfig.blockSizeHorizontal * 3.2,
                            color: Constants.tickColor,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2.5,
                          ),
                          SizedBox(
                            width:SizeConfig.blockSizeHorizontal*85,
                            child: Text(
                              (plan[index].description != null)
                                  ? plan[index].description!
                                  : '',
                              style: const TextStyle(
                                  fontFamily: Constants.fontRegular,
                                  color: Constants.appbarColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 4,
                          right: SizeConfig.blockSizeHorizontal * 4),
                      child: Divider(
                        thickness: SizeConfig.blockSizeHorizontal * 0.2,
                        color: Constants.bulletinColor,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 3,
                    ),
                  ],
                );
              })
        ],
      ),
    );
  }
}
