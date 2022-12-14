import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitoz_fitness_app/models/fitness_response.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/bmi_view.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/bmr_view.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/body_fat_view.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../../utils/routes.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/dialog/custom_dialog.dart';
import 'calculate_view.dart';

class ResultView extends StatefulWidget {
  final String? resultType;
  final bool isFromProfile;
  final Map<String, dynamic> data;
  final FitnessResponse? fitnessResponse;
  final UserProfile? userProfile;

  const ResultView(
      {Key? key,
      this.resultType,
      this.userProfile,
      this.fitnessResponse,
      required this.isFromProfile,
      required this.data})
      : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  late AuthenticationBloc _authBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                //verification form
                selectScreen(),

                //verify button
                Positioned(
                    bottom: SizeConfig.blockSizeHorizontal * 7,
                    right: SizeConfig.blockSizeHorizontal * 7,
                    child: homeButton()),
              ],
            ),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }

  Widget selectScreen() {
    if (widget.resultType != null) {
      switch (widget.resultType) {
        case 'BMI':
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BMIView(
              isFromHome: false,
              data: widget.data,
              result: (widget.userProfile != null &&
                      widget.userProfile!.bodyMassIndex != null)
                  ? widget.userProfile!.bodyMassIndex!.toStringAsFixed(2)
                  : (widget.fitnessResponse != null &&
                          widget.fitnessResponse!.bmi != null)
                      ? widget.fitnessResponse!.bmi!.toStringAsFixed(2)
                      : '0',
            ),
          );
        case 'BMR':
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BMRView(
              data: widget.data,
              result: (widget.userProfile != null &&
                      widget.userProfile!.basalMetabolismRate != null)
                  ? widget.userProfile!.basalMetabolismRate!.toStringAsFixed(2)
                  : (widget.fitnessResponse != null &&
                          widget.fitnessResponse!.bmr != null)
                      ? widget.fitnessResponse!.bmr!.toStringAsFixed(2)
                      : '0',
            ),
          );
        case 'Body Fat':
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BodyFatView(
              gender: (widget.userProfile != null &&
                      widget.userProfile!.gender != null)
                  ? widget.userProfile!.gender!
                  : (widget.fitnessResponse != null &&
                          widget.fitnessResponse!.gender != null
                      ? widget.fitnessResponse!.gender!
                      : ''),
              data: widget.data,
              result: (widget.userProfile != null &&
                      widget.userProfile!.bodyFatPercentage != null)
                  ? widget.userProfile!.bodyFatPercentage!.toStringAsFixed(2)
                  : (widget.fitnessResponse != null &&
                          widget.fitnessResponse!.bfp != null)
                      ? widget.fitnessResponse!.bfp!.toStringAsFixed(2)
                      : '0',
            ),
          );
      }
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: BMIView(
        isFromHome: true,
        data: widget.data,
        result: (widget.userProfile != null &&
                widget.userProfile!.bodyMassIndex != null)
            ? widget.userProfile!.bodyMassIndex!.toStringAsFixed(2)
            : (widget.fitnessResponse != null &&
                    widget.fitnessResponse!.bmi != null)
                ? widget.fitnessResponse!.bmi!.toStringAsFixed(2)
                : '0',
      ),
    );
  }

  Widget homeButton() {
    return CustomButton(
      title: (widget.isFromProfile) ? 'Update' : 'Go to Home',
      backgroundColor: Constants.primaryColor,
      borderColor: Constants.primaryColor,
      titleColor: Colors.white,
      onPressed: () {
        if (!widget.isFromProfile) {
          _authBloc.add(AuthenticationMoveToHomeScreen());
          Navigator.pushNamedAndRemoveUntil(
              context, HabitozRoutes.app, (route) => false);
        } else {
          //route to calculate bmi
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CalculateView(
              profile: widget.userProfile,
              isFromProfile: false,
            );
          }));
        }
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal * 40,
    );
  }

  Future<bool> _onBackPressed() async {
    if (widget.isFromProfile) {
      return true;
    } else {
      return showDialog(
          context: context,
          //barrierDismissible: false,
          builder: (_) {
            return CustomDialog(
              title: 'Exit App',
              subtitle: 'Do you want to exit app ? ',
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
}

class WeightIndicator extends StatelessWidget {
  final Color color;
  final String title;

  const WeightIndicator({Key? key, required this.color, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: Constants.fontRegular),
        ),
      ],
    );
  }
}
