import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';

import '../../../utils/scroll_setting.dart';
import '../../../utils/size_config.dart';
import '../../widgets/buttons/auth_button.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/others/app_bar.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  late bool isLoading;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            isHomeAppBar: false,
            appBarTitle: 'Update Profile',
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

              //update button
              Positioned(
                  bottom: SizeConfig.blockSizeHorizontal * 7,
                  right: SizeConfig.blockSizeHorizontal * 7,
                  child: updateButton()),

              //cancel button
              Positioned(
                  bottom: SizeConfig.blockSizeHorizontal * 7,
                  left: SizeConfig.blockSizeHorizontal * 7,
                  child: cancelButton()),

            ],
          ),
        ),
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
              //name(),
              SizedBox(height: SizeConfig.blockSizeHorizontal*5),
              //phone(),
              SizedBox(height: SizeConfig.blockSizeHorizontal*5),
              //phone(),
              SizedBox(height: SizeConfig.blockSizeHorizontal*5),
              //dob(),
              SizedBox(height: SizeConfig.blockSizeHorizontal*5),
              //gender(),
              SizedBox(height: SizeConfig.blockSizeHorizontal*30),
            ],
          ),
        ),
      ),
    );
  }

/*
  Widget name() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  //color: (state.isFailure) ? Colors.red : Constants.fontColor1,
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
            //validator: (state.),
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
        ) : Container(),
      ],
    );
  }
*/

  Widget updateButton() {
    return AuthButton(
      title: 'Next',
      color: Constants.primaryColor,
      onPressed: () {
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

  Widget cancelButton() {
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

}
