import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_dob.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_height.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_name.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/fill_wieght.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/measure_view.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/select_gender.dart';
import 'package:habitoz_fitness_app/ui/widgets/buttons/custom_button.dart';
import 'package:intl/intl.dart';

import '../../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';
import '../../../utils/scroll_setting.dart';
import '../../../utils/size_config.dart';
import '../../widgets/buttons/auth_button.dart';
import '../../widgets/dialog/custom_dialog.dart';
import 'profile_screen.dart';

class FillProfileDetails extends StatefulWidget {
  const FillProfileDetails({Key? key}) : super(key: key);

  @override
  _FillProfileDetailsState createState() => _FillProfileDetailsState();
}

class _FillProfileDetailsState extends State<FillProfileDetails> {
  late bool isLoading;
  String? _name, _gender;
  DateTime? _dob;
  double? _weight;
  int? _height;
  late int _currentTab;
  final UserRepository userRepository = UserRepository();

  late AuthenticationBloc _authBloc;
  late Map<String, dynamic> _profileDetails;

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
    _profileDetails['weight'] = _weight;
    _profileDetails['height_cm'] = _height;

    _authBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              unFocus();
            },
            child: Container(
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
                  (_currentTab > 2)
                      ? Positioned(
                          bottom: SizeConfig.blockSizeHorizontal * 7,
                          left: SizeConfig.blockSizeHorizontal * 7,
                          child: skipButton())
                      : Container(),
                ],
              ),
            ),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
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
            (_currentTab == 0)
                ? SizedBox(height: SizeConfig.blockSizeHorizontal * 5)
                : Container(),
            titleLine2(),
            SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
            selectTab(),
          ],
        ),
      ),
    );
  }

  Widget buildCurrentTab() {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockSizeHorizontal * 1,
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 2),
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 15,
                height: 1,
                color: (_currentTab == index)
                    ? Colors.red
                    : const Color.fromRGBO(243, 243, 243, 1),
              ),
            );
          }),
    );
  }

  Widget selectTab() {
    switch (_currentTab) {
      case 0:
        return FillName(
            name: _name,
            onFilled: (v) {
              _name = v;
              _profileDetails['name'] = v;
            });
      case 1:
        return FillDob(
            dob: _dob,
            onFilled: (v) {
              _dob = v;
              _profileDetails['date'] =
                  DateFormat('yyyy-MM-dd').format(v).toString();
            });
      case 2:
        return FillGender(
            gender: _gender,
            onFilled: (v) {
              _gender = v;
              _profileDetails['gender'] = v;
            });
      case 3:
        return FillWeight(
            weight: _weight,
            onFilled: (v) {
              _weight = v;
              _profileDetails['weight'] = v;
            });
      case 4:
        return FillHeight(
            heightCM: _height,
            onFilled: (v) {
              _height = v;
              if (_height != null) {
                _profileDetails['height_cm'] = v;
                _profileDetails['height_ft'] =
                    (v * 0.0328084).toStringAsFixed(2);
              }
            });
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
            fontSize: 24,
            fontFamily: Constants.fontSemiBold),
      ),
    );
  }

  Widget nextButton() {
    return AuthButton(
      title: 'Next',
      color: Constants.primaryColor,
      fontFamily: Constants.fontMedium,
      onPressed: () {
        if (_currentTab == 0) {
          if (_name == null || _name == "") {
            Fluttertoast.showToast(msg: 'Please fill your name');
          } else {
            _currentTab++;
            setState(() {});
          }
        } else if (_currentTab == 1) {
          if (_dob == null) {
            Fluttertoast.showToast(msg: 'Please fill your date of birth');
          } else {
            _currentTab++;
            setState(() {});
          }
        } else if (_currentTab == 2) {
          if (_gender == null || _gender == "") {
            Fluttertoast.showToast(msg: 'Please select your gender');
          } else {
            _currentTab++;
            setState(() {});
          }
        } else if (_currentTab == 3) {
          if (_weight == null || _weight! < 10) {
            Fluttertoast.showToast(msg: 'Please select a valid weight');
          } else {
            _currentTab++;
            setState(() {});
          }
        } else if (_currentTab == 4) {
          if (_height == null || _height! < 10) {
            Fluttertoast.showToast(msg: 'Please select a valid height');
          } else {
            _submit();
          }
        }
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal * 40,
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
        _skip();
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal * 40,
    );
  }

  void _skip() {
    try {
      //check if any details are provided
      _authBloc.add(AuthenticationSkipProfile(data: _profileDetails));
      Navigator.pushNamedAndRemoveUntil(
          context, HabitozRoutes.app, (route) => false);
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  _submit() async {
    try {
      _profileDetails['neck'] = 0;
      _authBloc.add(AuthenticationProfileFilled(data: _profileDetails));
      Navigator.pushNamedAndRemoveUntil(
          context, HabitozRoutes.app, (route) => false);
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: 'Error ${e.toString()}');
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
              _skip();
              return false;
            },
            no: () {
              Navigator.pop(context, false);
              return false;
            },
          );
        }).then((x) => x ?? false);
  }

  unFocus() {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
