import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/widgets/buttons/auth_button.dart';
import 'package:habitoz_fitness_app/ui/widgets/buttons/custom_button.dart';

import '../../../../../utils/constants.dart';
import '../../../../../utils/size_config.dart';

class GymEnquiryTile extends StatelessWidget {
  final Function() requestButtonClicked;
  const GymEnquiryTile({Key? key, required this.requestButtonClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 7,
          ),
          Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 3,
              ),
              const Text(
                'Enquire',
                style: TextStyle(fontFamily: Constants.fontBold),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 3,
          ),
          Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 3,
              ),
              SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 88,
                  child: const Text(
                    'To know more about our offers and services'
                    ' feel free to request for a call back.',
                    style: TextStyle(
                        color: Constants.appbarColor,
                        fontFamily: Constants.fontRegular),
                  ))
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 4.5,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 2.9,
                right: SizeConfig.blockSizeHorizontal * 2.9),
            child: AuthButton(
              fontFamily: Constants.fontMedium,
                color: Constants.primaryColor,
                title: 'Request a Call Back',
                onPressed: () {
                requestButtonClicked();
                },
                height: SizeConfig.blockSizeHorizontal * 14.5,
                width: MediaQuery.of(context).size.width,
                textSize: SizeConfig.blockSizeHorizontal * 4,
                isLoading: false),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal*15,
          ),
        ],
      ),
    );
  }
}
