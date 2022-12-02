import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/models/fitness_center_list_model.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/repositories/product_repo.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/verify_otp_page.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../../models/otp_response_model.dart';
import '../../../widgets/buttons/auth_button.dart';
import '../../../widgets/dialog/status_dialog.dart';
import 'components/select_category.dart';

class RequestCallBackPage extends StatefulWidget {

  final String? fitnessCenterID;
  final List<Amenities>? categoryList;
  const RequestCallBackPage({Key? key,required this.fitnessCenterID,required this.categoryList}) : super(key: key);

  @override
  State<RequestCallBackPage> createState() => _RequestCallBackPageState();
}

class _RequestCallBackPageState extends State<RequestCallBackPage> {
  late bool isLoading;
  final focusNode1 = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ProductRepository productRepository = ProductRepository();
  final UserRepository userRepository = UserRepository();
  late bool? isGuest;
  late TextEditingController _nameEditingController,_phoneEditingController,_emailEditingController,_messageEditingController;
  late Amenities? _selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    isGuest = false;
    _selectedCategory = null;
    _nameEditingController = TextEditingController();
    _phoneEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _messageEditingController = TextEditingController();
    getProfile();
  }

  getProfile() async{

    print('getProfile');
    isGuest = await userRepository.isGuest();
    if(!isGuest!){
      print('isGuest false');
      UserProfile? userProfile = await userRepository.getProfileDetailsLocal();
      if(userProfile != null){
        print('userProfile not null');
        if(userProfile.user != null){
          print('userProfile user not null');
          if(userProfile.user!.firstName != null){
            _nameEditingController.text = userProfile.user!.firstName!;
          }
          if(userProfile.user!.mobile != null){
            _phoneEditingController.text = userProfile.user!.mobile!;
          }
          if(userProfile.user!.email != null){
            _emailEditingController.text = userProfile.user!.email!;
          }
        }
      }
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: SizeConfig.blockSizeHorizontal * 8,
                      width: SizeConfig.blockSizeHorizontal * 8,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child:  Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.white,
                        size: SizeConfig.blockSizeHorizontal*4,
                      ),
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
                height: SizeConfig.blockSizeHorizontal * 4,
              ),
              buildCategory(),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal * 4,
              ),
              messageTextField()!,
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
                      validate();
                    },
                    height: SizeConfig.blockSizeHorizontal * 14.5,
                    width: MediaQuery.of(context).size.width,
                    textSize: SizeConfig.blockSizeHorizontal * 4,
                    isLoading: isLoading),
              ),
            ],
          ),
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
      child: SizedBox(
        width: SizeConfig.blockSizeVertical * 86.6,
        height: SizeConfig.blockSizeHorizontal*14,
        child: TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          autofocus: false,
          controller: _nameEditingController,
          onFieldSubmitted: (v) {
            _nameEditingController.text = v;
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
                  top: SizeConfig.blockSizeHorizontal*4,
                  bottom: SizeConfig.blockSizeHorizontal*4,
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
                    color: Colors.grey[700]!,
                    width: 1
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.grey[800]!,
                    width: 1
                ),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: SizeConfig.blockSizeHorizontal * 0.33))),
          //onSaved: (input) => _yourName = input!.trim(),
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
      child: SizedBox(
        height: SizeConfig.blockSizeHorizontal*14,
        width: SizeConfig.blockSizeVertical * 86.6,
        child: TextFormField(
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
          autofocus: false,
          controller: _phoneEditingController,
          onFieldSubmitted: (v) {
            _phoneEditingController.text = v;
          },
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
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
              hintText: 'Phone',
              hintStyle: const TextStyle(
                color: Constants.appbarColor,
                fontSize: 16,
                fontFamily: Constants.fontRegular,
              ),
              contentPadding: EdgeInsets.only(
                  top: SizeConfig.blockSizeHorizontal*4,
                  bottom: SizeConfig.blockSizeHorizontal*4,
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
                    color: Colors.grey[700]!,
                    width: 1
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.grey[800]!,
                    width: 1
                ),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: SizeConfig.blockSizeHorizontal * 0.33))),
          //onSaved: (input) => _phoneNumber = input!,
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
      child: SizedBox(
        height: SizeConfig.blockSizeHorizontal*14,
        width: SizeConfig.blockSizeVertical * 86.6,
        child: TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          autofocus: false,
          controller: _emailEditingController,
          onFieldSubmitted: (v) {
            _emailEditingController.text = v;
            FocusScope.of(context).requestFocus(focusNode1);
          },
          validator: (val1) => val1!.isNotEmpty ? null : 'Enter your email',

          /*validator: (String? v) {
            if (v!.isEmpty) {
              return 'Enter Email';
            }
            if (!RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(v)) {
              return 'Enter a valid Email';
            }

            return null;
          },*/
          decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: const TextStyle(
                color: Constants.appbarColor,
                fontSize: 16,
                fontFamily: Constants.fontRegular,
              ),
              contentPadding: EdgeInsets.only(
                  top: SizeConfig.blockSizeHorizontal*4,
                  bottom: SizeConfig.blockSizeHorizontal*4,
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
                    color: Colors.grey[700]!,
                    width: 1
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide:  BorderSide(
                    color: Colors.grey[800]!,
                    width: 1
                ),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: SizeConfig.blockSizeHorizontal * 0.33))),
          //onSaved: (input) => _email = input!,
        ),
      ),
    );
  }

  Widget? messageTextField() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeVertical * 2,
        right: SizeConfig.blockSizeVertical * 2,
        // top: SizeConfig.screenHeight / 3const 0
      ),
      child: SizedBox(
        height: SizeConfig.blockSizeHorizontal*25,
        width: SizeConfig.blockSizeVertical * 86.6,
        child: TextFormField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          autofocus: false,
          maxLines: 5,
          onFieldSubmitted: (v) {
            _messageEditingController.text = v;
          },
          controller: _messageEditingController,
          decoration: InputDecoration(
              hintText: 'Message',
              hintStyle: const TextStyle(
                color: Constants.appbarColor,
                fontSize: 16,
                fontFamily: Constants.fontRegular,
              ),
              contentPadding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 4,
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
                    color: Colors.grey[700]!,
                    width: 1
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                borderSide: BorderSide(
                    color: Colors.grey[800]!,
                    width: 1
                ),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  borderSide: BorderSide(
                      color: Colors.black,
                      width: SizeConfig.blockSizeHorizontal * 0.33))),
          //onSaved: (input) => _message = input!,
        ),
      ),
    );
  }

  Widget buildCategory(){
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (_) {
              return SelectTypeDialog(
                content: widget.categoryList,
                ok: (val) {
                  setState(() {
                    _selectedCategory = val;
                  });
                  print('_selectedCategory!.id');
                  print(_selectedCategory!.id);
                },
                initVal: _selectedCategory,
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeVertical * 2,
          right: SizeConfig.blockSizeVertical * 2,
          // top: SizeConfig.screenHeight / 3const 0
        ),
        child: Container(
          height: SizeConfig.blockSizeHorizontal * 14,
          width: SizeConfig.blockSizeVertical * 86.6,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: (_selectedCategory != null) ? Colors.grey[800]! : Colors.grey[700]!,
                  width: 1
              )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4,
                vertical: SizeConfig.blockSizeHorizontal * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    // ignore: unnecessary_null_comparison
                    (_selectedCategory != null)
                        ? _selectedCategory!.name!
                        : 'Service Required',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: (_selectedCategory != null) ? Colors.black : Constants.appbarColor,
                        fontSize: 16,
                        fontFamily: Constants.fontRegular),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[400],
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  validate() async{
    try{
      if ( _formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if(_selectedCategory != null){
          //verifyPhoneNumber();
          if(isGuest!){
            verifyPhoneNumber();
          }
          else{
            requestApi();
          }
        }
        else{
          Fluttertoast.showToast(msg: 'Please pick a service');
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

  verifyPhoneNumber() async{
    try{
      setState(() {
        isLoading = true;
      });
      Fluttertoast.showToast(msg: 'Verifying phone number .... ');
      print('_phoneEditingController.text');
      print(_phoneEditingController.text);

      Response? response = await userRepository.sendOtp(_phoneEditingController.text);
      print("============ \n\n\n ${response!.data} \n\n\n===========");
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);

      if(response != null && response.statusCode == 200){
        OtpResponse otpResponse = OtpResponse.fromJson(response.data);
        moveToVerificationPage(otpResponse);
      }
      else{
        Fluttertoast.showToast(msg: 'Phone number verification failed');
        setState(() {
          isLoading = false;
        });
      }
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  moveToVerificationPage(OtpResponse otpResponse){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VerifyEnquiryOtpPage(
              otpResponseModel: otpResponse,
              userRepository: userRepository,
              onVerified: (){
                requestApi();
              },
            )));
  }

  requestApi() async{
    try{
      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());

      Map<String,dynamic> details = {};
      details['name'] = _nameEditingController.text;
      details['mobile'] = _phoneEditingController.text;
      details['email'] = _emailEditingController.text;
      details['title'] = _messageEditingController.text;
      details['category'] = _selectedCategory!.id!;
      details['fitness_center'] = widget.fitnessCenterID;

      print('details');
      print(details);

      Response? response = await productRepository.postEnquiry(details);
      print('requestApi');
      print(response!.data);
      print(response.statusCode);
      print(response.statusMessage);
      if(response != null){
        if(response.statusCode == 201){
          setState(() {
            isLoading = false;
          });
          buildSuccessMsg();
          Future.delayed(const Duration(seconds: 1),(){
            Navigator.pop(context,true);
            Navigator.pop(context,true);
          });
        }
        else{
          showSnackBar('Unable to submit request: ${response.statusMessage}');
        }
      }
      else{
        showSnackBar('Unable to submit request');
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e.toString());
      showSnackBar(e.toString());
      setState(() {
        isLoading = false;
      });
    }
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

  buildSuccessMsg(){
    showDialog(
        context: context,
        //barrierDismissible: false,
        builder: (_) {
          return const StatusDialog(
            message: 'Thank You for your enquiry. \n Our team will get back to you as soon as possible',
          );
        });
  }

}
