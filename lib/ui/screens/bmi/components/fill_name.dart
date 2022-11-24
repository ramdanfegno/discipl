import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../../utils/constants.dart';

class FillName extends StatefulWidget {

  final String? name;
  final Function(String) onFilled;

  const FillName({Key? key,required this.name,required this.onFilled}) : super(key: key);

  @override
  State<FillName> createState() => _FillNameState();
}

class _FillNameState extends State<FillName> {

  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*3),
      child: Column(
        children: [
          subTitle(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 30),
          nameHeading(),
          SizedBox(height: SizeConfig.blockSizeHorizontal * 5),
          buildTextField(),
        ],
      ),
    );
  }

  Widget subTitle() {
    return const Center(
      child: Text(
        'Let\'s find out where your health stands.',
        style: TextStyle(
            color: Color.fromRGBO(136, 136, 136, 1),
            fontSize: 12,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget nameHeading() {
    return const Center(
      child: Text(
        'Your Name',
        style: TextStyle(
            color: Color.fromRGBO(68, 68, 68, 1),
            fontSize: 18,
            fontFamily: Constants.fontRegular),
      ),
    );
  }

  Widget buildTextField(){
    return TextFormField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      initialValue: name,
      autofocus: false,
      onFieldSubmitted: (v) {
        name = v ;
        widget.onFilled(v);
      },
      onChanged: (v){
        name = v;
        EasyDebounce.debounce(
            'DebounceUserName',
            const Duration(milliseconds: 400), () {
          widget.onFilled(v);
        });
      },
      validator: (val1)=> val1!.isNotEmpty ? null: 'Enter Name',
      style: TextStyle(
          color: Colors.grey[800],
          fontSize: 14,
          fontFamily: Constants.fontRegular),
      decoration: InputDecoration(
        hintText: 'Please enter your name',
        hintStyle: const TextStyle(
            color: Color.fromRGBO(136, 136, 136, 1),
            fontSize: 13,
            fontFamily: Constants.fontRegular),
        contentPadding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
        errorStyle: const TextStyle(color: Colors.red),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red, width: 1)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red, width: 1)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color.fromRGBO(136, 136, 136, 1), width: 1)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color.fromRGBO(136, 136, 136, 1), width: 2)),
      ),
      onSaved: (input) => name = input!,
    );
  }

}
