import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/scroll_setting.dart';
import '../result_display.dart';

class BMIView extends StatefulWidget {
  final bool isFromHome;
  final String result;
  final Map<String,dynamic> data;
  const BMIView({Key? key,required this.isFromHome,required this.data,required this.result}) : super(key: key);

  @override
  _BMIViewState createState() => _BMIViewState();
}

class _BMIViewState extends State<BMIView> {

  late bool isExpanded;
  late double _height,_weight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isExpanded = false;
    _height = 0;
    _weight = 0;
    if(widget.data.isNotEmpty){
      if(widget.data['height_cm'] != null){
        _height = widget.data['height_cm'];
      }
      if(widget.data['weight'] != null){
        _weight = widget.data['weight'];
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
            bmiView(),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
            parameters(),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 50),
          ],
        ),
      ),
    );
  }

  Widget titleLine1() {
    return  Text(
        (widget.isFromHome) ? 'Your Result!' : 'BMI RESULT',
      style: const TextStyle(
          color: Color.fromRGBO(40, 40, 40, 1),
          fontSize: 22,
          fontFamily: Constants.fontRegular),
    );
  }

  Widget bmiView(){
    return Container(
      width: SizeConfig.blockSizeHorizontal*90,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(2,2),
                blurRadius: 10,
              spreadRadius: 5
            )
          ]
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          title(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          bmiReading(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
          bmiStatus(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          bmiMeter(),
          (isExpanded) ? expandedView() : Container(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          expandButton(),
        ],
      ),
    );
  }

  Widget title() {
    return const Text(
      'Your BMI',
      style: TextStyle(
          color: Color.fromRGBO(68, 68, 68, 1),
          fontSize: 18,
          fontFamily: Constants.fontMedium),
    );
  }

  Widget bmiReading() {
    return Text(
      '${widget.result} Kg/m2',
      style: const TextStyle(
          color: Colors.green,
          fontSize: 20,
          fontFamily: Constants.fontSemiBold),
    );
  }

  Widget bmiMeter() {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal*80,
      height: SizeConfig.blockSizeHorizontal*60,
      child: SfRadialGauge(
        axes:  <RadialAxis> [
          RadialAxis(
              minimum: 0,
              maximum: 100,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: 20,
                  color:Colors.blue,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  startValue: 20,
                  endValue: 40,
                  color: Colors.green,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  startValue: 40,
                  endValue: 60,
                  color: Colors.yellow,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  startValue: 60,
                  endValue: 80,
                  color: Colors.orange,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                    startWidth: 20,
                    endWidth: 20,
                    startValue: 80,
                    endValue: 100,
                    color: Colors.red
                ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: double.parse(widget.result),
                  needleStartWidth: 0,
                  needleEndWidth: 5,
                )],
              startAngle: 180,
              canScaleToFit: true,
              endAngle: 0,
              interval: 20)
        ],
      ),
    );
  }

  Widget bmiStatus() {
    return const Text(
      'Normal',
      style: TextStyle(
          color: Colors.green,
          fontSize: 12,
          fontFamily: Constants.fontRegular),
    );
  }

  Widget expandButton(){
    return InkWell(
      onTap: (){
        isExpanded = !isExpanded;
        setState(() {});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'View More',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: Constants.fontRegular),
          ),

          const SizedBox(
            width: 10,
          ),

          Icon(
            (isExpanded) ? Icons.keyboard_arrow_up_sharp : Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
            size: 17,
          )
        ],
      ),
    );
  }

  Widget expandedView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: SizeConfig.blockSizeHorizontal * 5),

        const Text(
          'Healthy BMI range: 18.5 Kg/m2 - 25.5 Kg/m2',
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: Constants.fontRegular),
        ),

        SizedBox(height: SizeConfig.blockSizeHorizontal * 5),

        const Text(
          'Healthy weight for the height: 49.8 Kg - 67.2 Kg',
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: Constants.fontRegular),
        ),

        SizedBox(height: SizeConfig.blockSizeHorizontal * 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            WeightIndicator(color: Colors.blue, title: 'Under weight'),
            SizedBox(width: 25,),
            WeightIndicator(color: Colors.green, title: 'Normal'),
            SizedBox(width: 25,),
            WeightIndicator(color: Colors.yellow, title: 'Over weight'),
          ],
        ),

        SizedBox(height: SizeConfig.blockSizeHorizontal * 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            WeightIndicator(color: Colors.orange, title: 'Obese'),
            SizedBox(width: 25,),
            WeightIndicator(color: Colors.green, title: 'Extremely Obese'),
          ],
        ),
        //SizedBox(height: SizeConfig.blockSizeHorizontal * 10),

      ],
    );
  }

  Widget parameters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [

          const Text(
            'Your Parameters',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: Constants.fontRegular),
          ),

          SizedBox(height: SizeConfig.blockSizeHorizontal*5),

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
                '${_height.toStringAsFixed(0)} cm',
                style: const TextStyle(
                    color: Color.fromRGBO(34, 34, 34, 1),
                    fontSize: 15,
                    fontFamily: Constants.fontRegular),
              ),
            ],
          ),

          SizedBox(height: SizeConfig.blockSizeHorizontal*5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [

              const Text(
                'Weight',
                style: TextStyle(
                    color: Color.fromRGBO(102, 102, 102, 1),
                    fontSize: 13,
                    fontFamily: Constants.fontRegular),
              ),

              Text(
                '${_weight.toStringAsFixed(1)} Kg',
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
