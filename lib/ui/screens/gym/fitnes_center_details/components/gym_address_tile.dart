import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class GymAddressTile extends StatelessWidget {
  final String address;

  const GymAddressTile({Key? key, required this.address}) : super(key: key);

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
              Text(
                'Address',
                style: TextStyle(fontFamily: Constants.fontBold),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal*3,
          ),
          Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal*3,
              ),
              SizedBox(
              width: SizeConfig.blockSizeHorizontal*85,
                child: Text(address,style: TextStyle(color: Constants.appbarColor,fontFamily: Constants.fontRegular),))],
          )
        ],
      ),
    );
  }
}
