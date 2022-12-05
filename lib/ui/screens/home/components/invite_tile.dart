import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/widgets/buttons/auth_button.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class InviteTile extends StatelessWidget {
  const InviteTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4,
          bottom: SizeConfig.blockSizeHorizontal * 6),
      child: Container(
        height: SizeConfig.blockSizeHorizontal * 42,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(SizeConfig.blockSizeHorizontal * 3),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  offset: Offset(0, 8),
                  blurRadius: 36)
            ]),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 8,
            ),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 4,
                ),
                Text(
                  'Invite your friends',
                  style: TextStyle(
                      fontFamily: Constants.fontMedium,
                      fontSize: 20),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 10,
                ),
                AuthButton(
                    color: Constants.primaryColor,
                    title: 'Invite',
                    onPressed: () {},
                    height: SizeConfig.blockSizeHorizontal * 12,
                    width: SizeConfig.blockSizeHorizontal * 25,
                    textSize: SizeConfig.blockSizeHorizontal * 4,
                    isLoading: false,
                    fontFamily: Constants.fontMedium)
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
                  width: SizeConfig.blockSizeHorizontal * 75,
                  child: Text(
                    'Let your friends explore the way to a healthy life.',
                    style: TextStyle(
                        color: Constants.bulletinColor,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
