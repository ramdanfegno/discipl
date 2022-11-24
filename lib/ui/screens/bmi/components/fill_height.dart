import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../../../utils/constants.dart';

class FillHeight extends StatefulWidget {

  final int? heightCM;
  final Function(int) onFilled;

  const FillHeight({Key? key,required this.heightCM,required this.onFilled}) : super(key: key);

  @override
  State<FillHeight> createState() => _FillHeightState();
}

class _FillHeightState extends State<FillHeight> {

  int? _heightCM;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.heightCM != null){
      _heightCM = widget.heightCM;
    }
    else{
      _heightCM = 160;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title(),
        SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
        chooseHeight(),
      ],
    );
  }

  Widget title() {
    return const Center(
      child: Text(
        'My Height',
        style: TextStyle(
            color: Color.fromRGBO(68, 68, 68, 1),
            fontSize: 18,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget chooseHeight(){
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal*50,
      height: SizeConfig.blockSizeHorizontal*90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: SizeConfig.blockSizeHorizontal*25,
            height: SizeConfig.blockSizeHorizontal*90,
            child: WheelChooser.integer(
              onValueChanged: (v){
                _heightCM = v;
                print('_height');
                print(_heightCM);
                setState(() {});
                widget.onFilled(_heightCM!);
              },
              maxValue: 300,
              minValue: 20,
              initValue: _heightCM,
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

          const SizedBox(
            width: 1,
          ),

          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'Cm',
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
