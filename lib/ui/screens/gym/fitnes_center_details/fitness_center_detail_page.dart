import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/bloc/fc_detail_bloc/fc_detail_bloc.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitnes_center_details/components/gym_detail_tile.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitnes_center_details/components/gym_image_container.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/components/gym_address_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/components/gym_enquiry_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/components/gym_plan_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/components/gym_working_time_tile.dart';
import 'package:habitoz_fitness_app/ui/screens/gym/fitnes_center_details/request_callback_page.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/bulletin_tile_widget.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/circular_sliding_tile.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../../models/fitness_center_list_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import '../../../widgets/others/color_loader.dart';

class FitnessCenterDetailPage extends StatefulWidget {
  const FitnessCenterDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FitnessCenterDetailPage> createState() =>
      _FitnessCenterDetailPageState();
}

class _FitnessCenterDetailPageState
    extends State<FitnessCenterDetailPage> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Constants.primaryColor.withOpacity(0.3),
          child: SingleChildScrollView(
            child: Column(
              children: [

                BlocBuilder<FCDetailBloc, FCDetailState>(
                  builder: (context, state) {
                    if (state is FCDetailFetchSuccess) {
                      if(state.errorMsg != null){
                        showToast(state.errorMsg!);
                      }
                      if(state.details != null){
                        return fcDetailView(state.details!, state.isLoading);
                      }
                      else{
                        return buildErrorView('List is empty!');
                      }
                    }
                    if (state is FCDetailFetchFailure) {
                      return buildErrorView(state.message);
                    }
                    if (state is FCDetailFetchLoading) {
                      return buildLoadingView();
                    }
                    return Container();
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fcDetailView(FitnessCenterModel details,bool isLoading){

    String address = '';
    if(details.addressLine1 != null){
      address += details.addressLine1!;
    }
    if(details.addressLine2 != null){
      address += ', ';
      address += details.addressLine2!;
    }
    if(details.addressLine3 != null){
      address += ', ';
      address += details.addressLine3!;
    }
    if(details.addressLine4 != null){
      address += ', ';
      address += details.addressLine4!;
      address += '.';
    }

    List<Amenities> amenities = [];
    if(details.amenities != null){
      amenities.add(details.amenities!);
    }

    return Column(
      children: [

        const GymImageContainer(),

        /*=========Gym Detail Container=========*/

        GymDetailContainer(
          description: (details.description != null) ? details.description! : '',
          gymnasium: 'Gymnasium',
          gymName: (details.name != null) ? details.name! : '',
          place: (details.location != null) ? details.location! : '',
          distance: '5',
        ),

        /*=======Gym address Tile========*/

        GymAddressTile(
          address: address,
        ),

        /*=======Gym time Tile========*/

        (details.workingTime != null) ?
        GymWorkingTimeTile(
          time: details.workingTime,
        ) : Container(),

        /*=======Gym amenities Tile========*/

        CircularSlidingTile(
          content: amenities,
          title: 'Amenities',
        ),

        /*=======Gym services Tile========*/

        BulletinTileWidget(
          bulletinHeading: 'Other Services',
          category: details.category,
        ),

        /*=======Gym rules Tile========*/

        BulletinTileWidget(
            bulletinHeading: 'Rules',
            category: details.rules,
        ),

        /*=======Gym plan Tile========*/

        GymPlanTile(
          plan: details.plans!,
        ),

        /*=======Gym enquiry Tile========*/

        GymEnquiryTile(
          requestButtonClicked: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RequestCallBackPage(
                      fitnessCenterID: details.id.toString(),
                      categoryList: details.category!,
                    )));
          },
        )
      ],
    );
  }

  Widget buildErrorView(String msg){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: SizeConfig.blockSizeVertical*60,
      child: Center(
        child: Text(
          msg,
          style: const TextStyle(
              color: Constants.fontColor1,
              fontSize: 22,
              fontFamily: Constants.fontRegular
          ),
        ),
      ),
    );
  }

  Widget buildLoadingView(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: SizeConfig.blockSizeVertical*60,
      child: Center(
        child: ColorLoader5(),
      ),
    );
  }

  showToast(String msg){
    Fluttertoast.showToast(msg: msg);
  }

}
