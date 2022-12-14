import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/scroll_setting.dart';
import '../result_display.dart';

class BodyFatView extends StatefulWidget {
  final String result, gender;
  final Map<String, dynamic> data;

  const BodyFatView({
    Key? key,
    required this.result,
    required this.data,
    required this.gender,
  }) : super(key: key);

  @override
  State<BodyFatView> createState() => _BodyFatViewState();
}

class _BodyFatViewState extends State<BodyFatView> {
  late String? _height, _weight, _neck, _waist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _height = '';
    _weight = '';
    _neck = '';
    _waist = '';

    print(widget.gender);
    print('widget.gender');
    print('widget.data');
    print(widget.data);

    if (widget.data.isNotEmpty) {
      print(widget.data);
      if (widget.data['height_cm'] != null) {
        _height = widget.data['height_cm'].toStringAsFixed(0);
      }
      if (widget.data['weight'] != null) {
        _weight = widget.data['weight'].toStringAsFixed(1);
      }
      if (widget.data['neck'] != null) {
        _neck = widget.data['neck'].toStringAsFixed(0);
      }
      if (widget.data['waist'] != null) {
        _waist = widget.data['waist'].toStringAsFixed(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: SizeConfig.blockSizeHorizontal * 15),
            titleLine1(),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
            bodyFatView(context),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
            parameters(),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 50),
          ],
        ),
      ),
    );
  }

  Widget titleLine1() {
    return const Text(
      'BODY FAT RESULT',
      style: TextStyle(
          color: Color.fromRGBO(40, 40, 40, 1),
          fontSize: 22,
          fontFamily: Constants.fontRegular),
    );
  }

  Widget bodyFatView(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(2, 2),
                blurRadius: 10,
                spreadRadius: 5)
          ]),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          title(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          bodyFatReading(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          bodyFatMeter(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: const Text(
              'For your body measurements in order to lose 1% body fat, you must burn at least 7700 calories.',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: Constants.fontRegular),
            ),
          ),

          /*SizedBox(height: SizeConfig.blockSizeHorizontal * 5),

          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: const Text(
              'Lorem ipsum: Lorem ipsum sidm lksdvksmdvkms ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: Constants.fontRegular),
            ),
          ),*/

          /*SizedBox(height: SizeConfig.blockSizeHorizontal * 5),

          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: const Text(
              'Lorem ipsum: Lorem ipsum sidm lksdvksmdvkms ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: Constants.fontRegular),
            ),
          ),*/

          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeightIndicator(color: Colors.yellow[500]!, title: 'Unhealthy'),
              const SizedBox(
                width: 25,
              ),
              const WeightIndicator(
                  color: Colors.lightGreenAccent, title: 'Athletic Body'),
              const SizedBox(
                width: 25,
              ),
              const WeightIndicator(color: Colors.green, title: 'Fit'),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              WeightIndicator(color: Colors.orange, title: 'Average'),
              SizedBox(
                width: 25,
              ),
              WeightIndicator(color: Colors.red, title: 'Obese'),
            ],
          ),
        ],
      ),
    );
  }

  Widget title() {
    return const Text(
      'Your BODY FAT',
      style: TextStyle(
          color: Color.fromRGBO(68, 68, 68, 1),
          fontSize: 18,
          fontFamily: Constants.fontMedium),
    );
  }

  Widget bodyFatReading() {
    String s = '';
    double val = 0;
    Color color = Colors.grey;

    try {
      val = double.parse(widget.result);
      if (widget.gender != null && widget.gender == 'F') {
        if (val > 0) {
          if (val < 13) {
            s = 'UnderWeight';
            color = Colors.blue;
          } else if (val > 13 && val < 20) {
            s = 'Normal';
            color = Colors.green[500]!;
          } else if (val > 20 && val < 24) {
            s = 'Over Weight';
            color = Colors.green;
          } else if (val > 24 && val < 32) {
            s = 'Obese';
            color = Colors.orange;
          } else if (val > 31) {
            s = 'Extremely Obese';
            color = Colors.red;
          }
        }
      } else if (widget.gender != null && widget.gender == 'M') {
        if (val > 0) {
          if (val < 5) {
            s = 'UnderWeight';
            color = Colors.blue;
          } else if (val > 5 && val < 13) {
            s = 'Normal';
            color = Colors.green[500]!;
          } else if (val > 13 && val < 17) {
            s = 'Over Weight';
            color = Colors.green;
          } else if (val > 17 && val < 24) {
            s = 'Obese';
            color = Colors.orange;
          } else if (val > 25) {
            s = 'Extremely Obese';
            color = Colors.red;
          }
        }
      }
    } catch (e) {
      print('bmiStatus');
      print(e.toString());
    }

    return Text(
      '${widget.result} %',
      style: TextStyle(
          color: color, fontSize: 20, fontFamily: Constants.fontSemiBold),
    );
  }

  Widget bodyFatMeter() {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 80,
      height: SizeConfig.blockSizeHorizontal * 60,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: widget.gender == 'F' ? 35 : 30,
              ticksPosition: ElementsPosition.inside,
              tickOffset: 10,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: widget.gender == 'F' ? 13 : 5,
                  color: Colors.yellowAccent,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  endValue: widget.gender == 'F' ? 20 : 13,
                  startValue: widget.gender == 'F' ? 13 : 5,
                  color: Colors.lightGreenAccent,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  startValue: widget.gender == 'F' ? 20 : 13,
                  endValue: widget.gender == 'F' ? 24 : 17,
                  color: Colors.green,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  startValue: widget.gender == 'F' ? 24 : 17,
                  endValue: widget.gender == 'F' ? 31 : 24,
                  color: Colors.orange,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                    startWidth: 20,
                    endWidth: 20,
                    startValue: widget.gender == 'F' ? 31 : 24,
                    endValue: widget.gender == 'F' ? 35 : 30,
                    color: Colors.red),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: double.parse(widget.result),
                  needleStartWidth: 0,
                  needleEndWidth: 5,
                  enableAnimation: true,
                  animationType: AnimationType.ease,
                  //animationDuration: 1,
                )
              ],
              startAngle: 180,
              canScaleToFit: true,
              labelOffset: 20,
              labelsPosition: ElementsPosition.inside,
              endAngle: 0,
              interval: 5)
        ],
      ),
    );
  }

  Widget parameters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Parameters',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: Constants.fontRegular),
          ),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Height',
                style: TextStyle(
                    color: Color.fromRGBO(102, 102, 102, 1),
                    fontSize: 13,
                    fontFamily: Constants.fontRegular),
              ),
              Text(
                '$_height cm',
                style: const TextStyle(
                    color: Color.fromRGBO(34, 34, 34, 1),
                    fontSize: 15,
                    fontFamily: Constants.fontRegular),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Weight',
                style: TextStyle(
                    color: Color.fromRGBO(102, 102, 102, 1),
                    fontSize: 13,
                    fontFamily: Constants.fontRegular),
              ),
              Text(
                '$_weight Kg',
                style: const TextStyle(
                    color: Color.fromRGBO(34, 34, 34, 1),
                    fontSize: 15,
                    fontFamily: Constants.fontRegular),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Neck Size',
                style: TextStyle(
                    color: Color.fromRGBO(102, 102, 102, 1),
                    fontSize: 13,
                    fontFamily: Constants.fontRegular),
              ),
              Text(
                '$_neck cm',
                style: const TextStyle(
                    color: Color.fromRGBO(34, 34, 34, 1),
                    fontSize: 15,
                    fontFamily: Constants.fontRegular),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Waist',
                style: TextStyle(
                    color: Color.fromRGBO(102, 102, 102, 1),
                    fontSize: 13,
                    fontFamily: Constants.fontRegular),
              ),
              Text(
                '$_waist cm',
                style: const TextStyle(
                    color: Color.fromRGBO(34, 34, 34, 1),
                    fontSize: 15,
                    fontFamily: Constants.fontRegular),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
