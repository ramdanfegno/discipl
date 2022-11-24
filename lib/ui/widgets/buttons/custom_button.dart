import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;

  final String title;
  final double? width,height;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;

  CustomButton(
      {required this.backgroundColor,
        required this.borderColor,
        required this.title,
        required this.titleColor,
        this.width,this.height,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: (height != null) ? height : SizeConfig.blockSizeHorizontal * 12,
        width: (width != null) ? width : SizeConfig.blockSizeHorizontal * 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
            color: backgroundColor),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: titleColor,
            ),
          ),
        ),
      ),
    );
  }
}
