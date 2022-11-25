import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../utils/constants.dart';

class BulletinTileWidget extends StatelessWidget {
  final String bulletinHeading,title;

  const BulletinTileWidget({Key? key, required this.bulletinHeading, required this.title})
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
            physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
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
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal*90,
                        child: Text(title,style: TextStyle(
                          fontFamily: Constants.fontRegular,
                          color: Constants.appbarColor
                        ),),
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
