import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';

import '../../../../utils/constants.dart';
import 'measure_view.dart';

class MeasureView2 extends StatefulWidget {

  final String title;
  final double? measurementInch;
  final double? measurementCM;
  final Function(double,double) onFilled;

  const MeasureView2({Key? key,required this.title,required this.measurementInch,required this.measurementCM,required this.onFilled}) : super(key: key);

  @override
  State<MeasureView2> createState() => _MeasureView2State();
}

class _MeasureView2State extends State<MeasureView2> {

  late double? _measurementInch,_measurementCM;
  late bool isCM;
  RulerPickerController? _rulerPickerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isCM = true;
    _measurementCM = 0;
    _measurementInch = 0;
    if(widget.measurementInch != null && widget.measurementInch! > 0){
      _measurementInch = widget.measurementInch;
    }
    else{
      _measurementInch = 0;
    }
    if(widget.measurementCM != null && widget.measurementInch! > 0){
      _measurementCM = widget.measurementCM;
    }
    else{
      _measurementCM = 0;
    }

    _rulerPickerController = RulerPickerController(value: _measurementCM!.toInt());

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: SizeConfig.blockSizeHorizontal * 15),
        switchMeter(),
        SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
        title(),
        SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
        chooseValue(),
      ],
    );
  }

  Widget title() {
    String val = '';
    if(isCM){
      val = '${_measurementCM!.toStringAsFixed(0)} cm';
    }
    else{
      val = '${_measurementInch!.toStringAsFixed(0)} Inch';
    }
    return Center(
      child: Text(
        'My ${widget.title} is:  $val',
        style: const TextStyle(
            color: Color.fromRGBO(68, 68, 68, 1),
            fontSize: 18,
            fontFamily: Constants.fontSemiBold
        ),
      ),
    );
  }

  Widget switchMeter(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            isCM = false;
            setState(() {});
          },
          child: Container(
            height: SizeConfig.blockSizeHorizontal*9,
            width: SizeConfig.blockSizeHorizontal*20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (isCM) ? const Color.fromRGBO(237, 237, 237, 1) : Colors.red,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              'Inch',
              style: TextStyle(
                  color: (isCM) ? Colors.black : Colors.white,
                  fontSize: 14,
                  fontFamily: Constants.fontRegular
              ),
            ),
          ),
        ),
        const SizedBox(width: 20,),
        InkWell(
          onTap: (){
            isCM = true;
            setState(() {});
          },
          child: Container(
            height: SizeConfig.blockSizeHorizontal*9,
            width: SizeConfig.blockSizeHorizontal*20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (!isCM) ? const Color.fromRGBO(237, 237, 237, 1) : Colors.red,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              'Cm',
              style: TextStyle(
                  color: (!isCM) ? Colors.black : Colors.white,
                  fontSize: 14,
                  fontFamily: Constants.fontRegular
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget chooseValue(){
    return (isCM) ? buildCMRuler() : buildInchRuler();
  }

  Widget buildCMRuler(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: SizeConfig.blockSizeHorizontal*20,
      child: RulerPicker(
          controller: _rulerPickerController!,
          beginValue: 0,
          endValue: 300,
          initValue: _measurementCM!.toInt(),
          scaleLineStyleList: const [
            ScaleLineStyle(
                color: Colors.grey, width: 1.5, height: 30, scale: 0),
            ScaleLineStyle(
                color: Colors.grey, width: 1, height: 25, scale: 5),
            ScaleLineStyle(
                color: Colors.grey, width: 1, height: 15, scale: -1)
          ],
          onValueChange: (value) {
            _measurementCM = value.toDouble();
            _measurementInch = _measurementCM! / 2.54;
            setState(() {});
            widget.onFilled(_measurementCM!,_measurementInch!);
          },
          width: MediaQuery.of(context).size.width,
          height: SizeConfig.blockSizeHorizontal*20,
          rulerMarginTop: 0,
          marker:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:CrossAxisAlignment.center,
              children:[

                CustomPaint(
                  painter: TrianglePainter1(
                    strokeColor: Colors.black,
                    strokeWidth: 10,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  child: const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                ),
                Container(
                  width: 10,
                  height: 30,
                  color: Colors.black,
                ),

                CustomPaint(
                  painter: TrianglePainter2(
                    strokeColor: Colors.black,
                    strokeWidth: 10,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  child: const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                )
              ]
          )
      ),
    );
  }

  Widget buildInchRuler(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: SizeConfig.blockSizeHorizontal*60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: SizeConfig.blockSizeHorizontal*20,
            height: SizeConfig.blockSizeHorizontal*60,
            child: WheelChooser.integer(
              onValueChanged: (v){
                _measurementInch = v.toDouble();
                _measurementCM = _measurementInch! * 2.54;
                setState(() {});
                widget.onFilled(_measurementCM!,_measurementInch!);
              },
              maxValue: 200,
              minValue: 0,
              initValue: _measurementInch!.toInt(),
              selectTextStyle: const TextStyle(
                  color: Constants.fontColor1,
                  fontSize: 24,
                  fontFamily: Constants.fontSemiBold
              ),
              listHeight: SizeConfig.blockSizeHorizontal*90,
              unSelectTextStyle: const TextStyle(
                  color: Color.fromRGBO(204, 204, 204, 1),
                  fontSize: 15,
                  fontFamily: Constants.fontRegular
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'Inch',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Constants.fontColor1,
                  fontSize: 18,
                  fontFamily: Constants.fontRegular
              ),
            ),
          )
        ],
      ),
    );
  }

}

