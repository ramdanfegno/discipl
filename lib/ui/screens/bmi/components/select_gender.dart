import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../../utils/constants.dart';

class FillGender extends StatefulWidget {

  final String? gender;
  final Function(String) onFilled;

  const FillGender({Key? key,required this.gender,required this.onFilled}) : super(key: key);

  @override
  State<FillGender> createState() => _FillGenderState();
}

class _FillGenderState extends State<FillGender> {

  String? gender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.gender != null){
      gender = widget.gender;
    }
    else{
      gender = 'MALE';
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        title(),
        SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
        chooseGender(),
      ],
    );
  }

  Widget title() {
    return const Center(
      child: Text(
        'I Am',
        style: TextStyle(
            color: Color.fromRGBO(68, 68, 68, 1),
            fontSize: 18,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget chooseGender(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        GenderTile(
            isSelected: (gender == 'MALE'),
            iconData: HabitozIcons.male,
            title: 'MALE',
            onPressed: (){
              gender = 'MALE';
              setState(() {});
              widget.onFilled(gender!);
            }),

        const SizedBox(
          height: 10,
        ),

        GenderTile(
            isSelected: (gender == 'FEMALE'),
            iconData: HabitozIcons.female,
            title: 'FEMALE',
            onPressed: (){
              gender = 'FEMALE';
              setState(() {});
              widget.onFilled(gender!);
            }),

        const SizedBox(
          height: 10,
        ),

        GenderTile(
            isSelected: (gender == 'OTHERS'),
            iconData: HabitozIcons.others,
            title: 'OTHERS',
            onPressed: (){
              gender = 'OTHERS';
              setState(() {});
              widget.onFilled(gender!);
            }),
      ],
    );
  }

}


class GenderTile extends StatelessWidget {

  final IconData iconData;
  final String title;
  final bool isSelected;
  final Function() onPressed;

  const GenderTile({Key? key,required this.isSelected,required this.iconData,required this.title,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeHorizontal*25,
      width: SizeConfig.blockSizeHorizontal*25,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(243, 243, 243, 1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: (isSelected) ? Colors.red : Colors.transparent, width: 1)
      ),
    );
  }
}
