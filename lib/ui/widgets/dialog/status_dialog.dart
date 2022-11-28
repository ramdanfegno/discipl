import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import '../buttons/custom_button.dart';

class StatusDialog extends StatelessWidget {
  final String message;

  // ignore: use_key_in_widget_constructors
  const StatusDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                Padding(
                  padding:
                  EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 10),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 35,
                  )
                ),

                Padding(
                  padding:
                  EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 5,
                  bottom: SizeConfig.blockSizeHorizontal*15),
                  child: Text(
                    message,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: Constants.fontRegular),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
