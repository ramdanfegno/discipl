import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/home_page_model.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/size_config.dart';

class GymWorkingTimeTile extends StatelessWidget {
  final List<WorkingTime>? time;

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
                      itemCount: time!.length,
                      itemBuilder: (context, int index) {
                        String s = '';
                        if(time![index].opensAt != null){
                          s += time![index].opensAt!;
                          s += ' to ';
                        }
                        if(time![index].closesAt != null){
                          s += time![index].closesAt!;
                        }

                        return Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1.5,
                              right: SizeConfig.blockSizeHorizontal * 1.5),
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 38,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.blockSizeHorizontal * 2),
                                color: Constants.timeContainerColor),
                            child: Center(
                                child: Text(
                              s,
                              style: const TextStyle(
                                fontSize: 12.5,
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
