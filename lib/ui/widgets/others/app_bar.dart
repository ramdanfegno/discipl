import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomeAppBar;
  final String? appBarTitle;
  final Function() onBackPressed;
  final Function()? drawerClicked;
  final Function()? searchClicked;

  const CustomAppBar(
      {Key? key,
        required this.isHomeAppBar,
        required this.appBarTitle,
        required this.onBackPressed,
        this.drawerClicked,
      this.searchClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.05))
        ]),
        height: (isHomeAppBar) ? SizeConfig.blockSizeHorizontal * 20 : SizeConfig.blockSizeHorizontal * 20 ,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*5,right: SizeConfig.blockSizeHorizontal*2),
              child: (!isHomeAppBar) ?
              InkWell(
                onTap: () {
                 onBackPressed();
                },
                child: Container(
                  height: SizeConfig.blockSizeHorizontal * 7,
                  width: SizeConfig.blockSizeHorizontal * 7,
                  decoration: const BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: SizeConfig.blockSizeHorizontal * 3,
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
                        size: SizeConfig.blockSizeHorizontal * 5,
                      ),
                    );
                  }
              ),
            ),

            (!isHomeAppBar)
                ? Expanded(
                  child: Text(
                    appBarTitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 4,
                        fontFamily: Constants.fontMedium),
                  ),
                )
                : Padding(
                  padding:  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*40),
                  child: Container(
                    height: SizeConfig.blockSizeHorizontal * 9,
                    width: SizeConfig.blockSizeHorizontal*16,
                    color: Colors.white,
                    child: /*SvgPicture.asset('assets/images/png/logo.png'),*/
                     Image.asset(
                      'assets/images/png/logo.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),


            (isHomeAppBar) ?
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeHorizontal * 0,
                right: SizeConfig.blockSizeHorizontal * 1
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      searchClicked!();
                      },
                    child: Icon(
                      HabitozIcons.epSearch,
                      size: SizeConfig.blockSizeHorizontal * 6,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  const Icon(HabitozIcons.notification2),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 1,
                  ),
                ],
              ),
            ) : SizedBox(width: SizeConfig.blockSizeHorizontal*2,)
          ],
        ),
      ),
    );
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(SizeConfig.blockSizeHorizontal * 25);
}

