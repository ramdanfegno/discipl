import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';

class SearchTile extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  SearchTile({this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        // go to product listing page
        onPressed!();
      },
      child: Container(
        height: SizeConfig.blockSizeHorizontal * 12,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 14, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Color.fromRGBO(34, 34, 34, 1),
                  fontSize: 14,
                  fontFamily: Constants.fontRegular),
            ),
            Icon(
              Icons.subdirectory_arrow_right_sharp,
              color: Colors.grey[500],
              size: 17,
            )
          ],
        ),
      ),
    );
  }
}
