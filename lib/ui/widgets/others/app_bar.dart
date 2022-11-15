import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomeAppBar;
  final String? appBarTitle;

  const CustomAppBar(
      {Key? key, required this.isHomeAppBar, required this.appBarTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.white.withOpacity(0.5),
      leading: (isHomeAppBar)
          ? Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              height: 50,
              width: 50,
            )
          : Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 2),
              child: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.black,
              ),
            ),
      backgroundColor: Colors.white,
      title: (isHomeAppBar)
          ? Container()
          : Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 2),
              child: Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 9,
                  ),
                  Text(
                    appBarTitle!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: Constants.fontSemiBold),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(SizeConfig.blockSizeHorizontal * 18);
}
