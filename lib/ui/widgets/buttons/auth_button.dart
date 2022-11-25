import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class AuthButton extends StatelessWidget {
  final Function() onPressed;
  final Color? color;
  final bool isLoading;
  final String title, fontFamily;
  final double width, height, textSize;

  AuthButton(
      {this.color,
      required this.title,
      required this.onPressed,
      required this.height,
      required this.width,
      required this.textSize,
      required this.isLoading,
      required this.fontFamily});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: (isLoading)
            ? SpinKitThreeBounce(
                color: Colors.white,
                size: textSize,
              )
            : Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontFamily: Constants.fontSemiBold,
              fontSize: textSize),
        ),
      ),
    );
  }
}
