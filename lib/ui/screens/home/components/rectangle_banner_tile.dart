import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/bloc/fc_detail_bloc/fc_detail_bloc.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../../models/home_page_model.dart';
import '../../gym/fitnes_center_details/fitness_center_detail_page.dart';

class RectangleBannerTile extends StatelessWidget {

  final String? title;
  final List<ContentContent>? content;
  final Function()? seeAllPressed;
  final FCDetailBloc fcDetailBloc;

  const RectangleBannerTile({Key? key,required this.content,this.title,this.seeAllPressed,required this.fcDetailBloc}) : super(key: key);

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
                      (title != null) ? title! : '',
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
                child: InkWell(
                  onTap: (){
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
        Row(
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 2.5,
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 53,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: content!.length,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: (){
                        //route to fitness detail page
                        fcDetailBloc.add(LoadDetailPage(forceRefresh: true, id: content![index].id.toString()));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const FitnessCenterDetailPage()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 1.5,
                            right: SizeConfig.blockSizeHorizontal * 1.5),
                        child: Container(
                          height: SizeConfig.blockSizeHorizontal * 50,
                          width: SizeConfig.blockSizeHorizontal * 80,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    offset: const Offset(0, 8),
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
                              (content![index].image != null) ? content![index].image!
                                  : 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
