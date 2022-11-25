import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/select_result.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/color_loader.dart';
import 'package:intl/intl.dart';

import '../../../models/fitness_response.dart';
import '../../../repositories/user_repo.dart';
import '../../../utils/constants.dart';
import '../../../utils/scroll_setting.dart';
import '../../../utils/size_config.dart';
import '../../widgets/buttons/auth_button.dart';
import '../../widgets/buttons/custom_button.dart';
import 'components/fill_dob.dart';
import 'components/fill_height.dart';
import 'components/fill_name.dart';
import 'components/fill_wieght.dart';
import 'components/select_gender.dart';

class CalculateView extends StatefulWidget {
  final UserProfile? profile;

  const CalculateView({Key? key,required this.profile}) : super(key: key);

  @override
  _CalculateViewState createState() => _CalculateViewState();
}

class _CalculateViewState extends State<CalculateView> {
  late bool isLoading;
  String? _name,_gender;
  DateTime? _dob;
  double? _weight;
  int? _height;
  late int _currentTab;
  final UserRepository userRepository = UserRepository();

  late Map<String,dynamic> _profileDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _currentTab = 0;
    _gender = "M";
    _height = 160;
    _weight = 60.0;
    _profileDetails = {};
    _profileDetails['gender'] = _gender;
    checkProfile();
  }

  checkProfile(){
    if(widget.profile != null){
      if(widget.profile!.user!.firstName != null && widget.profile!.user!.firstName != ""){
        _currentTab = 1;
        _name = widget.profile!.user!.firstName;
        _profileDetails['name'] = widget.profile!.user!.firstName;
      }
      if(widget.profile!.dob != null && widget.profile!.dob != ""){
        _currentTab = 2;
        var s  = widget.profile!.dob!.split('-');
        //DateTime t = DateTime(int.parse(s[0]),[]);
        DateTime? t = DateTime.tryParse(widget.profile!.dob!);
        if(t != null){
          _dob = t;
        }
        _profileDetails['date'] = widget.profile!.dob;
      }
      if(widget.profile!.gender != null && widget.profile!.gender != ""){
        _currentTab = 3;
        _gender = widget.profile!.gender;
        _profileDetails['gender'] = widget.profile!.gender;
      }
      if(widget.profile!.weight != null && widget.profile!.weight! > 0){
        _weight = widget.profile!.weight!;
        _profileDetails['weight'] = widget.profile!.weight;
      }
      if(widget.profile!.heightCm != null && widget.profile!.heightCm! > 0){
        _height = widget.profile!.heightCm!.toInt();
        _profileDetails['height_cm'] = widget.profile!.heightCm;
      }
      if(widget.profile!.heightFt != null && widget.profile!.heightFt != ""){
        _profileDetails['height_ft'] = widget.profile!.heightFt;
      }
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
              (_currentTab > 2) ? Positioned(
                  bottom: SizeConfig.blockSizeHorizontal * 7,
                  left: SizeConfig.blockSizeHorizontal * 7,
                  child: skipButton()) : Container(),

              (isLoading) ?
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.2),
                child: ColorLoader5(),
              ) : Container()

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
            buildCurrentTab(),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
            (_currentTab == 0) ? titleLine1() : Container(),
            (_currentTab == 0) ? SizedBox(height: SizeConfig.blockSizeHorizontal * 5) : Container(),
            titleLine2(),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
            selectTab(),
          ],
        ),
      ),
    );
  }

  Widget buildCurrentTab(){
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockSizeHorizontal*1,
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*2),
              child: Container(
                width: SizeConfig.blockSizeHorizontal*15,
                height: 1,
                color: (_currentTab == index) ? Colors.red : const Color.fromRGBO(243, 243, 243, 1),
              ),
            );
          }),
    );
  }

  Widget selectTab(){
    switch(_currentTab){
      case 0:
        return FillName(
            name: _name,
            onFilled: (v){
              _name = v;
              _profileDetails['name'] = v;
            }
        );
      case 1:
        return FillDob(
            dob: _dob,
            onFilled: (v){
              _dob = v;
              _profileDetails['date'] = DateFormat('yyyy-MM-dd').format(v).toString();
            }
        );
      case 2:
        return FillGender(
            gender: _gender,
            onFilled: (v){
              _gender = v;
              _profileDetails['gender'] = v;
            }
        );
      case 3:
        return FillWeight(
            weight: _weight,
            onFilled: (v){
              _weight = v;
              _profileDetails['weight'] = v;
            }
        );
      case 4:
        return FillHeight(
            heightCM: _height,
            onFilled: (v){
              _height = v;
              if(_height != null){
                _profileDetails['height_cm'] = v;
                _profileDetails['height_ft'] = (v*0.0328084).toStringAsFixed(2);
              }
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

  Widget nextButton() {
    return AuthButton(
      title: 'Next',
      color: Constants.primaryColor,
      onPressed: () {
        if(_currentTab == 0){
          if(_name == null || _name == ""){
            Fluttertoast.showToast(msg: 'Please fill your name');
          }
          else{
            _currentTab++;
            setState(() {});
          }
        }
        else if(_currentTab == 1){
          if(_dob == null){
            Fluttertoast.showToast(msg: 'Please fill your date of birth');
          }
          else{
            _currentTab++;
            setState(() {});
          }
        }
        else if(_currentTab == 2){
          if(_gender == null || _gender == ""){
            Fluttertoast.showToast(msg: 'Please select your gender');
          }
          else{
            _currentTab++;
            setState(() {});
          }
        }
        else if(_currentTab == 3){
          if(_weight == null || _weight! < 10){
            Fluttertoast.showToast(msg: 'Please select a valid weight');
          }
          else{
            _currentTab++;
            setState(() {});
          }
        }
        else if(_currentTab == 4){
          if(_height == null || _height! < 10){
            Fluttertoast.showToast(msg: 'Please select a valid height');
          }
          else{
            _submit();
          }
        }
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal* 40,
      textSize: 15,
      isLoading: isLoading,
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

  _submit() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await userRepository.fitnessCalculate(_profileDetails);
      if(response != null){
        print(response.statusCode);
        print(response.statusMessage);
        print(response.data);

        if(response.statusCode == 200){
          //store profile details
          try{
            Response? response2 = await userRepository.getUserProfile(true);
            if(response2 != null && response2.statusCode == 200){
              UserProfile userProfile = UserProfile.fromJson(response2.data);
              await userRepository.storeProfileDetails(userProfile);
            }
          }
          catch(e){
            setState(() {
              isLoading = false;
            });
            print(e.toString());
          }
          FitnessResponse result = FitnessResponse.fromJson(response.data);
          routeToResultPage(result);
        }
        else{
          Fluttertoast.showToast(msg: 'Error : Unable to calculate fitness details');
        }
      }
      else{
        print('Unable to calculate fitness details 2');
        Fluttertoast.showToast(msg: 'Error : Unable to calculate fitness details');
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'Error ${e.toString()}');
    }
  }

  routeToResultPage(FitnessResponse response){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return SelectResult(fitnessResponse: response, data: _profileDetails);
    }));
  }
}
