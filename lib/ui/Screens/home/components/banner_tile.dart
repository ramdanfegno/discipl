import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../../bloc/fc_detail_bloc/fc_detail_bloc.dart';
import '../../../../models/home_page_model.dart';
import '../../gym/fitnes_center_details/fitness_center_detail_page.dart';

class BannerTile extends StatelessWidget {
  final bool hasTitle;
  final String? title;
  final List<ContentContent>? content;
  final FCDetailBloc fcDetailBloc;

  const BannerTile(
      {Key? key,
      required this.hasTitle,
      this.title,
      required this.content,
      required this.fcDetailBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4,
          bottom: SizeConfig.blockSizeHorizontal * 3),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 2,
          ),
          (hasTitle)
              ? Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 0),
                      child: SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 75,
                        child: Text(
                          title!,
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 6,
                              fontFamily: Constants.fontMedium),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 2,
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 50,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  return InkWell(
                    onTap: () {
                      //route to fitness detail page
                      //route to fitness detail page
                      fcDetailBloc.add(LoadDetailPage(
                          forceRefresh: true,
                          id: content![index].id.toString()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FitnessCenterDetailPage()));
                    },
                    child: Container(
                        height: SizeConfig.blockSizeHorizontal * 50,
                        width: SizeConfig.blockSizeHorizontal*91,
                        decoration: BoxDecoration(
                            color: Constants.secondaryColor,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeHorizontal * 3)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.blockSizeHorizontal * 3),
                          // Image border
                          child: Image.network(
                            (content![index].image != null)
                                ? content![index].image!
                                : 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                            fit: BoxFit.fill,
                          ),
                        )),
                  );
                }),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 3,
          ),
        ],
      ),
    );
  }
}
