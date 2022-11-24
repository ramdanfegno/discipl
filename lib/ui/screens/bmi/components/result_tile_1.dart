import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';


class ResultTile extends StatelessWidget {
  final Function() onPressed;
  final String title,result;

  const ResultTile({Key? key,required this.title,required this.onPressed,required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
      child: InkWell(
        onTap: (){
          onPressed();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(2,5)
                )
              ]
          ),
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: Constants.fontMedium),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    result,
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontFamily: Constants.fontMedium),
                  ),

                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child:  Text(
                  'View More >',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: Constants.fontRegular),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
