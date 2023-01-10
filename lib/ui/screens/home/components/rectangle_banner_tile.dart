import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/disciple_icons_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../../bloc/fc_detail_bloc/fc_detail_bloc.dart';
import '../../../../models/home_page_model.dart';
import '../../../Screens/gym/fitnes_center_details/fitness_center_detail_page.dart';

class RectangleBannerTile extends StatelessWidget {
  final String? title;
  final List<ContentContent>? content;
  final Function()? seeAllPressed;
  final FCDetailBloc fcDetailBloc;

  const RectangleBannerTile(
      {Key? key,
      required this.content,
      this.title,
      this.seeAllPressed,
      required this.fcDetailBloc})
      : super(key: key);

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
                    width: SizeConfig.blockSizeHorizontal * 76,
                    child: Text(
                      (title != null) ? title! : '',
                      style: const TextStyle(
                          fontSize: 18, fontFamily: Constants.fontMedium),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                right: SizeConfig.blockSizeHorizontal * 6,
                top: SizeConfig.blockSizeHorizontal * 0,
                child: InkWell(
                  onTap: () {
                    seeAllPressed!();
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: Constants.fontMedium,
                        color: Constants.primaryColor),
                  ),
                ))
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeHorizontal * 4,
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
                    itemCount: content!.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, int index) {
                      ContentContent _content = content![index];
                      return InkWell(
                          onTap: () {
                            //route to fitness detail page
                            fcDetailBloc.add(LoadDetailPage(
                                forceRefresh: true,
                                id: content![index].id.toString()));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FitnessCenterDetailPage(
                                          onBackPressed: () {},
                                        )));
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 1.5,
                                  right: SizeConfig.blockSizeHorizontal * 1.5),
                              child: SizedBox(
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                          SizeConfig.blockSizeHorizontal * 50,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 79,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: (content![index].logo !=
                                                      null)
                                                  ? NetworkImage(
                                                      content![index].logo!)
                                                  : const AssetImage(
                                                          'assets/images/png/rectangle_holder.png')
                                                      as ImageProvider),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.00),
                                                offset: const Offset(0, 8),
                                                blurRadius: 36)
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.blockSizeHorizontal *
                                                  3),
                                          color: Constants.appbarColor),
                                    ),
                                    Positioned(
                                        bottom: SizeConfig.blockSizeHorizontal *
                                            3.1,
                                        child: Container(
                                          height:
                                              SizeConfig.blockSizeHorizontal *
                                                  50,
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  79,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                        )),
                                    Positioned(
                                      bottom:
                                          SizeConfig.blockSizeHorizontal * 6,
                                      left: SizeConfig.blockSizeHorizontal * 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                              ),
                                              Text(
                                                content![index].name != null
                                                    ? content![index].name!
                                                    : '',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        Constants.fontMedium),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeHorizontal *
                                                    1,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                DiscipleIcons
                                                    .location_red_small_size,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                              ),
                                              Text(
                                                content![index].zone != null
                                                    ? content![index]
                                                        .zone!
                                                        .name!
                                                    : 'Location',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1,
                                              ),
                                              Container(
                                                height: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4,
                                                width: 1,
                                                color: Colors.white,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        1,
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        40,
                                                    height: SizeConfig
                                                            .blockSizeHorizontal *
                                                        5,
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemCount: 1,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Row(
                                                            children: [
                                                              SizedBox(
                                                                width: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),
                                                              Text(
                                                                _content.category!
                                                                        .isNotEmpty
                                                                    ? _content
                                                                        .category![
                                                                            index]
                                                                        .name!
                                                                    : '',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              SizedBox(
                                                                width: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    1,
                                                              ),
                                                              Container(
                                                                height: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    4,
                                                                width: 1,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              content![index].km != null
                                                                  ? Text(
                                                                '${content![index].km.toString()} Km',
                                                                style: const TextStyle(
                                                                    color: Colors.white),
                                                              )
                                                                  : Container()
                                                            ],
                                                          );
                                                        }),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )));
                    }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
