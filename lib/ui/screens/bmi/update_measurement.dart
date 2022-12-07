import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/bloc/profile_bloc/profile_bloc.dart';
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
  late double? _relaxedInch,_relaxedCm,_extendedInch,_extendedCm;
  late Map<String,dynamic> _details;
  late ProfileBloc _profileBloc;
  late String title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _details = {};
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    title = '';

    if(widget.isExtendedAvailable){
      _buttonText = 'Next';
      title = '${widget.title} Relaxed';
    }
    else{
      _buttonText = 'Update';
      title = '${widget.title} Relaxed';
    }

    if(widget.relaxedReading != null && widget.relaxedReading! > 0 ){
      _relaxedCm = widget.relaxedReading;
      _relaxedInch = _relaxedCm! / 2.54;
    }
    else{
      _relaxedCm = 0;
      _relaxedInch = 0;
    }
    _details[widget.slug] = _relaxedCm;

    if(widget.isExtendedAvailable){
      if(widget.extendedReading != null && widget.extendedReading! > 0 ){
        _extendedCm = widget.extendedReading;
        _extendedInch = _extendedCm! / 2.54;
      }
      else{
        _extendedCm = 0;
        _extendedInch = 0;
      }
      _details[widget.slug2!] = _extendedCm;
    }
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
          appBarTitle: 'Update $title',
          onBackPressed: (){
            Navigator.pop(context, true);
          }
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
    if(widget.isExtendedAvailable){
      return (_buttonText == 'Next') ?
      MeasureView(
          measurementInch: _relaxedInch,
          measurementCM: _relaxedCm,
          title: title,
          onFilled: (v1,v2){
            _relaxedCm = v1;
            _relaxedInch = v2;
            _details[widget.slug] = _relaxedCm;
          }
      ) : (_buttonText == 'Update') ?
      MeasureView(
          measurementInch: _extendedCm,
          measurementCM: _extendedInch,
          title: title,
          onFilled: (v1,v2){
            _extendedCm = v1;
            _extendedInch = v2;
            _details[widget.slug2!] = _extendedCm;
          }
      ) : Container();
    }
    else{
     return MeasureView(
          measurementInch: _relaxedInch,
          measurementCM: _relaxedCm,
          title: title,
          onFilled: (v1,v2){
            _relaxedCm = v1;
            _relaxedInch = v2;
            _details[widget.slug] = _relaxedCm;
          }
      );
    }
  }

  Widget updateButton() {
    return AuthButton(
      title: _buttonText,
      color: Constants.primaryColor,
      fontFamily: Constants.fontMedium,
      onPressed: () {
        if(!isLoading){
          // case : for both relaxed and extended readings
          if(widget.isExtendedAvailable){
            if(_buttonText == 'Update'){
              if(_extendedCm! > 0){
                //update values
                _details[widget.slug2!] = _extendedCm;
                updateMeasurement();
              }
              else{
                Fluttertoast.showToast(msg: 'Please pick a valid value for measurement');
              }
            }
            else{
              //check if valid value is picked
              if(_relaxedCm! > 0){
                _details[widget.slug] = _relaxedCm;
                _buttonText = 'Update';
                title = '${widget.title} Extended';
                setState(() {});
              }
              else{
                Fluttertoast.showToast(msg: 'Please pick a valid value for measurement');
              }
            }
          }
          // case : for only relaxed readings
          else{
            if(_relaxedCm! > 0){
              _details[widget.slug] = _relaxedCm;
              updateMeasurement();
            }
            else{
              Fluttertoast.showToast(msg: 'Please pick a valid value for measurement');
            }
          }
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
      setState(() {
        isLoading = true;
      });
      //_profileBloc.add(UpdateProfile(details: _details));
      //Navigator.pop(context);
      Response? response = await userRepository.updateUserDetails(_details);
      print('updateMeasurement 1234');
      print(_details);
      print(response!.statusCode);
      print(response.statusMessage);
      print(response.data);

      if(response != null){
        if(response.statusCode == 200){
          // next page
          Fluttertoast.showToast(msg: '${widget.title} updated');
          _profileBloc.add(LoadProfile());
          Navigator.pop(context);
          /*Future.delayed(const Duration(seconds: 2), (){
          });*/
        }
        else{
          Fluttertoast.showToast(msg: 'Error  updating details');
        }
      }
      else{
        Fluttertoast.showToast(msg: 'Error updating details');
      }
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
