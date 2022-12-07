import 'package:flutter/material.dart';
import '../../../models/fitness_center_list_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';

class CircularSlidingTile extends StatelessWidget {
  final List<Amenities> content;
  final String? title;

  const CircularSlidingTile(
      {Key? key, required this.content, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.blockSizeHorizontal * 3,
        ),
        Row(
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 4,
            ),
            Text(
              title!,
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                  fontFamily: Constants.fontMedium),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeHorizontal * 3,
        ),
        (content != null)
            ? SizedBox(
                height: SizeConfig.blockSizeHorizontal * 27,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: content.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 4,
                            right: SizeConfig.blockSizeHorizontal * 1.5),
                        child: Column(
                          children: [
                            Container(
                              height: SizeConfig.blockSizeHorizontal * 19.5,
                              width: SizeConfig.blockSizeHorizontal * 19.5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        (content[index].logo != null)
                                            ? content[index].logo!
                                            : '',
                                      )),
                                  shape: BoxShape.circle,
                                  color: Constants.primaryColor),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(3),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeHorizontal * 2,
                            ),
                            Text(
                              (content[index].name != null)
                                  ? content[index].name!
                                  : 'Amenities',
                              style: const TextStyle(
                                  fontFamily: Constants.fontRegular),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            : Container()
      ],
    );
  }
}
