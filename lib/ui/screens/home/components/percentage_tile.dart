import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class PercentageTIile extends StatelessWidget {
  final double value;

  const PercentageTIile({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4),
      child: Container(
        height: SizeConfig.blockSizeHorizontal * 30,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2.5),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.09))
            ]),
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
                  'Please complete your profile',
                  style: TextStyle(
                      fontFamily: Constants.fontMedium,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.3),
                ),
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
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 72,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10)),
                    child: LinearProgressIndicator(
                      minHeight: SizeConfig.blockSizeHorizontal * 2.5,
                      color: Constants.primaryColor,
                      backgroundColor: Constants.timeContainerColor,
                      value: value,
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 3,
                ),
                Text(
                  '${value.toString()} %',
                  style: TextStyle(
                      fontFamily: Constants.fontRegular,
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5),
                )
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
                Text('Continue to add more information',
                    style: TextStyle(
                        fontFamily: Constants.fontRegular,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                        color: Constants.secondaryColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}