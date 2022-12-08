import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/components/update_dob.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:intl/intl.dart';

import '../../../bloc/profile_bloc/profile_bloc.dart';
import '../../../repositories/user_repo.dart';
import '../../../utils/scroll_setting.dart';
import '../../../utils/size_config.dart';
import '../../widgets/buttons/auth_button.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/others/app_bar.dart';

class UpdateProfileView extends StatefulWidget {
  final UserProfile? userProfile;
  const UpdateProfileView({Key? key,required this.userProfile}) : super(key: key);

  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {

  late bool isLoading;
  late String? _name,_email,_phone,_gender;
  late DateTime? _dob;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserRepository userRepository = UserRepository();
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _name = null;
    _phone = null;
    _email = null;
    _gender = 'M';
    _dob = null;

    if(widget.userProfile != null){
      if(widget.userProfile!.user != null){
        if(widget.userProfile!.user!.firstName != null){
          _name = widget.userProfile!.user!.firstName;
        }
        if(widget.userProfile!.user!.email != null){
          _email = widget.userProfile!.user!.email;
        }
        if(widget.userProfile!.user!.mobile != null){
          _phone = widget.userProfile!.user!.mobile;
        }
      }
      if(widget.userProfile!.dob != null){
        var s  = widget.userProfile!.dob!.split('-');
        DateTime? t = DateTime(int.parse(s[0]),int.parse(s[1]),int.parse(s[2]));
        //DateTime? t = DateTime.tryParse(widget.profile!.dob!);
        _dob = t;
      }
      if(widget.userProfile!.gender != null){
        _gender = widget.userProfile!.gender;
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
          appBar: CustomAppBar(
            isHomeAppBar: false,
            appBarTitle: 'Update Profile',
            onBackPressed: (){
              Navigator.pop(context, true);
            },
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              name(),
              SizedBox(height: SizeConfig.blockSizeHorizontal*10),
              phone(),
              SizedBox(height: SizeConfig.blockSizeHorizontal*10),
              email(),
              SizedBox(height: SizeConfig.blockSizeHorizontal*10),
              dob(),
              SizedBox(height: SizeConfig.blockSizeHorizontal*10),
              gender(),
              SizedBox(height: SizeConfig.blockSizeHorizontal*30),
            ],
          ),
        ),
      ),
    );
  }

  Widget name() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Name',
          style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.fontMedium,
            fontSize: 13
          ),
        ),

        TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          autofocus: false,
          initialValue: _name,
          onChanged: (v){
            _name = v;
          },
          onSaved: (v){
            _name = v;
          },
          enabled: !isLoading,
          validator: (val1)=> val1!.isNotEmpty ? null: 'Enter Your Name',
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
            hintText: 'Please enter your name',
            hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontFamily: Constants.fontRegular),
            contentPadding:
            EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 0),
            errorStyle: const TextStyle(color: Colors.red),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!, width: 1)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[500]!, width: 1)),
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1)),
          ),
          onFieldSubmitted: (val) {
            _name = val;
          },
        )
      ],
    );
  }

  Widget phone() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone',
          style: TextStyle(
              color: Colors.black,
              fontFamily: Constants.fontMedium,
              fontSize: 13
          ),
        ),

        TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          autofocus: false,
          initialValue: _phone,
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
          ],
          onChanged: (v){
            _phone = v;
          },
          onSaved: (v){
            _phone = v;
          },
          enabled: !isLoading,
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
          style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontFamily: Constants.fontRegular),
          decoration: InputDecoration(
            prefixText: '+91',
            prefixStyle: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontFamily: Constants.fontRegular),
            hintText: 'Please enter your phone number',
            hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontFamily: Constants.fontRegular),
            contentPadding:
            EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 0),
            errorStyle: const TextStyle(color: Colors.red),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!, width: 1)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[500]!, width: 1)),
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1)),
          ),
          onFieldSubmitted: (val) {
            _phone = val;
          },
        )
      ],
    );
  }

  Widget email() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          'Email',
          style: TextStyle(
              color: Colors.black,
              fontFamily: Constants.fontMedium,
              fontSize: 13
          ),
        ),

        TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          initialValue: _email,
          onChanged: (v){
            _email = v;
          },
          onSaved: (v){
            _email = v;
          },
          enabled: !isLoading,
          //validator: (val1)=> val1!.isNotEmpty ? null: 'Enter Your Email Id',
          validator: (String? v) {
            if (v!.isEmpty) {
              return 'Enter Email';
            }
            if (!
            //RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(v)) {
              return 'Enter a valid Email';
            }
            return null;
          },
          style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontFamily: Constants.fontRegular
          ),
          decoration: InputDecoration(
            prefixText: ' ',
            prefixStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontFamily: Constants.fontRegular),
            hintText: 'Please enter your email id',
            hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
                fontFamily: Constants.fontRegular),
            contentPadding:
            EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 0),
            errorStyle: const TextStyle(color: Colors.red),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!, width: 1)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[500]!, width: 1)),
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1)),
          ),
          onFieldSubmitted: (val) {
            _email = val;
          },
        ),
      ],
    );
  }

  Widget dob(){
    return InkWell(
      onTap: (){
        //change dob
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UpdateDob(
            currentDob: _dob,
            onUpdated: (v){
                _dob = v;
                setState(() {});
                },
              );
        }));
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Date of Birth',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: Constants.fontMedium,
                        fontSize: 13
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    (_dob != null) ? DateFormat('MMM dd yyyy').format(_dob!) : '',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                        fontFamily: Constants.fontRegular
                    ),
                  ),

                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                  size: 17,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 1,
            height: 1,
          )
        ],
      ),
    );
  }

  Widget gender(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          'Gender',
          style: TextStyle(
              color: Colors.black,
              fontFamily: Constants.fontMedium,
              fontSize: 13
          ),
        ),

        const SizedBox(
          height: 15,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GenderTile(
                title: 'Male',
                onPressed: (){
                  setState(() {
                    _gender = 'M';
                  });
                },
                isSelected: (_gender == 'M')
            ),

            const SizedBox(
              width: 40,
            ),

            GenderTile(
                title: 'Female',
                onPressed: (){
                  setState(() {
                    _gender = 'F';
                  });
                },
                isSelected: (_gender == 'F')
            ),

            const SizedBox(
              width: 40,
            ),

            GenderTile(
                title: 'Other',
                onPressed: (){
                  setState(() {
                    _gender = 'O';
                  });
                },
                isSelected: (_gender == 'O')
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Divider(
          color: Colors.grey[400],
          thickness: 1,
          height: 1,
        )
      ],
    );
  }

  Widget updateButton() {
    return AuthButton(
      title: 'Update',
      color: Constants.primaryColor,
      fontFamily: Constants.fontMedium,
      onPressed: () {
         if (!(isLoading)) {
          _onFormSubmitted();
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
      backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
      borderColor: const Color.fromRGBO(237, 237, 237, 1),
      titleColor: Colors.black,
      onPressed: () {
        Navigator.pop(context);
      },
      height: SizeConfig.blockSizeHorizontal * 13,
      width: SizeConfig.blockSizeHorizontal* 40,
    );
  }

  _onFormSubmitted() async{
    try{
      if ( _formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        if(_gender != '' && _dob != null){
          updateDetails();
        }
        else{
          Fluttertoast.showToast(msg: 'Please fill all details');
        }
      }
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  updateDetails() async{
    try{

      //_profileBloc.add(UpdateProfile(details: _details));
      //Navigator.pop(context);

      Map<String,dynamic> user = {};
      Map<String,dynamic> details = {};

      details['first_name'] = _name;
      details['email'] = _email;
      details['mobile'] = _phone;
      details['gender'] = _gender;
      details['dob'] = DateFormat('yyyy-MM-dd').format(_dob!);

      print(details);

      Response? response = await userRepository.updateUserDetails(details);
      if(response != null){
        if(response.statusCode == 200){
          // next page
          Fluttertoast.showToast(msg: 'Profile updated');
          Navigator.pop(context);
          _profileBloc.add(LoadProfile());

          /*Future.delayed(const Duration(seconds: 2), (){
          });*/
        }
        else{
          Fluttertoast.showToast(msg: 'Error updating details');
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


}


class GenderTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onPressed;

  const GenderTile({Key? key,required this.title,required this.onPressed,required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              (isSelected) ? Icons.radio_button_on : Icons.radio_button_off,
              color: Colors.black,
              size: 15,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 12,
                  fontFamily: Constants.fontRegular
              ),
            ),

          ],
        ),
      ),
    );
  }
}
