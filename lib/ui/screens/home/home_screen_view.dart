import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/bloc/fc_detail_bloc/fc_detail_bloc.dart';
import 'package:habitoz_fitness_app/bloc/fc_list_bloc/fc_list_bloc.dart';
import 'package:habitoz_fitness_app/models/home_page_model.dart';
import 'package:habitoz_fitness_app/models/zone_list_model.dart';
import 'package:habitoz_fitness_app/ui/screens/feed/feed_pageview.dart';
import 'package:habitoz_fitness_app/ui/screens/home/components/category_list_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/zone_search/choose_location.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../utils/constants.dart';
import '../../../utils/habitoz_icons.dart';
import '../gym/fitness_center_list/fitness_center_listview.dart';
import 'components/banner_tile.dart';
import 'components/percentage_tile.dart';
import 'components/rectangle_banner_tile.dart';
import 'components/square_banner_tile.dart';

class HomeScreenView extends StatelessWidget {
  final HomePageModel? homeData;
  final FCDetailBloc fcDetailBloc;
  final FCListBloc fcListBloc;
  final bool isProfileCompleted;
  final Function(ZoneResult) onLocationChanged;
  final Function() onProfileClicked;

  final ZoneResult? zoneResult;

  const HomeScreenView(
      {Key? key,
        required this.onLocationChanged,
        required this.onProfileClicked,
        required this.isProfileCompleted,
        required this.homeData,
        required this.fcListBloc,
        required this.zoneResult,
        required this.fcDetailBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return (homeData != null)
        ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 4,
                ),
                locationWidget(context)!,
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 4,
                ),
                (!isProfileCompleted && homeData!.profilePercentage != null)
                    ? InkWell(
                        onTap: () {
                          onProfileClicked();
                        },
                        child: PercentageTile(
                            value: (homeData!.profilePercentage != null)
                                ? homeData!.profilePercentage!.toDouble()
                                : 0),
                      )
                    : Container(),
                _content(context, homeData!.content!),
              ],
            ),
          )
        : Container();
  }

  Widget _content(BuildContext context, List<HomePageModelContent> content) {
    return ListView.builder(
        itemCount: content.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (content[index].content!.isNotEmpty) {
            switch (content[index].model) {
              case 'icons':
                return _buildIcons(context, content[index]);
              case 'rectangle_tiles':
                return _buildRectangleTiles(context, content[index]);
              case 'square_tiles':
                return _buildSquareTiles(context, content[index]);
              case 'banner_tiles':
                return _buildBannerTiles(context, content[index]);
              default:
                return Container();
            }
          }
          return Container();
        });
  }

  Widget? locationWidget(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 4,
        ),
        const Text(
          'Select your Location :',
          style: TextStyle(fontFamily: Constants.fontRegular),
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 12,
        ),
        const Icon(
          Icons.location_on,
          color: Constants.primaryColor,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChooseLocation(
                          onLocationUpdated: (val) {
                            onLocationChanged(val);
                          },
                        )));
          },
          child: Row(
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 3,
              ),
              Text(
                  (zoneResult != null && zoneResult!.name != null)
                      ? zoneResult!.name!
                      : (homeData!.zone != null && homeData!.zone!.name != null) ? homeData!.zone!.name! : '',
                  style: const TextStyle(fontFamily: Constants.fontRegular)),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 7,
              ),
              Icon(
                HabitozIcons.downArrow,
                size: SizeConfig.blockSizeHorizontal * 2.7,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildIcons(BuildContext context, HomePageModelContent? content) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeHorizontal * 4,
          left: SizeConfig.blockSizeHorizontal * 4),
      child: CategoryListTile(
        content: content!.content,
        fcListBloc: fcListBloc,
        zoneResult: zoneResult,
      ),
    );
  }

  Widget _buildRectangleTiles(
      BuildContext context, HomePageModelContent? content) {
    return RectangleBannerTile(
      title: content!.title,
      content: content.content,
      fcDetailBloc: fcDetailBloc,
      seeAllPressed: () {
        // route to fitness listing page with slug
        fcListBloc.add(LoadListingPage(
          forceRefresh: true,
          slug: 'fc',
          pageNo: 1,
          zone: zoneResult
        ));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FitnessCenterListView(
                    title: content.title!.toUpperCase(), slug: 'fc',zone: zoneResult,)));
      },
    );
  }

  Widget _buildBannerTiles(
      BuildContext context, HomePageModelContent? content) {
    return BannerTile(
      hasTitle: false,
      title: content!.title,
      content: content.content,
      fcDetailBloc: fcDetailBloc,
    );
  }

  Widget _buildSquareTiles(
      BuildContext context, HomePageModelContent? content) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 4),
      child: SquareBannerTile(
        title: content!.title!,
        content: content.content,
        seeAllPressed: () {
          // route to feedpage
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FeedListViewPage(data: content);
          }));
        },
      ),
    );
  }
}
