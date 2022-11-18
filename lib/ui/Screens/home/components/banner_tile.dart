import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class BannerTile extends StatelessWidget {
  const BannerTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4),
      child: Container(
          height: SizeConfig.blockSizeHorizontal * 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Constants.secondaryColor,
              borderRadius:
                  BorderRadius.circular(SizeConfig.blockSizeHorizontal * 3)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                SizeConfig.blockSizeHorizontal * 3), // Image border
            child: Image.network(
              'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
              fit: BoxFit.fill,
            ),
          )),
    );
  }
}
