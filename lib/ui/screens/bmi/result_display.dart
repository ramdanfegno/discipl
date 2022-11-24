import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitoz_fitness_app/models/fitness_response.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/bmi_view.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/bmr_view.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/body_fat_view.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../../utils/routes.dart';
import '../../../utils/scroll_setting.dart';
import '../../widgets/buttons/custom_button.dart';

class ResultView extends StatefulWidget {
  final String? resultType;
  final FitnessResponse? fitnessResponse;
  const ResultView({Key? key,this.resultType,required this.fitnessResponse}) : super(key: key);

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
    );
  }

  Widget selectScreen(){
    if(widget.resultType != null){
      switch(widget.resultType){
        case 'BMI':
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const BMIView(isFromHome: false,),
          );
        case 'BMR':
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const BMRView(),
          );
        case 'Body Fat':
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const BodyFatView(),
          );
      }
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const BMIView(isFromHome: true,),
    );
  }

  Widget homeButton() {
    return CustomButton(
      title: 'Go to Home',
      backgroundColor: Constants.primaryColor,
      borderColor: Constants.primaryColor,
      titleColor: Colors.white,
      onPressed: () {
        _authBloc.add(AuthenticationMoveToHomeScreen());
        Future.delayed(const Duration(milliseconds: 400),(){
          Navigator.pushNamedAndRemoveUntil(
              context, HabitozRoutes.app, (route) => false);
        });
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal* 40,
    );
  }
}

class WeightIndicator extends StatelessWidget {

  final Color color;
  final String title;

  const WeightIndicator({Key? key,required this.color,required this.title}) : super(key: key);

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
        const SizedBox(width: 5,),

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

