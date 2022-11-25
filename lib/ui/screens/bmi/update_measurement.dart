import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_dob.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_height.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_name.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/measure_view.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/select_gender.dart';
import 'package:habitoz_fitness_app/ui/widgets/buttons/custom_button.dart';

import '../../../utils/constants.dart';
import '../../../utils/scroll_setting.dart';
import '../../../utils/size_config.dart';
import '../../widgets/buttons/auth_button.dart';
import '../../widgets/dialog/custom_dialog.dart';
import '../../widgets/others/app_bar.dart';
import 'profile_screen.dart';

class UpdateMeasurement extends StatefulWidget {
  final String title,slug;
  final String? slug2;
  final double? relaxedReading,extendedReading;
  final bool isExtendedAvailable;

  const UpdateMeasurement({Key? key,
    required this.title, this.extendedReading,required this.slug,this.slug2,
    required this.isExtendedAvailable, required this.relaxedReading
  }) : super(key: key);

  @override
  _UpdateMeasurementState createState() => _UpdateMeasurementState();
}

class _UpdateMeasurementState extends State<UpdateMeasurement> {

  late bool isLoading;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserRepository userRepository = UserRepository();
  late String _buttonText;
  late int? _inch,_cm;
  late Map<String,dynamic> _details;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _details = {};
    if(widget.isExtendedAvailable){
      _buttonText = 'Next';
    }
    else{
      _buttonText = 'Update';
    }
    _inch = 0;
    _cm = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          isHomeAppBar: false,
          appBarTitle: 'Update ${widget.title}',
        ),
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
                  child: updateButton()),

              //skip button
              Positioned(
                  bottom: SizeConfig.blockSizeHorizontal * 7,
                  left: SizeConfig.blockSizeHorizontal * 7,
                  child: cancelButton()),

            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget fillForm() {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ScrollConfiguration(
          behavior: ScrollDefaultBehaviour(),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            children: [
              SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
              selectTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectTab(){
    return MeasureView(
        measurementInch: _inch,
        measurementCM: _cm,
        title: widget.title,
        onFilled: (v1,v2){
          _cm = v1;
          _inch = v2;
        }
    );
  }

  Widget updateButton() {
    return AuthButton(
      title: _buttonText,
      color: Constants.primaryColor,
      onPressed: () {
        if(_buttonText == 'Update'){
          //update values
          updateMeasurement();
        }
        else{
          //check if valid value is picked
          _buttonText = 'Update';
          setState(() {});
        }
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal* 40,
      textSize: 15,
      isLoading: isLoading,
    );
  }

  Widget cancelButton() {
    return CustomButton(
      title: 'Cancel',
      backgroundColor: Colors.grey[200]!,
      borderColor: Colors.grey[200]!,
      titleColor: const Color.fromRGBO(153, 153, 153, 1),
      onPressed: () {
        Navigator.pop(context,true);
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal* 40,
    );
  }

  updateMeasurement() async{
    try{


     /* Response? response = await userRepository.updateName('_name');

      if(response != null){
        if(response.statusCode == 200){
          // next page

        }
        else{
          Fluttertoast.showToast(msg: 'Error submitting name');
        }
      }
      else{
        Fluttertoast.showToast(msg: 'Error submitting name');
      }*/
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: 'Error ${e.toString()}');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> _onBackPressed() async {
    return showDialog(
        context: context,
        //barrierDismissible: false,
        builder: (_) {
          return CustomDialog(
            title: 'Exit Login',
            subtitle: 'Do you want to exit login process?',
            yesTitle: 'Yes',
            noTitle: 'No',
            yes: () {
              Navigator.pop(context, true);
              return true;
            },
            no: () {
              Navigator.pop(context, false);
              return false;
            },
          );
        }).then((x) => x ?? false);
  }

}
