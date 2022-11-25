import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/fitness_response.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/result_display.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../utils/constants.dart';
import 'components/result_tile_1.dart';

class SelectResult extends StatefulWidget {
  final FitnessResponse fitnessResponse;
  final Map<String,dynamic> data;
  const SelectResult({Key? key,required this.fitnessResponse,required this.data}) : super(key: key);

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
                    return ResultView(
                        resultType: 'BMI',
                        fitnessResponse: widget.fitnessResponse,
                        data: widget.data,isFromProfile: true);
                  }));
                },
                result: '${widget.fitnessResponse.bmi!.toStringAsFixed(2)} Kg/m2'
            ),

            ResultTile(
                title: 'BMR',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultView(
                        resultType: 'BMR',
                        fitnessResponse: widget.fitnessResponse,
                        data: widget.data,
                        isFromProfile: true);
                  }));
                },
                result: '${widget.fitnessResponse.bmr!.toStringAsFixed(2)} Calories/day'
            ),

            ResultTile(
                title: 'Body Fat',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ResultView(
                        resultType: 'Body Fat',
                        fitnessResponse: widget.fitnessResponse,
                        data: widget.data,
                        isFromProfile: true
                    );
                  }));
                },
                result: '${widget.fitnessResponse.bfp!.toString()} %'
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


