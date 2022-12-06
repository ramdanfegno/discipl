import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';


class MeasurementTile extends StatelessWidget {
  final Function() onPressed;
  final String? title, relaxedReading, extendedReading;
  final bool isExtendedAvailable;

  const MeasurementTile({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.relaxedReading,
    this.extendedReading,
    required this.isExtendedAvailable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      //padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: SizeConfig.blockSizeHorizontal*3),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                width: SizeConfig.blockSizeHorizontal*30,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 2),
                child: Text(
                  (title != null) ? title! : '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: Constants.fontRegular),
                ),
              ),

              Container(
                width: SizeConfig.blockSizeHorizontal*27,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 2),
                child: Text(
                  (relaxedReading != null) ? relaxedReading! : 'none',
                  style: TextStyle(
                      color: (relaxedReading != null) ? Colors.green : Colors.red,
                      fontSize: 13,
                      fontFamily: Constants.fontRegular),
                ),
              ),


              Container(
                width: SizeConfig.blockSizeHorizontal*20,
                //color: Colors.green,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 5,bottom: 5,left: 5),
                child: (isExtendedAvailable) ? Text(
                  (extendedReading != null) ? extendedReading! : 'none',
                  style: TextStyle(
                      color: (extendedReading != null) ? Colors.green : Colors.red,
                      fontSize: 13,
                      fontFamily: Constants.fontRegular),
                ) : Container(),
              ),

              InkWell(
                onTap: (){
                  onPressed();
                },
                child: Container(
                    width: SizeConfig.blockSizeHorizontal*7,
                    height: SizeConfig.blockSizeHorizontal*7,
                    //color: Colors.grey,
                    alignment: Alignment.centerRight,
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 14,
                      ),
                    )
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeHorizontal*3),
          const Divider(color: Color.fromRGBO(136, 136, 136, 1)),
        ],
      ),
    );
  }
}
