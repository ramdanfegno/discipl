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
      gender = 'M';
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
            isSelected: (gender == 'M'),
            iconData: Icons.male,
            title: 'MALE',
            onPressed: (){
              gender = 'M';
              setState(() {});
              widget.onFilled(gender!);
            }),

        const SizedBox(
          height: 15,
        ),

        GenderTile(
            isSelected: (gender == 'F'),
            iconData: Icons.female,
            title: 'FEMALE',
            onPressed: (){
              gender = 'F';
              setState(() {});
              widget.onFilled(gender!);
            }),

        const SizedBox(
          height: 15,
        ),

        GenderTile(
            isSelected: (gender == 'O'),
            iconData: Icons.transgender,
            title: 'OTHERS',
            onPressed: (){
              gender = 'O';
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
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        height: SizeConfig.blockSizeHorizontal*30,
        width: SizeConfig.blockSizeHorizontal*30,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(243, 243, 243, 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: (isSelected) ? Colors.red : Colors.transparent, width: 1)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Constants.fontColor1),
                shape: BoxShape.circle
              ),
              padding: const EdgeInsets.all(5),
              child: Icon(
                iconData,
                color: Colors.grey[600],
                size: 22,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Constants.fontColor1,
                fontSize: 14,
                fontFamily: Constants.fontRegular
              ),
            )
          ],
        ),

      ),
    );
  }
}
