import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class FeedListViewPage extends StatelessWidget {
  final String description, fitnessCenter;

  const FeedListViewPage(
      {Key? key, required this.description, required this.fitnessCenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isHomeAppBar: false,
        appBarTitle: 'Transformation',
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 5,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
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
                                'https://imgk.timesnownews.com/story/sonakshi_0.gif',
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
                                description,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: Constants.fontRegular,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 5.2),
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
                              Text(fitnessCenter,
                                  style: TextStyle(
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
          ],
        ),
      ),
    );
  }
}
