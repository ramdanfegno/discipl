import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class RectangleBannerTile extends StatelessWidget {
  const RectangleBannerTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 70,
                    child: Text(
                      'Popular fitness centers near you',
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 6,
                          fontFamily: Constants.fontMedium),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                right: SizeConfig.blockSizeHorizontal * 4,
                top: SizeConfig.blockSizeHorizontal*1,
                child: Text(
                  'See all',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                      fontFamily: Constants.fontMedium,
                      color: Constants.primaryColor),
                ))
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeHorizontal * 3,
        ),
        Row(
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 2.5,
            ),
            Expanded(
              child: SizedBox(
                height: SizeConfig.blockSizeHorizontal * 53,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 1.5,
                            right: SizeConfig.blockSizeHorizontal * 1.5),
                        child: Column(
                          children: [
                            Container(
                              height: SizeConfig.blockSizeHorizontal * 50,
                              width: SizeConfig.blockSizeHorizontal * 80,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        offset: Offset(0, 8),
                                        blurRadius: 36)
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.blockSizeHorizontal * 3),
                                  color: Constants.appbarColor),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.blockSizeHorizontal * 3),
                                // Image border
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
