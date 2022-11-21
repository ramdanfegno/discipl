import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomeAppBar;
  final String? appBarTitle;
  final Function()? drawerClicked;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.05))
        ]),
        height: SizeConfig.blockSizeHorizontal * 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            ),
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 8),
              child: (!isHomeAppBar)
                  ? InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: SizeConfig.blockSizeHorizontal * 9,
                        width: SizeConfig.blockSizeHorizontal * 9,
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: SizeConfig.blockSizeHorizontal * 5,
                        ),
                      ),
                    )
                  : Builder(
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
            SizedBox(
              width: ((!isHomeAppBar)
                  ? MediaQuery.of(context).size.width / 5.5
                  : 0),
            ),
            (!isHomeAppBar)
                ? Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeHorizontal * 8),
                    child: Container(
                      child: Center(
                        child: Text(
                          appBarTitle!,
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 5,
                              fontFamily: Constants.fontMedium),
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.blockSizeHorizontal * 5,
                      ),
                      Container(
                        height: SizeConfig.blockSizeHorizontal * 21.5,
                        child: Image.asset(
                          'assets/images/jpg/logo.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
            (isHomeAppBar)
                ? SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 35,
                  )
                : Container(),
            (isHomeAppBar)
                ? Padding(
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
                  )
                : Container()
          ],
        ),
      );
  }

  const CustomAppBar(
      {Key? key,
      required this.isHomeAppBar,
      required this.appBarTitle,
      this.drawerClicked})
      : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(SizeConfig.blockSizeHorizontal * 18);
}
