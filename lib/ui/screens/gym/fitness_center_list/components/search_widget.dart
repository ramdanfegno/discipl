import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../../../utils/constants.dart';


class SearchWidget extends StatefulWidget {
  final Function(String) onChanged;
  final Function() onCleared;

  const SearchWidget({Key? key,required this.onChanged,required this.onCleared}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  late TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 4),
        child: Container(
          height: SizeConfig.blockSizeHorizontal * 13,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.black,width: 1) ,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  controller: textEditingController,
                  autofocus: false,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontFamily: Constants.fontMedium),
                  onFieldSubmitted: (val) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onChanged: (v) {
                    EasyDebounce.debounce(
                        'Search-Fitness-Debounce', const Duration(milliseconds: 500), () {
                     // widget.onChanged(v);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search here ...',
                    hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontFamily: Constants.fontMedium),
                    //suffixIcon:
                    contentPadding: EdgeInsets.only(
                        top: SizeConfig.blockSizeHorizontal * 5,
                        bottom: SizeConfig.blockSizeHorizontal * 2,
                        right: SizeConfig.blockSizeHorizontal * 2,
                        left: SizeConfig.blockSizeHorizontal * 4),
                    errorStyle: const TextStyle(color: Colors.red),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        borderSide:
                        BorderSide(color: Colors.red[400]!, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        borderSide:
                        BorderSide(color: Colors.red[400]!, width: 2)),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 1)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 1)),
                    disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 1)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2),
                child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 10,
                    height: SizeConfig.blockSizeHorizontal * 10,
                    child: (textEditingController.text != '') ?
                    IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Colors.red[500],
                        ),
                        onPressed: () {
                          textEditingController.text = '';
                          //widget.onCleared();
                        }) :
                    Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey[700],
                    )
                ),
              ),
            ],
          ),
        )
    );
  }
}
