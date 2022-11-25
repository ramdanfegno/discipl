import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/update_measurement.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';

import '../../../utils/constants.dart';
import '../../../utils/size_config.dart';
import 'components/measurement_tile.dart';
import 'components/result_tile2.dart';
import 'result_display.dart';


class ProfileScreenView extends StatelessWidget {
  final UserProfile? userProfile;
  const ProfileScreenView({Key? key,required this.userProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return (userProfile != null) ? SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          (userProfile!.user != null) ?
          buildProfile() : Container(),

          SizedBox(height: SizeConfig.blockSizeHorizontal*5),

          buildResults(context),

          SizedBox(height: SizeConfig.blockSizeHorizontal*10),

          buildMeasurements(context),

          SizedBox(height: SizeConfig.blockSizeHorizontal*40),

        ],
      ),
    ) : Container();
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
              Text(
                (userProfile!.user!.firstName != null)
                    ? userProfile!.user!.firstName! : '',
                style: const TextStyle(
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

        Text(
          (userProfile!.user!.mobile != null)
              ? userProfile!.user!.mobile! : '',
          style: const TextStyle(
              color: Color.fromRGBO(102, 102, 102, 1),
              fontSize: 13,
              fontFamily: Constants.fontRegular
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        Text(
          (userProfile!.user!.email != null)
              ? userProfile!.user!.email! : '',
          style: const TextStyle(
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

  Widget buildResults(BuildContext context){
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
              if(userProfile!.bodyMassIndex != null && userProfile!.bodyMassIndex! > 0){
                //show bmi result
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ResultView(resultType: 'BMI',fitnessResponse: null,);
                }));
              }
              else{
                //route to calculate bmi
              }
            },
            result: (userProfile!.bodyMassIndex != null && userProfile!.bodyMassIndex! > 0)
                ? userProfile!.bodyMassIndex!.toStringAsFixed(2) :'Calculate',
            isAvailable: (userProfile!.bodyMassIndex != null && userProfile!.bodyMassIndex! > 0),
          ),

          const Divider(color: Color.fromRGBO(228, 228, 228, 1)),

          ResultTile(
            title: 'BMR',
            onPressed: (){
              if(userProfile!.basalMetabolismRate != null && userProfile!.basalMetabolismRate! > 0){
                //show bmr result
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ResultView(resultType: 'BMR',fitnessResponse: null,);
                }));
              }
              else{
                //route to calculate bmi
              }
            },
            result: (userProfile!.basalMetabolismRate != null && userProfile!.basalMetabolismRate! > 0)
                ? userProfile!.basalMetabolismRate!.toStringAsFixed(2) :'Calculate',
            isAvailable: (userProfile!.basalMetabolismRate != null && userProfile!.basalMetabolismRate! > 0),
          ),

          const Divider(color: Color.fromRGBO(228, 228, 228, 1)),

          ResultTile(
            title: 'Body Fat',
            onPressed: (){
              if(userProfile!.bodyFatPercentage != null && userProfile!.bodyFatPercentage! > 0){
                //show body fat result
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ResultView(resultType: 'Body Fat',fitnessResponse: null,);
                }));
              }
              else{
                //route to calculate body fat
              }
            },
            result: (userProfile!.bodyFatPercentage != null && userProfile!.bodyFatPercentage! > 0)
                ? userProfile!.bodyFatPercentage!.toString() :'Calculate',
            isAvailable: (userProfile!.bodyFatPercentage != null && userProfile!.bodyFatPercentage! > 0),
          ),
        ],
      ),
    );
  }

  Widget buildMeasurements(BuildContext context){
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Height',
                    slug: 'height_cm',
                    relaxedReading: (userProfile!.heightCm != null && userProfile!.heightCm! > 0)
                        ? userProfile!.heightCm! : null,
                    isExtendedAvailable: false,
                  );
                }));
              },
              relaxedReading: (userProfile!.heightCm != null && userProfile!.heightCm! > 0)
                  ? userProfile!.heightCm!.toStringAsFixed(2) : null,
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Weight',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Weight',
                    slug: 'weight',
                    relaxedReading: (userProfile!.weight != null && userProfile!.weight! > 0)
                        ? userProfile!.weight! : null,
                    isExtendedAvailable: false,
                  );
                }));
              },
              relaxedReading: (userProfile!.weight != null && userProfile!.weight! > 0)
                  ? userProfile!.weight!.toStringAsFixed(2) :  null,
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Neck',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Neck Size',
                    slug: 'neck',
                    relaxedReading: (userProfile!.neck != null && userProfile!.neck! > 0)
                        ? userProfile!.neck! : null,
                    isExtendedAvailable: false,
                  );
                }));
              },
              relaxedReading: (userProfile!.neck != null && userProfile!.neck! > 0)
                  ? userProfile!.neck!.toStringAsFixed(2) : null,
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Chest',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Chest Size',
                    slug: 'chest_normal',
                    slug2: 'chest_extended',
                    relaxedReading: (userProfile!.chestNormal != null && userProfile!.chestNormal! > 0)
                        ? userProfile!.chestNormal! : null,
                    extendedReading: (userProfile!.chestExtended != null && userProfile!.chestExtended! > 0)
                        ? userProfile!.chestExtended  ! : null,
                    isExtendedAvailable: true,
                  );
                }));
              },
              relaxedReading: (userProfile!.chestNormal != null && userProfile!.chestNormal! > 0)
                  ? userProfile!.chestNormal!.toStringAsFixed(2) : null,
              extendedReading: (userProfile!.chestExtended != null && userProfile!.chestExtended! > 0)
                  ? userProfile!.chestExtended!.toStringAsFixed(2) : null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Shoulders',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Shoulders',
                    slug: 'shoulders',
                    relaxedReading: (userProfile!.shoulders != null && userProfile!.shoulders! > 0)
                        ? userProfile!.shoulders! : null,
                    isExtendedAvailable: false,
                  );
                }));
              },
              relaxedReading: (userProfile!.shoulders != null && userProfile!.shoulders! > 0)
                  ? userProfile!.shoulders!.toStringAsFixed(2) : null,
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Upper Arm Right',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Upper Arm Right',
                    slug: 'right_upperarms_relaxed',
                    slug2: 'right_upperarms_extended',
                    relaxedReading: (userProfile!.rightUpperArmsRelaxed != null && userProfile!.rightUpperArmsRelaxed! > 0)
                        ? userProfile!.rightUpperArmsRelaxed! : null,
                    extendedReading: (userProfile!.rightUpperArmsExtended != null && userProfile!.rightUpperArmsExtended! > 0)
                        ? userProfile!.rightUpperArmsExtended  ! : null,
                    isExtendedAvailable: true,
                  );
                }));
              },
              relaxedReading: (userProfile!.rightUpperArmsRelaxed != null && userProfile!.rightUpperArmsRelaxed! > 0)
                  ? userProfile!.rightUpperArmsRelaxed!.toStringAsFixed(2) : null,
              extendedReading: (userProfile!.rightUpperArmsExtended != null && userProfile!.rightUpperArmsExtended! > 0)
                  ? userProfile!.rightUpperArmsExtended!.toStringAsFixed(2) : null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Upper Arm Left',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Upper Arm Left',
                    slug: 'left_upperarms_relaxed',
                    slug2: 'left_upperarms_extended',
                    relaxedReading: (userProfile!.leftUpperArmsRelaxed != null && userProfile!.leftUpperArmsRelaxed! > 0)
                        ? userProfile!.leftUpperArmsRelaxed! : null,
                    extendedReading: (userProfile!.leftUpperArmsExtended != null && userProfile!.leftUpperArmsExtended! > 0)
                        ? userProfile!.leftUpperArmsExtended  ! : null,
                    isExtendedAvailable: true,
                  );
                }));
              },
              relaxedReading: (userProfile!.leftUpperArmsRelaxed != null && userProfile!.leftUpperArmsRelaxed! > 0)
                  ? userProfile!.leftUpperArmsRelaxed!.toStringAsFixed(2) : null,
              extendedReading: (userProfile!.leftUpperArmsExtended != null && userProfile!.leftUpperArmsExtended! > 0)
                  ? userProfile!.leftUpperArmsExtended!.toStringAsFixed(2) : null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Forearm Right',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Forearm Right',
                    slug: 'right_forearms_relaxed',
                    slug2: 'right_forearms_extended',
                    relaxedReading: (userProfile!.rightForearmsRelaxed != null && userProfile!.rightForearmsRelaxed! > 0)
                        ? userProfile!.rightForearmsRelaxed! : null,
                    extendedReading: (userProfile!.rightForearmsExtended != null && userProfile!.rightForearmsExtended! > 0)
                        ? userProfile!.rightForearmsExtended  ! : null,
                    isExtendedAvailable: true,
                  );
                }));
              },
              relaxedReading: (userProfile!.rightForearmsRelaxed != null && userProfile!.rightForearmsRelaxed! > 0)
                  ? userProfile!.rightForearmsRelaxed!.toStringAsFixed(2) : null,
              extendedReading: (userProfile!.rightForearmsExtended != null && userProfile!.rightForearmsExtended! > 0)
                  ? userProfile!.rightForearmsExtended!.toStringAsFixed(2) : null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Forearm Left',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Forearm Left',
                    slug: 'left_forearms_relaxed',
                    slug2: 'left_forearms_extended',
                    relaxedReading: (userProfile!.leftForearmsRelaxed != null && userProfile!.leftForearmsRelaxed! > 0)
                        ? userProfile!.leftForearmsRelaxed! : null,
                    extendedReading: (userProfile!.leftForearmsExtended != null && userProfile!.leftForearmsExtended! > 0)
                        ? userProfile!.leftForearmsExtended  ! : null,
                    isExtendedAvailable: false,
                  );
                }));
              },
              relaxedReading: (userProfile!.leftForearmsRelaxed != null && userProfile!.leftForearmsRelaxed! > 0)
                  ? userProfile!.leftForearmsRelaxed!.toStringAsFixed(2) : null,
              extendedReading: (userProfile!.leftForearmsExtended != null && userProfile!.leftForearmsExtended! > 0)
                  ? userProfile!.leftForearmsExtended!.toStringAsFixed(2) : null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Waist',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Waist',
                    slug: 'waist',
                    relaxedReading: (userProfile!.waist != null && userProfile!.waist! > 0)
                        ? userProfile!.waist! : null,
                    isExtendedAvailable: false,
                  );
                }));
              },
              relaxedReading: (userProfile!.waist != null && userProfile!.waist! > 0)
                  ? userProfile!.waist!.toStringAsFixed(2) : null,
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Wrist',
              onPressed: (){
                /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Wrist',
                    slug: '',
                    relaxedReading: (userProfile!.chestNormal != null && userProfile!.chestNormal! > 0)
                        ? userProfile!.chestNormal! : null,

                    isExtendedAvailable: false,
                  );
                }));*/
              },
              relaxedReading: null,
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Hip',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Hip',
                    slug: 'hip',
                    relaxedReading: (userProfile!.hip != null && userProfile!.hip! > 0)
                        ? userProfile!.hip! : null,
                    isExtendedAvailable: false,
                  );
                }));
              },
              relaxedReading: (userProfile!.hip != null && userProfile!.hip! > 0)
                  ? userProfile!.hip!.toStringAsFixed(2) : null,
              isExtendedAvailable: false
          ),

          MeasurementTile(
              title: 'Thigh Right',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Thigh Right',
                    slug: 'right_thigh_relaxed',
                    slug2: 'right_thigh_extended',
                    relaxedReading: (userProfile!.rightThighRelaxed != null && userProfile!.rightThighRelaxed! > 0)
                        ? userProfile!.rightThighRelaxed! : null,
                    extendedReading: (userProfile!.rightThighExtended != null && userProfile!.rightThighExtended! > 0)
                        ? userProfile!.rightThighExtended  ! : null,
                    isExtendedAvailable: true,
                  );
                }));
              },
              relaxedReading: (userProfile!.rightThighRelaxed != null && userProfile!.rightThighRelaxed! > 0)
                  ? userProfile!.rightThighRelaxed!.toStringAsFixed(2) : null,
              extendedReading: (userProfile!.rightThighExtended != null && userProfile!.rightThighExtended! > 0)
                  ? userProfile!.rightThighExtended!.toStringAsFixed(2) : null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Thigh Left',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Thigh Left',
                    slug: 'left_thigh_relaxed',
                    slug2: 'left_thigh_extended',
                    relaxedReading: (userProfile!.leftThighRelaxed != null && userProfile!.leftThighRelaxed! > 0)
                        ? userProfile!.leftThighRelaxed! : null,
                    extendedReading: (userProfile!.leftThighExtended != null && userProfile!.leftThighExtended! > 0)
                        ? userProfile!.leftThighExtended  ! : null,
                    isExtendedAvailable: true,
                  );
                }));
              },
              relaxedReading: (userProfile!.leftThighRelaxed != null && userProfile!.leftThighRelaxed! > 0)
                  ? userProfile!.leftThighRelaxed!.toStringAsFixed(2) : null,
              extendedReading: (userProfile!.leftThighExtended != null && userProfile!.leftThighExtended! > 0)
                  ? userProfile!.leftThighExtended!.toStringAsFixed(2) : null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Calf Right',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Calf Right',
                    slug: 'right_calf_relaxed',
                    slug2: 'right_calf_extended',
                    relaxedReading: (userProfile!.rightCalfRelaxed != null && userProfile!.rightCalfRelaxed! > 0)
                        ? userProfile!.rightCalfRelaxed! : null,
                    extendedReading: (userProfile!.rightCalfExtended != null && userProfile!.rightCalfExtended! > 0)
                        ? userProfile!.rightCalfExtended  ! : null,
                    isExtendedAvailable: true,
                  );
                }));
              },
              relaxedReading: (userProfile!.rightCalfRelaxed != null && userProfile!.rightCalfRelaxed! > 0)
                  ? userProfile!.rightCalfRelaxed!.toStringAsFixed(2) : null,
              extendedReading: null,
              isExtendedAvailable: true
          ),

          MeasurementTile(
              title: 'Calf Left',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateMeasurement(
                    title: 'Calf Left',
                    slug: 'left_calf_relaxed',
                    slug2: 'left_calf_extended',
                    relaxedReading: (userProfile!.leftCalfRelaxed != null && userProfile!.leftCalfRelaxed! > 0)
                        ? userProfile!.leftCalfRelaxed! : null,
                    extendedReading: (userProfile!.leftCalfExtended != null && userProfile!.leftCalfExtended! > 0)
                        ? userProfile!.leftCalfExtended  ! : null,
                    isExtendedAvailable: true,
                  );
                }));
              },
              relaxedReading: (userProfile!.leftCalfRelaxed != null && userProfile!.leftCalfRelaxed! > 0)
                  ? userProfile!.leftCalfRelaxed!.toStringAsFixed(2) : null,
              extendedReading: (userProfile!.leftCalfExtended != null && userProfile!.leftCalfExtended! > 0)
                  ? userProfile!.leftCalfExtended!.toStringAsFixed(2) : null,
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



