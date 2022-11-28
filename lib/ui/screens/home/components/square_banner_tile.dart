import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/home_page_model.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class SquareBannerTile extends StatelessWidget {
  final String title;
  final List<ContentContent>? content;
  final Function() seeAllPressed;

  const SquareBannerTile(
      {Key? key,
      required this.title,
      required this.content,
      required this.seeAllPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: SizeConfig.blockSizeHorizontal * 2,
      ),
      Stack(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                child: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 75,
                  child: Text(
                    'Featured Transformation',
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
              top: SizeConfig.blockSizeHorizontal * 1,
              child: InkWell(
                onTap: () {
                  seeAllPressed!();
                },
                child: Text(
                  'See all',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                      fontFamily: Constants.fontMedium,
                      color: Constants.primaryColor),
                ),
              ))
        ],
      ),
      SizedBox(
        height: SizeConfig.blockSizeHorizontal * 3,
      ),
      Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 4,
        ),
        child: SizedBox(
          height: SizeConfig.blockSizeHorizontal * 75,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: content!.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: SizeConfig.blockSizeHorizontal * 4,
                      top: SizeConfig.blockSizeHorizontal * 2,
                      bottom: SizeConfig.blockSizeHorizontal * 2),
                  child: Container(
                    height: SizeConfig.blockSizeHorizontal * 50,
                    width: SizeConfig.blockSizeHorizontal * 75,
                    decoration: BoxDecoration(
                        color: Constants.fontColor1,
                        borderRadius: BorderRadius.circular(
                            SizeConfig.blockSizeHorizontal * 3)),
                    child: Column(children: [
                      Container(
                        height: SizeConfig.blockSizeHorizontal * 50,
                        width: SizeConfig.blockSizeHorizontal * 75,
                        decoration: BoxDecoration(
                            color: Constants.appbarColor,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeHorizontal * 3)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.blockSizeHorizontal *
                                  3), // Image border
                          child: Image.network(
                            (content![index].image != null)
                                ? content![index].image!
                                : '',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeHorizontal * 2.5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 4,
                          ),
                          Text(
                            (content![index].title != null)
                                ? content![index].title!
                                : '',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                                fontFamily: Constants.fontRegular,
                                fontSize: SizeConfig.blockSizeHorizontal * 5.2),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 4,
                          ),
                          Text(
                              (content![index].name != null)
                                  ? content![index].name!
                                  : '',
                              style: TextStyle(
                                  overflow: TextOverflow.fade,
                                  color: Colors.white,
                                  fontFamily: Constants.fontRegular,
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 4)),
                        ],
                      )
                    ]),
                  ),
                );
              }),
        ),
      )
    ]);
  }
}
