import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomeAppBar;
  final String? appBarTitle;
  final Function()? drawerClicked;

  const CustomAppBar(
      {Key? key,
        required this.isHomeAppBar,
        required this.appBarTitle,
        this.drawerClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.05))
      ]),
      height: SizeConfig.blockSizeHorizontal * 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5),
            child: (!isHomeAppBar) ?
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: SizeConfig.blockSizeHorizontal * 7,
                width: SizeConfig.blockSizeHorizontal * 7,
                decoration: const BoxDecoration(
                    color: Colors.black, shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: SizeConfig.blockSizeHorizontal * 4,
                ),
              ),
            )
                :
            Builder(
                builder: (context) {
                  return InkWell(
                    onTap: () {
                      drawerClicked!();
                    },
                    child: Icon(
                      HabitozIcons.codiconMenu,
                      size: SizeConfig.blockSizeHorizontal * 8,
                    ),
                  );
                }
            ),
          ),

          (!isHomeAppBar)
              ? Center(
                child: Text(
                  appBarTitle!,
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4,
                      fontFamily: Constants.fontMedium),
                ),
              )
              :
          Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeHorizontal * 5,
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal * 21.5,
                child: Image.asset(
                  'assets/images/jpg/logo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          (isHomeAppBar) ?
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.blockSizeHorizontal * 8),
            child: Row(
              children: [
                Icon(
                  HabitozIcons.epSearch,
                  size: SizeConfig.blockSizeHorizontal * 6,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 6,
                ),
                const Icon(HabitozIcons.notification2)
              ],
            ),
          ) : SizedBox(width: SizeConfig.blockSizeHorizontal*12,)
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(SizeConfig.blockSizeHorizontal * 18);
}