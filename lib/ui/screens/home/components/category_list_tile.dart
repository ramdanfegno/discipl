import 'package:flutter/material.dart';

import '../../../../bloc/fc_list_bloc/fc_list_bloc.dart';
import '../../../../models/home_page_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../gym/fitness_center_list/fitness_center_listview.dart';

class CategoryListTile extends StatelessWidget {
  final List<ContentContent>? content;
  final FCListBloc fcListBloc;

  const CategoryListTile(
      {Key? key,
        required this.content,
        required this.fcListBloc,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (content != null) ?
    SizedBox(
      height: SizeConfig.blockSizeHorizontal * 27,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: content!.length,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1.5,
                  right: SizeConfig.blockSizeHorizontal * 1.5),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      // route to fitness listing page
                      // route to fitness listing page with slug
                      fcListBloc.add(
                          LoadListingPage(
                            forceRefresh: true,
                            slug: content![index].id.toString(),
                            pageNo: 1,
                          ));

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FitnessCenterListView(
                                      title: content![index].title!.toUpperCase(),
                                      slug: content![index].id.toString())));
                    },
                    child: Container(
                        height: SizeConfig.blockSizeHorizontal*19.5,
                        width: SizeConfig.blockSizeHorizontal * 19.5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Constants.primaryColor),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3),
                        child: Image.network(
                          (content![index].logo != null) ? content![index].logo! : '',
                          fit: BoxFit.contain,
                        )
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal*2,
                  ),
                  Text(
                    (content![index].name != null) ? content![index].name! : '',
                    style: const TextStyle(
                        fontFamily: Constants.fontRegular
                    ),),
                ],
              ),
            );
          }),
    ) : Container();
  }
}
