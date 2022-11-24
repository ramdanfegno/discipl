import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';


class ResultTile extends StatelessWidget {
  final Function() onPressed;
  final String title,result;
  final bool isAvailable;

  const ResultTile({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.result,
    required this.isAvailable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10),
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
                      fontSize: 17,
                      fontFamily: Constants.fontMedium),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  result,
                  style: TextStyle(
                      color: (isAvailable) ? Colors.green : Colors.red,
                      fontSize: 15,
                      fontFamily: Constants.fontMedium),
                ),

              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child:  Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 16,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
