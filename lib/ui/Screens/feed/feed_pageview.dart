import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../models/home_page_model.dart';

class FeedListViewPage extends StatefulWidget {
  final HomePageModelContent? data;

  const FeedListViewPage({Key? key, required this.data}) : super(key: key);

  @override
  State<FeedListViewPage> createState() => _FeedListViewPageState();
}

class _FeedListViewPageState extends State<FeedListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isHomeAppBar: false,
        appBarTitle: (widget.data != null && widget.data!.title != null)
            ? widget.data!.title!.toUpperCase()
            : 'Transformation',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 5,
            ),
            (widget.data != null)
                ? Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.data!.content!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 4,
                                right: SizeConfig.blockSizeHorizontal * 4,
                                top: SizeConfig.blockSizeHorizontal * 2,
                                bottom: SizeConfig.blockSizeHorizontal * 2),
                            child: Container(
                              height: SizeConfig.blockSizeHorizontal * 75,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Constants.fontColor1,
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.blockSizeHorizontal * 3)),
                              child: Column(children: [
                                Container(
                                  height: SizeConfig.blockSizeHorizontal * 55,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Constants.appbarColor,
                                      borderRadius: BorderRadius.circular(
                                          SizeConfig.blockSizeHorizontal * 3)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.blockSizeHorizontal *
                                            3), // Image border
                                    child: Image.network(
                                      (widget.data!.content![index].image !=
                                              null)
                                          ? widget.data!.content![index].image!
                                          : 'https://cpworldgroup.com/wp-content/uploads/2021/01/placeholder.png',
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
                                      (widget.data!.content![index].title !=
                                              null)
                                          ? widget.data!.content![index].title!
                                          : '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: Constants.fontRegular,
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5.2),
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
                                        (widget.data!.content![index]
                                                    .fitnessCenter!.name !=
                                                null)
                                            ? widget.data!.content![index]
                                                .fitnessCenter!.name!
                                            : '',
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: Constants.fontRegular,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4)),
                                  ],
                                )
                              ]),
                            ),
                          );
                        }),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
