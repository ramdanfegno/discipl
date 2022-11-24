import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/select_result.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/update_measurement.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import 'components/measurement_tile.dart';
import 'components/result_tile2.dart';
import 'result_display.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late UserProfile? userProfile;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(
            isHomeAppBar: false,
            appBarTitle: 'My Profile',
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                buildProfile(),

                SizedBox(height: SizeConfig.blockSizeHorizontal*5),

                buildResults(),

                SizedBox(height: SizeConfig.blockSizeHorizontal*10),

                buildMeasurements(),

                SizedBox(height: SizeConfig.blockSizeHorizontal*40),

              ],
            ),
          )
      ),
    );
  }

  Widget buildProfile(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        SizedBox(height: SizeConfig.blockSizeHorizontal*5),

        buildImage(),

        SizedBox(height: SizeConfig.blockSizeHorizontal*5),

        Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Stuart Paul',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: Constants.fontMedium
                ),
              ),

              const SizedBox(
                width: 20,
              ),

              GestureDetector(
                onTap: (){
                  //update profile
                },
                child: const Icon(
                  Icons.edit_outlined,
                  color: Colors.red,
                  size: 16,
                ),
              )
            ],
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        const Text(
          '+91 7736272789',
          style: TextStyle(
              color: Color.fromRGBO(102, 102, 102, 1),
              fontSize: 13,
              fontFamily: Constants.fontRegular
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        const Text(
          'stuart1995paul@gmail.com',
          style: TextStyle(
              color: Color.fromRGBO(102, 102, 102, 1),
              fontSize: 13,
              fontFamily: Constants.fontRegular
          ),
        ),
      ],
    );
  }

  Widget buildImage(){
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal*30,
      height: SizeConfig.blockSizeHorizontal*30,
      child: Stack(
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal*30,
            height: SizeConfig.blockSizeHorizontal*30,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('assets/images/png/user_image.png'),
                    fit: BoxFit.fitWidth
                )
            ),
          ),
          Positioned(
              bottom: SizeConfig.blockSizeHorizontal*0,
              right: SizeConfig.blockSizeHorizontal*0,
              child: GestureDetector(
                onTap: (){

                  },
                child: Container(
                  width: SizeConfig.blockSizeHorizontal*10,
                  height: SizeConfig.blockSizeHorizontal*10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
          ))
        ],
      ),
    );
  }

  Widget buildResults(){
    //if all results are available

    //if only bmi is available

    //if none are available

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ResultTile(
            title: 'BMI',
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ResultView(resultType: 'BMI',fitnessResponse: null,);
                }));
            },
            result: '23.6 Kg/m2',
            isAvailable: true,
          ),

          const Divider(color: Color.fromRGBO(228, 228, 228, 1)),

          ResultTile(
            title: 'BMR',
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ResultView(resultType: 'BMR',fitnessResponse: null,);
                }));
            },
            result: '1717 Calories/day',
            isAvailable: true,
          ),

          const Divider(color: Color.fromRGBO(228, 228, 228, 1)),

          ResultTile(
            title: 'Body Fat',
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ResultView(resultType: 'Body Fat',fitnessResponse: null,);
                }));
            },
            result: '18.1%',
            isAvailable: true,
          ),
        ],
      ),
    );
  }

  Widget buildMeasurements(){
    return Container(
      width: SizeConfig.blockSizeHorizontal*95,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(2,2),
                blurRadius: 10
            )
          ]
      ),
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal*3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: SizeConfig.blockSizeHorizontal*2),

          const Text(
            'MEASUREMENTS',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: Constants.fontMedium
            ),
          ),

          SizedBox(height: SizeConfig.blockSizeHorizontal*5),

          buildMeasurementHeading(),

          SizedBox(height: SizeConfig.blockSizeHorizontal*2),

          const Divider(color: Color.fromRGBO(136, 136, 136, 1)),

          MeasurementTile(
              title: 'Height',
              onPressed: (){

              },
              relaxedReading: '165 cm',
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Weight',
              onPressed: (){

              },
              relaxedReading: '80 Kg',
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Neck',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UpdateMeasurement(title: 'Neck Size',);
                }));
              },
              relaxedReading: '25 cm',
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Chest',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UpdateMeasurement(title: 'Chest Size',);
                }));
              },
              relaxedReading: null,
              extendedReading: null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Shoulders',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UpdateMeasurement(title: 'Shoulders Size',);
                }));
              },
              relaxedReading: null,
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Upper Arm Right',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UpdateMeasurement(title: 'Upper Arm Right',);
                }));
              },
              relaxedReading: null,
              extendedReading: null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Upper Arm Left',
              onPressed: (){

              },
              relaxedReading: null,
              extendedReading: null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Forearm Right',
              onPressed: (){

              },
              relaxedReading: null,
              extendedReading: null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Forearm Left',
              onPressed: (){

              },
              relaxedReading: null,
              extendedReading: null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Waist',
              onPressed: (){

              },
              relaxedReading: null,
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Wrist',
              onPressed: (){

              },
              relaxedReading: '98',
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Hip',
              onPressed: (){

              },
              relaxedReading: null,
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Thigh Right',
              onPressed: (){

              },
              relaxedReading: null,
              extendedReading: null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Thigh Left',
              onPressed: (){

              },
              relaxedReading: null,
              extendedReading: null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Calf Right',
              onPressed: (){

              },
              relaxedReading: null,
              extendedReading: null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Calf Left',
              onPressed: (){

              },
              relaxedReading: null,
              extendedReading: null,
              isExtendedAvailable: true
          ),

          SizedBox(height: SizeConfig.blockSizeHorizontal*5),

        ],
      ),
    );
  }

  Widget buildMeasurementHeading(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: SizeConfig.blockSizeHorizontal*30,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 2),
          child: const Text(
            'Body Parts',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: Constants.fontMedium
            ),
          ),
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal*27,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 2),
          child: const Text(
            'Relaxed',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: Constants.fontMedium
            ),
          ),
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal*27,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 2),
          child: const Text(
            'Extended',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: Constants.fontMedium
            ),
          ),
        ),
      ],
    );
  }
}


