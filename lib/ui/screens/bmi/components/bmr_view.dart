import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/scroll_setting.dart';

class BMRView extends StatefulWidget {
  final String result;
  final Map<String,dynamic> data;

  const BMRView({Key? key,required this.data,required this.result}) : super(key: key);

  @override
  State<BMRView> createState() => _BMRViewState();
}

class _BMRViewState extends State<BMRView> {

  late String? _height,_weight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _height = '';
    _weight = '';
    if(widget.data.isNotEmpty){
      print(widget.data);
      if(widget.data['height_cm'] != null){
        _height = widget.data['height_cm'].toStringAsFixed(0);
      }
      if(widget.data['weight'] != null){
        _weight = widget.data['weight'].toStringAsFixed(0);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ScrollConfiguration(
        behavior: ScrollDefaultBehaviour(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: SizeConfig.blockSizeHorizontal * 15),
            titleLine1(),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
            bmrView(context),
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
      'BMR RESULT',
      style: TextStyle(
          color: Color.fromRGBO(40, 40, 40, 1),
          fontSize: 22,
          fontFamily: Constants.fontMedium),
    );
  }

  Widget bmrView(BuildContext context){
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
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          title(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          bmrReading(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 10),

          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              'Lorem ipsum: Lorem ipsum sidm lksdvksmdvkms ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: Constants.fontRegular),
            ),
          ),

          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),

          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              'Lorem ipsum: Lorem ipsum sidm lksdvksmdvkms ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: Constants.fontRegular),
            ),
          ),

          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),

          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              'Lorem ipsum: Lorem ipsum sidm lksdvksmdvkms ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: Constants.fontRegular),
            ),
          ),

          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),

        ],
      ),
    );
  }

  Widget title() {
    return const Text(
      'Your BMR',
      style: TextStyle(
          color: Color.fromRGBO(68, 68, 68, 1),
          fontSize: 18,
          fontFamily: Constants.fontRegular),
    );
  }

  Widget bmrReading() {
    return  Text(
      '${widget.result} Calories/day',
      style: const TextStyle(
          color: Colors.green,
          fontSize: 20,
          fontFamily: Constants.fontSemiBold),
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
            children:  [

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
                '$_weight Kg',
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
