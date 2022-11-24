import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import '../../../../utils/constants.dart';

class FillWeight extends StatefulWidget {

  final double? weight;
  final Function(double) onFilled;

  const FillWeight({Key? key,required this.weight,required this.onFilled}) : super(key: key);

  @override
  State<FillWeight> createState() => _FillWeightState();
}

class _FillWeightState extends State<FillWeight> {

  double? _weight;
  int? _kg,_gm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.weight != null){
      print(widget.weight);
      _weight = widget.weight;
    }
    else{
      _weight = 60.0;
      _kg = 60;
      _gm = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        title(),
        SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
        chooseWeight(),
      ],
    );
  }

  Widget title() {
    return const Center(
      child: Text(
        'My Weight',
        style: TextStyle(
            color: Color.fromRGBO(68, 68, 68, 1),
            fontSize: 18,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget chooseWeight(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildKg(),
        buildGm()
      ],
    );
  }

  Widget buildKg(){
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal*35,
      height: SizeConfig.blockSizeHorizontal*90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: SizeConfig.blockSizeHorizontal*15,
            height: SizeConfig.blockSizeHorizontal*80,
            child: WheelChooser.integer(
              onValueChanged: (v){
                _kg = v;
                int i = _weight!.round();
                _weight = _weight! - i;
                _weight = _weight! + _kg!;
                setState(() {});
                print('_weight');
                print(_weight);
                widget.onFilled(_weight!);
              },
              maxValue: 250,
              minValue: 20,
              initValue: _kg,
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

          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'Kg',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Constants.fontColor1,
                  fontSize: 17,
                  fontFamily: Constants.fontRegular
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGm(){
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal*35,
      height: SizeConfig.blockSizeHorizontal*60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: SizeConfig.blockSizeHorizontal*15,
            height: SizeConfig.blockSizeHorizontal*60,
            child: WheelChooser(
              datas: const [
                0,100,200,300,400,500,600,700,800,900
              ],
              onValueChanged: (v){
                _gm = v;
                int i = _weight!.round();
                print('i');
                print(i);
                _weight = i + (_gm!/1000);
                setState(() {});
                print('_weight');
                print(_weight);
                widget.onFilled(_weight!);
              },
              selectTextStyle: const TextStyle(
                  color: Constants.fontColor1,
                  fontSize: 14,
                  fontFamily: Constants.fontSemiBold
              ),
              unSelectTextStyle: const TextStyle(
                  color: Color.fromRGBO(204, 204, 204, 1),
                  fontSize: 15,
                  fontFamily: Constants.fontRegular
              ),
            )
          ),

          const SizedBox(
            width: 10,
          ),

          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'gm',
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
