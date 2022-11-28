import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../widgets/buttons/auth_button.dart';

class RequestCallBackPage extends StatefulWidget {
  const RequestCallBackPage({Key? key}) : super(key: key);

  @override
  State<RequestCallBackPage> createState() => _RequestCallBackPageState();
}

class _RequestCallBackPageState extends State<RequestCallBackPage> {
  late String yourName, phoneNumber, email;
  final focusNode1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 4,
                ),
                Container(
                  height: SizeConfig.blockSizeHorizontal * 8,
                  width: SizeConfig.blockSizeHorizontal * 8,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child:  Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.white,
                    size: SizeConfig.blockSizeHorizontal*4,
                  ),
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 13,
            ),
            Row(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 4,
                ),
                Text(
                  'Call Back Request',
                  style: TextStyle(
                      fontFamily: Constants.fontMedium,
                      fontSize: SizeConfig.blockSizeHorizontal * 7),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 10,
            ),
            nameTextFormField()!,
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 4,
            ),
            phoneNumberField()!,
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 4,
            ),
            emailTextField()!,
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 4.5,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2.9,
                  right: SizeConfig.blockSizeHorizontal * 2.9),
              child: AuthButton(
                  fontFamily: Constants.fontMedium,
                  color: Constants.primaryColor,
                  title: 'Submit',
                  onPressed: () {
                  },
                  height: SizeConfig.blockSizeHorizontal * 14.5,
                  width: MediaQuery.of(context).size.width,
                  textSize: SizeConfig.blockSizeHorizontal * 4,
                  isLoading: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget? nameTextFormField() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 4,
        right: SizeConfig.blockSizeHorizontal * 4,
        // top: SizeConfig.screenHeight / 30
      ),
      child: Container(
        width: SizeConfig.blockSizeVertical * 86.6,
        child: TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          autofocus: false,
          onFieldSubmitted: (v) {
            yourName = v;
            FocusScope.of(context).requestFocus(focusNode1);
          },
          validator: (val1) => val1!.isNotEmpty ? null : 'Enter your name',
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
              hintText: 'Your name',
              hintStyle: const TextStyle(
                color: Constants.appbarColor,
                fontSize: 16,
                fontFamily: Constants.fontRegular,
              ),
              contentPadding: EdgeInsets.only(
                  top: SizeConfig.screenHeight / 50,
                  left: SizeConfig.blockSizeVertical * 2),
              errorStyle: TextStyle(color: Colors.red),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.red[400]!,
                    width: SizeConfig.blockSizeHorizontal * 0.33),
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  borderSide: BorderSide(
                      color: Colors.red[400]!,
                      width: SizeConfig.blockSizeHorizontal * 0.33)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.black,
                    width: SizeConfig.blockSizeHorizontal * 0.33),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.black,
                    width: SizeConfig.blockSizeHorizontal * 0.33),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: SizeConfig.blockSizeHorizontal * 0.33))),
          onSaved: (input) => yourName = input!.trim(),
        ),
      ),
    );
  }

  Widget? phoneNumberField() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeVertical * 2,
        right: SizeConfig.blockSizeVertical * 2,
        // top: SizeConfig.screenHeight / 3const 0
      ),
      child: Container(
        height: SizeConfig.blockSizeHorizontal * 13.3,
        width: SizeConfig.blockSizeVertical * 86.6,
        child: TextFormField(
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
          autofocus: false,
          onFieldSubmitted: (v) {
            phoneNumber = v;
            FocusScope.of(context).requestFocus(focusNode1);
          },
          validator: (String? v) {
            if (v!.length == 0) {
              return 'Enter phone number';
            }
            if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(v)) {
              return 'Enter 10 digit phone number';
            }
            ;
            return null;
          },
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
              hintText: 'Phone',
              hintStyle: const TextStyle(
                color: Constants.appbarColor,
                fontSize: 16,
                fontFamily: Constants.fontRegular,
              ),
              contentPadding: EdgeInsets.only(
                  top: SizeConfig.screenHeight / 50,
                  left: SizeConfig.blockSizeVertical * 2),
              errorStyle: const TextStyle(color: Colors.red),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.red[400]!,
                    width: SizeConfig.blockSizeHorizontal * 0.33),
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  borderSide: BorderSide(
                      color: Colors.red[400]!,
                      width: SizeConfig.blockSizeHorizontal * 0.33)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.black,
                    width: SizeConfig.blockSizeHorizontal * 0.33),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.black,
                    width: SizeConfig.blockSizeHorizontal * 0.33),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: SizeConfig.blockSizeHorizontal * 0.33))),
          onSaved: (input) => phoneNumber = input!,
        ),
      ),
    );
  }

  Widget? emailTextField() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeVertical * 2,
        right: SizeConfig.blockSizeVertical * 2,
        // top: SizeConfig.screenHeight / 3const 0
      ),
      child: Container(
        height: SizeConfig.blockSizeHorizontal * 13.3,
        width: SizeConfig.blockSizeVertical * 86.6,
        child: TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          autofocus: false,
          onFieldSubmitted: (v) {
            email = v;
            FocusScope.of(context).requestFocus(focusNode1);
          },
          validator: (String? v) {
            if (v!.isEmpty) {
              return 'Enter Email';
            }
            if (!RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(v)) {
              return 'Enter a valid Email';
            }

            return null;
          },
          decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: const TextStyle(
                color: Constants.appbarColor,
                fontSize: 16,
                fontFamily: Constants.fontRegular,
              ),
              contentPadding: EdgeInsets.only(
                  top: SizeConfig.screenHeight / 50,
                  left: SizeConfig.blockSizeVertical * 2),
              errorStyle: const TextStyle(color: Colors.red),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.red[400]!,
                    width: SizeConfig.blockSizeHorizontal * 0.33),
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  borderSide: BorderSide(
                      color: Colors.red[400]!,
                      width: SizeConfig.blockSizeHorizontal * 0.33)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.black,
                    width: SizeConfig.blockSizeHorizontal * 0.33),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.black,
                    width: SizeConfig.blockSizeHorizontal * 0.33),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: SizeConfig.blockSizeHorizontal * 0.33))),
          onSaved: (input) => email = input!,
        ),
      ),
    );
  }
}
