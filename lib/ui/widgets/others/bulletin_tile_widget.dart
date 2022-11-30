import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/fitness_center_list_model.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../utils/constants.dart';

class BulletinTileWidget extends StatelessWidget {
  final String bulletinHeading;
  final List<Amenities>? category;

  const BulletinTileWidget({Key? key, required this.bulletinHeading,required this.category})
      : super(key: key);

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
              Text(
                bulletinHeading,
                style: const TextStyle(fontFamily: Constants.fontBold),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 3,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: category!.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:  EdgeInsets.only(top: SizeConfig.blockSizeHorizontal*1),
                  child: Row(
                    children: [
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 4,
                      ),
                       Text(
                        Constants.bulletinSymbol,
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal*6,
                            fontFamily: Constants.fontMedium,
                            color: Constants.bulletinColor),
                      ),
                      SizedBox(0
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal*90,
                        child: Text(
                          (category![index].name  != null) ? category![index].name! : '',
                          style: const TextStyle(
                          fontFamily: Constants.fontRegular,
                          color: Constants.appbarColor
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
