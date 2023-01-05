import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/components/image_carousel.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../../bloc/fc_detail_bloc/fc_detail_bloc.dart';
import '../../../../models/home_page_model.dart';
import '../../gym/fitnes_center_details/fitness_center_detail_page.dart';

class CarouselBannerTile extends StatelessWidget {
  final bool hasTitle;
  final String? title;
  final List<ContentContent>? content;
  final FCDetailBloc fcDetailBloc;

  CarouselBannerTile({
    Key? key,
    required this.hasTitle,
    this.title,
    required this.content,
    required this.fcDetailBloc,
  }) : super(key: key);

  List<String>? image_car = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 2,
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 61,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: content!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  // for(int i = 0; i<=content!.length;i++ ){
                  //   print('loopppp');
                  //   image_car!.add(content![i].image!);
                  //   print(image_car!.length);
                  // }

                  return InkWell(
                    onTap: () {
                      //route to fitness detail page
                      //route to fitness detail page
                      fcDetailBloc.add(LoadDetailPage(
                          forceRefresh: true,
                          id: content![index].fitnessCenter!.id.toString()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FitnessCenterDetailPage(
                                    onBackPressed: () {},
                                  )));
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 13),
                              child: SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 76,
                                child: title != null
                                    ? Text(
                                        title!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontFamily: Constants.fontMedium),
                                      )
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        SizedBox(
                            height: SizeConfig.blockSizeHorizontal * 50,
                            width: SizeConfig.blockSizeHorizontal * 91,
                            child: ImageCarousel())
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(
            height: SizeConfig.blockSizeHorizontal * 0,
          ),
        ],
      ),
    );
  }

// Widget imageCarouselWidget(List<ImageModel> carousel_image) {
//   print(carousel_image.length);
//   return ImageCarousel(
//     imageList: (image_car!.map((e) => e.image)).toList(),
//     images: carousel_image,
//     aspectRatio: 1,
//   );
// }
}
