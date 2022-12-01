import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../bloc/authentication_bloc/authentication_bloc.dart';
import '../../../../bloc/login_bloc/login_bloc.dart';
import '../../../../bloc/login_bloc/login_event.dart';
import '../../../../bloc/login_bloc/login_state.dart';
import '../../../../repositories/user_repo.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/routes.dart';
import '../../../../utils/scroll_setting.dart';
import '../../../../utils/size_config.dart';
import '../../../widgets/buttons/auth_button.dart';
import '../../../widgets/dialog/custom_dialog.dart';
import '../verify_otp/otp_screen.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;
  final String? message;

  // ignore: use_key_in_widget_constructors
  const LoginForm(
      {required UserRepository userRepository, required this.message})
      : _userRepository = userRepository,
        super();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _controller = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isPopulated => _phoneController.text.isNotEmpty;
  late LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;
  late AuthenticationBloc _authBloc;

  bool isLoginButtonEnabled(LoginState state) {
    return (state.isPhoneValid) && isPopulated && !(state.isSubmitting);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('LoginForm 2');

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _phoneController.addListener(_onPhoneChanged);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.animateTo(100,
            curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
      } else {
        _controller.animateTo(0,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300));
      }
    });
    _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    print(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: MultiBlocListener(
          listeners: [
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.isFailure) {
                  //show failed state
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(state.message!),
                          const Icon(Icons.error)
                        ],
                      ),
                      backgroundColor: Colors.red,
                    ));
                }
                if (state.isSubmitting) {
                  //show loading widget
                }
                if (state.isSuccess) {
                  // redirect to otp verification

                  print('LoginForm isSuccess 3');

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VerifyOtpPage(
                      userRepository: widget._userRepository,
                      otpResponseModel: state.otpResponseModel,
                      message: widget.message,
                    );
                  }));
                }
              },
            ),
          ],
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Stack(children: [
                // login form
                Positioned(
                    top: SizeConfig.blockSizeVertical * 15,
                    left: SizeConfig.blockSizeHorizontal * 6,
                    right: SizeConfig.blockSizeHorizontal * 6,
                    child: loginForm(state)),

                //skip button
                Positioned(
                    bottom: SizeConfig.blockSizeHorizontal * 7,
                    right: SizeConfig.blockSizeHorizontal * 7,
                    child: skipButton()),
              ]),
            );
          }),
        ),
      ),
    );
  }

  Widget loginForm(LoginState state) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ScrollConfiguration(
          behavior: ScrollDefaultBehaviour(),
          child: ListView(
            controller: _controller,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            children: [
              SizedBox(height: SizeConfig.blockSizeHorizontal * 4),
              title(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 1),
              logo(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
              loginText(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
              mobileTextField(state),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
              Center(child: loginButton(state)),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
              termsLine1(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 2),
              termsLine2(),
              SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return const Center(
      child: Text(
        'Welcome To',
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

  Widget loginText() {
    return Row(
      children: const [

        Expanded(
            child: SizedBox(
              height: 20,
              child: Center(
            child: Divider(
              color: Color.fromRGBO(40, 40, 40, 1),
              thickness: .5,
              height: 1,
            )
          ),
        )),

        Text(
          '   Log In or Sign Up   ',
          style: TextStyle(
              color: Color.fromRGBO(40, 40, 40, 1),
              fontSize: 13,
              fontFamily: Constants.fontRegular),
        ),

        Expanded(
            child: SizedBox(
              height: 20,
              child: Center(
                  child: Divider(
                    color: Color.fromRGBO(40, 40, 40, 1),
                    thickness: .5,
                    height: 1,
                  )
              ),
            )),
      ],
    );
  }

  Widget mobileTextField(LoginState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: (state.isFailure) ? Colors.red : Constants.fontColor1,
                  width: 1)),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            autofocus: true,
            focusNode: _focusNode,
            controller: _phoneController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
            ],
            enabled: (state.isSubmitting) ? false : true,
            validator: (String? v) {
              if (v!.isEmpty) {
                return 'Enter phone number';
              }
              if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(v)) {
                return 'Enter 10 digit phone number';
              }
              if(v == '0000000000' || v[0] == '0'){
                return 'Enter a valid phone number';
              }
              return null;
            },
            cursorColor: Constants.primaryColor,
            cursorHeight: 20,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontFamily: Constants.fontRegular),
            decoration: InputDecoration(
              prefixText: ' ',
              prefixStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontFamily: Constants.fontRegular),
              hintText: 'Please enter your mobile number',
              hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontFamily: Constants.fontRegular),
              contentPadding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
              errorStyle: const TextStyle(color: Colors.red),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.transparent, width: 1)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.transparent, width: 1)),
            ),
            onFieldSubmitted: (val) {
              //_onFormSubmitted();
            },
          ),
        ),
        (state.isFailure)
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Center(
                    child: Text(
                      state.message!,
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontFamily: Constants.fontSemiBold),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget loginButton(LoginState state) {
    return AuthButton(
      title: 'Continue',
      color: Constants.primaryColor,
      fontFamily: Constants.fontMedium,
      onPressed: () {
        if (!(state.isSubmitting)) {
          _onFormSubmitted();
        }
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.screenWidth,
      textSize: 15,
      isLoading: (state.isSubmitting) ? true : false,
    );
  }

  Widget termsLine1() {
    return const Center(
      child: Text(
        'By clicking Continue, you agree to',
        style: TextStyle(
            color: Color.fromRGBO(40, 40, 40, 1),
            fontSize: 11,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget termsLine2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        GestureDetector(
          onTap: (){

          },
          child: const Text(
            'Privacy Policy',
            style: TextStyle(
                color: Color.fromRGBO(40, 40, 40, 1),
                fontSize: 13,
                fontFamily: Constants.fontBold),
          ),
        ),

        const Text(
          ' and ',
          style: TextStyle(
              color: Color.fromRGBO(40, 40, 40, 1),
              fontSize: 11,
              fontFamily: Constants.fontRegular),
        ),

        GestureDetector(
          onTap: (){

          },
          child: const Text(
            'Terms & Conditions',
            style: TextStyle(
                color: Color.fromRGBO(40, 40, 40, 1),
                fontSize: 13,
                fontFamily: Constants.fontBold),
          ),
        ),
      ],
    );
  }

  Widget skipButton() {
    return InkWell(
      onTap: () async {
        //skip login process
        _authBloc.add(AuthenticationSkip());
        Navigator.pushNamedAndRemoveUntil(
            context, HabitozRoutes.app, (route) => false);
      },
      child: SizedBox(
        height: SizeConfig.blockSizeHorizontal * 12,
        width: SizeConfig.blockSizeHorizontal * 20,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Padding(
              padding: EdgeInsets.only(bottom: 3.0),
              child:  Text(
                'Skip',
                style: TextStyle(
                    color: Color.fromRGBO(136, 136, 136, 1),
                    fontSize: 16,
                    fontFamily: Constants.fontRegular),
              ),
            ),

            const SizedBox(
              width: 5,
            ),

            Container(
              padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(136, 136, 136, 1),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 8,
                )
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onPhoneChanged() {
    _loginBloc.add(
      LoginPhoneChanged(phone: _phoneController.text),
    );
  }

  void _onFormSubmitted() {

    FocusScope.of(context).requestFocus(FocusNode());

    if ( _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _loginBloc.add(
        LoginWithCredentials(
          phone: _phoneController.text,
        ),
      );
    }
    else{
      Fluttertoast.showToast(msg: 'Please fill in your mobile number');
    }
  }

  void _notifyError() {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    _phoneController.notifyListeners();
  }

  Future<bool> _onBackPressed() async {
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
