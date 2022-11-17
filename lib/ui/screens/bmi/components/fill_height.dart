import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../../../utils/constants.dart';

class FillHeight extends StatefulWidget {

  final int? height;
  final Function(int) onFilled;

  const FillHeight({Key? key,required this.height,required this.onFilled}) : super(key: key);

  @override
  State<FillHeight> createState() => _FillHeightState();
}

class _FillHeightState extends State<FillHeight> {

  int? _height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _height = widget.height;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        chooseHeight(),
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
      height: SizeConfig.blockSizeHorizontal*70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: SizeConfig.blockSizeHorizontal*20,
            height: SizeConfig.blockSizeHorizontal*60,
            child: WheelChooser.integer(
              onValueChanged: (v){
                _height = v;
                print('_height');
                print(_height);
                setState(() {});
              },
              maxValue: 250,
              minValue: 20,
              initValue: _height,
              selectTextStyle: const TextStyle(
                  color: Constants.fontColor1,
                  fontSize: 20,
                  fontFamily: Constants.fontSemiBold
              ),
              unSelectTextStyle: const TextStyle(
                  color: Color.fromRGBO(204, 204, 204, 1),
                  fontSize: 15,
                  fontFamily: Constants.fontRegular
              ),
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          const Text(
            'Cm',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Constants.fontColor1,
                fontSize: 18,
                fontFamily: Constants.fontSemiBold
            ),
          )
        ],
      ),
    );
  }


}
