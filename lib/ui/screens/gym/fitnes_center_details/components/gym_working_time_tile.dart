import 'package:flutter/material.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/size_config.dart';

class GymWorkingTimeTile extends StatelessWidget {
  final String time;

  const GymWorkingTimeTile({Key? key, required this.time}) : super(key: key);

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
                width: SizeConfig.blockSizeHorizontal * 3,
              ),
              const Text(
                'Working Time',
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
                width: SizeConfig.blockSizeHorizontal*1.5,
              ),
              Expanded(
                child: SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 12,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1.5,
                              right: SizeConfig.blockSizeHorizontal * 1.5),
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.blockSizeHorizontal * 2),
                                color: Constants.timeContainerColor),
                            child: Center(
                                child: Text(
                              time,
                              style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontFamily: Constants.fontMedium),
                            )),
                          ),
                        );
                      }),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
