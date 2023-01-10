import 'package:flutter/material.dart';

import '../../../../../models/home_page_model.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/size_config.dart';

class ImageCarousel extends StatefulWidget {
  final List<String?>? imageList;
  final double aspectRatio;
  final List<String?>? productRangeList;
  final List<String?>? titleList;
  final List<ImageModel>? images;

  // ignore: use_key_in_widget_constructors
  const ImageCarousel(
      {this.imageList,
      this.aspectRatio = 2,
      this.productRangeList,
      this.titleList,
      this.images});

  @override
  State<StatefulWidget> createState() => ImageCarouselState();
}

class ImageCarouselState extends State<ImageCarousel> {
  int _current = 0;
  final _controller = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    _controller.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData themeData = Theme.of(context);

    return Stack(children: [
      PageView(
        controller: _controller,
        pageSnapping: true,
        allowImplicitScrolling: true,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
        children: List.generate(
            widget.imageList!.length,
            (index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        SizeConfig.blockSizeHorizontal * 3),
                    topRight: Radius.circular(
                        SizeConfig.blockSizeHorizontal * 3),
                    bottomRight: Radius.circular(
                        SizeConfig.blockSizeHorizontal * 3),
                    bottomLeft: Radius.circular(
                        SizeConfig.blockSizeHorizontal * 3)),
                child: Image.network(
                  (widget.imageList![index] != null)
                      ? widget.imageList![index]!
                      : 'https://st4.depositphotos.com/17828278/24401/v/600/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            )),
      ),
      Positioned(
          bottom: 15,
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: widget.imageList!.length == 1
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.imageList!.map((url) {
                      int index = widget.imageList!.indexOf(url);
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Constants.primaryColor
                              : Colors.white.withOpacity(0.3),
                        ),
                      );
                    }).toList(),
                  ),
          ))
    ]);
  }
}
