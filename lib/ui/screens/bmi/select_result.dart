import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/result_display.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../utils/constants.dart';
import 'components/result_tile_1.dart';

class SelectResult extends StatefulWidget {
  const SelectResult({Key? key}) : super(key: key);

  @override
  _SelectResultState createState() => _SelectResultState();
}

class _SelectResultState extends State<SelectResult> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40,),
              child:  Text(
                'Your Results!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: Constants.fontMedium),
              ),
            ),

            ResultTile(
                title: 'BMI',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ResultView(resultType: 'BMI',fitnessResponse: null,);
                  }));
                },
                result: '23.6 Kg/m2'
            ),

            ResultTile(
                title: 'BMR',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ResultView(resultType: 'BMR',fitnessResponse: null,);
                  }));
                },
                result: '1717 Calories/day'
            ),

            ResultTile(
                title: 'Body Fat',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ResultView(resultType: 'Body Fat',fitnessResponse: null,);
                  }));
                },
                result: '18.1%'
            ),
          ],
        )
      ),
    );
  }

  Widget backButton(){
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle
        ),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: const Padding(
          padding:  EdgeInsets.only(right: 2.0),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 14,
          ),
        ),
      ),
    );
  }
}


