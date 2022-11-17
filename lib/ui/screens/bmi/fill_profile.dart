import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_dob.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_height.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_name.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_wieght.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/select_gender.dart';
import 'package:habitoz_fitness_app/ui/widgets/buttons/custom_button.dart';

import '../../../utils/constants.dart';
import '../../../utils/scroll_setting.dart';
import '../../../utils/size_config.dart';
import '../../widgets/buttons/auth_button.dart';

class FillProfileDetails extends StatefulWidget {
  const FillProfileDetails({Key? key}) : super(key: key);

  @override
  _FillProfileDetailsState createState() => _FillProfileDetailsState();
}

class _FillProfileDetailsState extends State<FillProfileDetails> {

  late bool isLoading;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name,_gender;
  DateTime? _dob;
  double? _weight;
  int? _height;
  late int _currentTab;
  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _currentTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
                left: SizeConfig.blockSizeHorizontal * 6,
                right: SizeConfig.blockSizeHorizontal * 6,
                child: fillForm()),

            //verify button
            Positioned(
                bottom: SizeConfig.blockSizeHorizontal * 7,
                right: SizeConfig.blockSizeHorizontal * 7,
                child: verifyButton()),

            //skip button
            Positioned(
                bottom: SizeConfig.blockSizeHorizontal * 7,
                left: SizeConfig.blockSizeHorizontal * 7,
                child: skipButton()),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
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
              buildCurrentTab(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
              (_currentTab == 0) ? titleLine1() : Container(),
              (_currentTab == 0) ? SizedBox(height: SizeConfig.blockSizeHorizontal * 5) : Container(),
              titleLine2(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
              selectTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCurrentTab(){
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockSizeHorizontal*10,
      child: Center(
        child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*1.5),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal*15,
                  height: 5,
                  color: (_currentTab == index) ? Colors.red : const Color.fromRGBO(243, 243, 243, 1),
                ),
              );
            }),
      ),
    );
  }

  Widget selectTab(){
    switch(_currentTab){
      case 0:
        return FillName(
            name: _name,
            onFilled: (v){
              _name = v;
            }
        );
      case 1:
        return FillDob(
            dob: _dob,
            onFilled: (v){
              _dob = v;
            }
        );
      case 2:
        return FillGender(
            gender: _gender,
            onFilled: (v){
              _gender = v;
            }
        );
      case 3:
        return FillHeight(
            height: _height,
            onFilled: (v){
              _height = v;
            }
        );
      case 4:
        return FillWeight(
            weight: _weight,
            onFilled: (v){
              _weight = v;
            }
        );
    }
    return Container();
  }

  Widget titleLine1() {
    return const Center(
      child: Text(
        'Hey there!',
        style: TextStyle(
            color: Color.fromRGBO(40, 40, 40, 1),
            fontSize: 22,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget titleLine2() {
    return const Center(
      child: Text(
        'Know your health quotient',
        style: TextStyle(
            color: Color.fromRGBO(40, 40, 40, 1),
            fontSize: 21,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget verifyButton() {
    return AuthButton(
      title: 'Next',
      color: Constants.primaryColor,
      onPressed: () {

        if(_currentTab <4){
          _currentTab++;
        }
        setState(() {});
       /* if (!(isLoading)) {
          _onFormSubmitted();
        }*/
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal* 40,
      textSize: 15,
      isLoading: isLoading,
    );
  }

  Widget skipButton() {
    return CustomButton(
      title: 'Skip',
      backgroundColor: Colors.transparent,
      borderColor: Colors.transparent,
      titleColor: const Color.fromRGBO(153, 153, 153, 1),
      onPressed: () {

      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal* 40,
    );
  }

  void _onFormSubmitted() {
    try{
      if ( _formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        submitNameApi();
      }
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  submitNameApi() async{
    try{
      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());

      Response? response = await userRepository.updateName(_name!);

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

}
