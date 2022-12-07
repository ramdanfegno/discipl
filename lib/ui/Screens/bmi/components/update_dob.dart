import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/scroll_setting.dart';
import '../../../../utils/size_config.dart';
import '../../../widgets/buttons/auth_button.dart';
import '../../../widgets/buttons/custom_button.dart';
import 'fill_dob.dart';

class UpdateDob extends StatefulWidget {

  final DateTime? currentDob;
  final Function(DateTime) onUpdated;

  const UpdateDob({Key? key,required this.onUpdated,required this.currentDob}) : super(key: key);

  @override
  _UpdateDobState createState() => _UpdateDobState();
}

class _UpdateDobState extends State<UpdateDob> {

  DateTime? _currentDob;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.currentDob != null){
      _currentDob = widget.currentDob;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              //verification form
              Positioned(
                  top: SizeConfig.blockSizeVertical * 3,
                  left: SizeConfig.blockSizeHorizontal * 0,
                  right: SizeConfig.blockSizeHorizontal * 0,
                  child: fillForm()),

              //verify button
              Positioned(
                  bottom: SizeConfig.blockSizeHorizontal * 7,
                  right: SizeConfig.blockSizeHorizontal * 7,
                  child: nextButton()),

              //skip button
             Positioned(
                  bottom: SizeConfig.blockSizeHorizontal * 7,
                  left: SizeConfig.blockSizeHorizontal * 7,
                  child: skipButton())

            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget fillForm() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ScrollConfiguration(
        behavior: ScrollDefaultBehaviour(),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          children: [
            SizedBox(height: SizeConfig.blockSizeHorizontal * 20),
            FillDob(
                dob: _currentDob,
                onFilled: (v){
                  _currentDob = v;
                  setState(() {});
                }
            )
          ],
        ),
      ),
    );
  }

  Widget titleLine1() {
    return const Center(
      child: Text(
        'Born on',
        style: TextStyle(
            color: Color.fromRGBO(40, 40, 40, 1),
            fontSize: 22,
            fontFamily: Constants.fontRegular),
      ),
    );
  }


  Widget nextButton() {
    return AuthButton(
      title: 'Update',
      color: Constants.primaryColor,
      fontFamily: Constants.fontMedium,
      onPressed: () {
        if(_currentDob != null){
          widget.onUpdated(_currentDob!);
          Navigator.pop(context);
        }
        else{
          Fluttertoast.showToast(msg: 'Please pick a date');
        }
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal* 40,
      textSize: 15,
      isLoading: false,
    );
  }

  Widget skipButton() {
    return CustomButton(
      title: 'Cancel',
      backgroundColor: Colors.transparent,
      borderColor: Colors.transparent,
      titleColor: const Color.fromRGBO(153, 153, 153, 1),
      onPressed: () {
        Navigator.pop(context);
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal* 40,
    );
  }
}
