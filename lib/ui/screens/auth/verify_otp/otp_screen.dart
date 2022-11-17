import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitoz_fitness_app/models/login_response.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/fill_profile.dart';
import 'package:habitoz_fitness_app/utils/routes.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:pinput/pinput.dart';
import '../../../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../../../models/otp_response_model.dart';
import '../../../../repositories/user_repo.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/scroll_setting.dart';
import '../../../../utils/size_config.dart';
import '../../../widgets/buttons/auth_button.dart';

class VerifyOtpPage extends StatefulWidget {
  final UserRepository userRepository;
  final OtpResponse? otpResponseModel;
  final String? message;

  const VerifyOtpPage(
      {required this.userRepository,
      required this.otpResponseModel,
      required this.message})
      : super();

  @override
  State<StatefulWidget> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> with CodeAutoFill {
  late Timer _timer;
  late Stream<String> code1;
  var errorController;
  TextEditingController textEditingController = TextEditingController();

  late String currentText;
  bool isOtpTimedOut = false;
  int _start = 2 * 60;
  late bool isLoading;
  late AuthenticationBloc _authBloc;

  final defaultPinTheme = PinTheme(
    width: SizeConfig.blockSizeHorizontal * 10,
    height: SizeConfig.blockSizeHorizontal * 10,
    textStyle: const TextStyle(
      fontSize: 16,
      fontFamily: Constants.fontSemiBold,
      color: Colors.black,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      border: Border.all(color: Constants.fontColor1,),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  late PinTheme focusedPinTheme,submittedPinTheme,errorTheme;

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
    cancel();
  }

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    currentText = '';
    _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    focusedPinTheme = defaultPinTheme.copyDecorationWith(
        border: Border.all(color: const Color.fromRGBO(117, 117, 117, 1)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white
    );
    submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
          border: Border.all(color: Constants.primaryColor),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
      ),
    );
    errorTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
          border: Border.all(color: Constants.errorColor),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
      ),
    );
    listenForCode();
    code1 = SmsAutoFill().code;
    code1.listen((event) {
      updatePin(event);
    });
    startTimer();
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
                top: SizeConfig.blockSizeVertical * 10,
                left: SizeConfig.blockSizeHorizontal * 6,
                right: SizeConfig.blockSizeHorizontal * 6,
                child: verifyForm()),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget verifyForm() {
    return Form(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ScrollConfiguration(
          behavior: ScrollDefaultBehaviour(),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            children: [
              logo(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
              title(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
              otpMsg(),
              displayMobile(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
              Center(child: buildPin()),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
              timerDisplay(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 20),
              Center(child: verifyButton()),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
              resendOtpUI(),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return const Center(
      child: Text(
        'Verify your number',
        style: TextStyle(
            color: Color.fromRGBO(40, 40, 40, 1),
            fontSize: 22,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget logo() {
    return Image.asset(
      "assets/images/jpg/logo.jpg",
      width: SizeConfig.screenWidth * 0.2,
      height: SizeConfig.screenWidth * 0.4,
    );
  }

  Widget otpMsg() {
    return const Center(
      child: Text(
        'Please enter the 4 digit OTP sent to',
        style: TextStyle(
            color: Color.fromRGBO(136, 136, 136, 1),
            fontSize: 13,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget timerDisplay() {
    int s1 = (_start / 60).floor();
    int s2 = (_start % 60).round();

    String min = s1.toString().padLeft(2, '0');
    String sec = s2.toString().padLeft(2, '0');
    return Center(
      child: Text(
        "$min:$sec",
        style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 14,
            fontFamily: (isOtpTimedOut)
                ? Constants.fontSemiBold
                : Constants.fontRegular),
      ),
    );
  }

  Widget displayMobile() {
    return SizedBox(
      //width: SizeConfig.blockSizeHorizontal * 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 5,
            height: SizeConfig.blockSizeHorizontal * 10,
          ),

          Text(
            (widget.otpResponseModel!.mobile != null ) ? '+91  ${widget.otpResponseModel!.mobile!}' : '',
            style: const TextStyle(
                color: Color.fromRGBO(136, 136, 136, 1),
                fontSize: 14,
                fontFamily: Constants.fontRegular
            ),
          ),

          GestureDetector(
            onTap: () {
              //edit phone number
              //go back to previous page
              Navigator.pop(context, true);
            },
            child: SizedBox(
              width: SizeConfig.blockSizeHorizontal * 10,
              height: SizeConfig.blockSizeHorizontal * 10,
              child: const Icon(
                Icons.edit,
                size: 13,
                color: Color.fromRGBO(136, 136, 136, 1),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPin() {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 52,
      //color: Colors.grey,
      child: Pinput(
        animationDuration: const Duration(milliseconds: 300),
        length: 4,
        enabled: (isLoading) ? false : true,
        controller: textEditingController,
        onSubmitted: (String pin) {
          if (!isOtpTimedOut) {
            verifyOtp(pin, widget.otpResponseModel);
          }
        },
        defaultPinTheme: defaultPinTheme,
        submittedPinTheme: submittedPinTheme,
        focusedPinTheme: focusedPinTheme,
        textInputAction: TextInputAction.go,
        onChanged: (value) {
          currentText = value;
        },
      ),
    );
  }

  Widget resendOtpUI(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            ' Didn\'t receive code?',
            style: TextStyle(
                color: Color.fromRGBO(179, 179, 179, 1),
                fontSize: 12,
                fontFamily: Constants.fontRegular),
          ),

          const SizedBox(width: 5,),

          InkWell(
            onTap: () {
              if (isOtpTimedOut) {
                //resend otp
                resendOtp();
              }
            },
            child: Text(
              'Resend',
              style: TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 14,
                  fontFamily: (isOtpTimedOut)
                      ? Constants.fontSemiBold
                      : Constants.fontRegular),
            ),
          )
        ]);
  }

  Widget verifyButton() {
    return AuthButton(
        title: 'Verify',
        height: SizeConfig.blockSizeHorizontal * 13,
        width: SizeConfig.screenWidth,
        textSize: 15,
        color: isOtpTimedOut
            ? const Color.fromRGBO(155, 155, 155, 1)
            : Constants.primaryColor,
        isLoading: isLoading,
        onPressed: () {
          if (!isLoading) {
            if (!isOtpTimedOut) {
              verifyOtp(currentText, widget.otpResponseModel);
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Timed out',
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(Icons.error)
                    ],
                  ),
                  backgroundColor: const Color.fromRGBO(244, 145, 42, 1),
                ));
            }
          }
        });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            isOtpTimedOut = true;
            isLoading = false;
            //_callResendOtp();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void codeUpdated() {
    setState(() {
      currentText = code!;
    });
  }

  updatePin(String otpCode) {
    currentText = otpCode;
    textEditingController.text = otpCode;
  }

  void verifyOtp(String pin, OtpResponse? otpResponseModel) async {
    try {
      setState(() {
        isLoading = true;
      });
      Response? response = await widget.userRepository.loginWithOtp(
          otpResponseModel!.mobile!, pin);
      print(response!.data);
      print(response.statusCode);

      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      //store login response

      if (response.statusCode == 202) {
        // getCartFromApi(cart);
        _timer.cancel();
        currentText = '';
        textEditingController.text = '';
        await widget.userRepository.setLoginResponse(loginResponse);
        //_authBloc.add(AuthenticationLoggedIn());

        /*Future.delayed(const Duration(milliseconds: 400),(){
          Navigator.pushNamedAndRemoveUntil(
              context, HabitozRoutes.app, (route) => false);
        });*/

       moveToNextPage();

        setState(() {
          isLoading = false;
        });
      }
      else {
        String errorMsg = '';

        setState(() {
          isLoading = false;
        });
        if (response.data['error'] != null) {
          if (response.data['error']['non_field_errors'] != null) {
            errorMsg = response.data['error']['non_field_errors'][0];
          }
        } else {
          errorMsg = 'Wrong OTP';
        }
        showSnackBar(errorMsg);
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void resendOtp() async {
    setState(() {
      isOtpTimedOut = false;
      _start = 2 * 60;
    });
    startTimer();
    Response? response = await widget.userRepository.reSendOtp(
        widget.otpResponseModel!.mobile!,
        "${widget.otpResponseModel!.id}");
    textEditingController.text = currentText;
    if (response!.statusCode == 200) {}
  }

  moveToNextPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const FillProfileDetails();
    }));
  }

  showSnackBar(String msg){
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              msg,
              style: const TextStyle(color: Colors.black),
            ),
            const Icon(Icons.error)
          ],
        ),
        backgroundColor: Colors.red,
      ));
  }
}
