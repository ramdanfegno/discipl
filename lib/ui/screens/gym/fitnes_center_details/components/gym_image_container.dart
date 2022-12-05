import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/fitness_center_list_model.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/components/image_carousel.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import 'dart:math' as math;

import '../../../../../models/home_page_model.dart';

class GymImageContainer extends StatelessWidget {
  final List<ImageModel> imageCarousel;

  const GymImageContainer(
      {Key? key, required this.imageCarousel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.blockSizeHorizontal * 90,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(SizeConfig.blockSizeHorizontal * 4),
                  bottomRight:
                      Radius.circular(SizeConfig.blockSizeHorizontal * 4))),
          child: imageCarouselWidget(imageCarousel),
        ),
        Positioned(
          top: SizeConfig.blockSizeHorizontal * 6,
          right: SizeConfig.blockSizeHorizontal * 4,
          child: Container(
            height: SizeConfig.blockSizeHorizontal * 12,
            width: SizeConfig.blockSizeHorizontal * 12,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Icon(
              HabitozIcons.clarityShareLine,
              color: Constants.primaryColor,
              size: SizeConfig.blockSizeHorizontal * 6.5,
            ),
          ),
        ),
        Positioned(
            top: SizeConfig.blockSizeHorizontal * 8,
            left: SizeConfig.blockSizeHorizontal * 4,
            child: Transform.rotate(
                angle: -math.pi,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      HabitozIcons.arrow,
                      size: 32,
                    )))),
      ],
    );
  }

  Widget imageCarouselWidget(List<ImageModel> carousel_image) {
    print(carousel_image.length);
    return ImageCarousel(
      imageList: (imageCarousel.map((e) => e.image)).toList(),
      images: carousel_image,
      aspectRatio: 1,
    );
  }
}
