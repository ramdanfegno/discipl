import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../../utils/constants.dart';

class FillDob extends StatefulWidget {

  final DateTime? dob;
  final Function(DateTime) onFilled;

  const FillDob({Key? key,required this.dob,required this.onFilled}) : super(key: key);

  @override
  State<FillDob> createState() => _FillDobState();
}

class _FillDobState extends State<FillDob> {

  late DateTime _dob;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.dob != null){
      _dob = widget.dob!;
    }
    else{
      _dob = DateTime(DateTime.now().year - 10, 12,31);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        title(),
        SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
        chooseDate(),
      ],
    );
  }

  Widget title() {
    return const Center(
      child: Text(
        'Born on',
        style: TextStyle(
            color: Color.fromRGBO(68, 68, 68, 1),
            fontSize: 18,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget chooseDate(){
    return SizedBox(
      height: SizeConfig.blockSizeHorizontal*90,
      child: ScrollDatePicker(
        selectedDate: _dob,
        locale: const Locale('en'),
        onDateTimeChanged: (DateTime value) {
          setState(() {
            _dob = value;
          });
          widget.onFilled(_dob);
        },
        maximumDate: DateTime(DateTime.now().year - 10, 12,31),
        scrollViewOptions: const DatePickerScrollViewOptions(
            year: ScrollViewDetailOptions(
              selectedTextStyle: TextStyle(
                  color: Constants.fontColor1,
                  fontSize: 25,
                  fontFamily: Constants.fontSemiBold
              ),
              textStyle: TextStyle(
                  fontSize: 15,
                  fontFamily: Constants.fontRegular
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            ),
            month: ScrollViewDetailOptions(
              selectedTextStyle: TextStyle(
                  color: Constants.fontColor1,
                  fontSize: 25,
                  fontFamily: Constants.fontSemiBold
              ),
              textStyle: TextStyle(
                  fontSize: 15,
                  fontFamily: Constants.fontRegular
              ),
              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 0),
              alignment: Alignment.centerLeft,
            ),
            day: ScrollViewDetailOptions(
              selectedTextStyle: TextStyle(
                  color: Constants.fontColor1,
                  fontSize: 25,
                  fontFamily: Constants.fontSemiBold
              ),
              textStyle: TextStyle(
                  fontSize: 15,
                  fontFamily: Constants.fontRegular
              ),
              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
              alignment: Alignment.centerLeft,
            )
        ),
        options: DatePickerOptions(
          itemExtent: 50,
          diameterRatio: 50
        ),
      ),
    );
  }
}
