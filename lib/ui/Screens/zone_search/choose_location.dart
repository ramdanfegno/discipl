import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habitoz_fitness_app/bloc/location_bloc/location_bloc.dart';
import 'package:habitoz_fitness_app/models/location_response_model.dart';
import 'package:habitoz_fitness_app/models/user_profile_model.dart';
import 'package:habitoz_fitness_app/models/zone_list_model.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';
import 'package:habitoz_fitness_app/ui/screens/zone_search/components/choose_current_location.dart';
import 'package:habitoz_fitness_app/ui/screens/zone_search/search_zone_page_view.dart';
import 'package:habitoz_fitness_app/utils/habitoz_icons.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

import '../../../bloc/search_zone_bloc/search_zone_bloc.dart';
import '../../../repositories/product_repo.dart';
import '../../../utils/constants.dart';
import '../../widgets/others/app_bar.dart';
import '../../widgets/others/color_loader.dart';

class ChooseLocation extends StatefulWidget {
  final Function(ZoneResult) onLocationUpdated;
  final Function() onBackPressed;

  const ChooseLocation({Key? key,required this.onLocationUpdated,required this.onBackPressed}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  late LocationBloc _locationBloc;
  late int _pageNo;
  late List<ZoneResult> _zoneList;
  final _scrollController = ScrollController();
  late bool isLoading,forceRefresh;
  final ProductRepository productRepository = ProductRepository();
  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locationBloc = BlocProvider.of<LocationBloc>(context);
    _pageNo = 1;
    _zoneList = [];
    _scrollController.addListener(_onScroll);
    isLoading = false;
    forceRefresh = true;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //service();
      _locationBloc.add(PaginateLocationPage(
          locationList: _zoneList,
          forceRefresh: true,
          pageNo: _pageNo,
      ));
    }
  }

  Future<bool> _onBackPressed() async {
    widget.onBackPressed();
    return true;
  }


  @override
  Widget build(BuildContext context) {
    _locationBloc.add(LoadLocationPage(forceRefresh: forceRefresh, pageNo: 1,isLoading: forceRefresh));
    forceRefresh = false;
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarTitle: 'Select your location',
          isHomeAppBar: false,
          onBackPressed: (){
            widget.onBackPressed();
            Navigator.pop(context);
          },
        ),
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: Constants.primaryColor.withOpacity(0.3),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.blockSizeHorizontal * 7,
                          width: MediaQuery.of(context).size.width,
                        ),

                        searchWidget(),

                        SizedBox(
                          height: SizeConfig.blockSizeHorizontal * 4,
                        ),

                        currentLocation(),

                        BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, state) {
                            if (state is LocationFetchSuccess) {
                              _pageNo = state.pageNo;
                              _zoneList.clear();
                              _zoneList = state.locationList;
                              if(state.errorMsg != null){
                                showToast(state.errorMsg!);
                              }
                              if(state.locationList.isNotEmpty){
                                return zoneListView(state.locationList, state.isLoading);
                              }
                              else{
                                return buildErrorView(' ');
                              }
                            }
                            if (state is LocationFetchFailure) {
                              return buildErrorView(state.message);
                            }
                            if (state is LocationFetchLoading) {
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

              (isLoading) ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.2),
                child: ColorLoader5(),
              ):Container()

            ],
          )
        ),
      ),
    );
  }

  Widget currentLocation(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: SizeConfig.blockSizeHorizontal*4),
      child: ChooseCurrentLocation(
        onLocationFetched: (data){
          setLocationApi(data);
        },
      ),
    );
  }

  Widget searchWidget(){
    return Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 4),
        child: InkWell(
          onTap: (){
            Navigator.push(context, _createSearchRoute());
          },
          child: Container(
            height: SizeConfig.blockSizeHorizontal * 15,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, border: Border.all(color: Colors.black,width: 1) ,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    enabled: false,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                        fontFamily: Constants.fontMedium),
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    onChanged: (v) {
                     /* EasyDebounce.debounce(
                          'Search-Debounce', const Duration(milliseconds: 500), () {
                        _pageNo = 1;
                        _zoneList.clear();
                        forceRefresh = true;
                        _locationBloc.add(SearchLocationPage(
                            forceRefresh: true,
                            pageNo: _pageNo,
                            searchQ: textEditingController.text
                        ));
                        setState(() {});
                      });*/
                    },
                    decoration: InputDecoration(
                      hintText: 'Search here ...',
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontFamily: Constants.fontMedium),
                      //suffixIcon:
                      contentPadding: EdgeInsets.only(
                          top: SizeConfig.blockSizeHorizontal * 5,
                          bottom: SizeConfig.blockSizeHorizontal * 2,
                          right: SizeConfig.blockSizeHorizontal * 2,
                          left: SizeConfig.blockSizeHorizontal * 4),
                      errorStyle: const TextStyle(color: Colors.red),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          borderSide:
                          BorderSide(color: Colors.red[400]!, width: 2)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          borderSide:
                          BorderSide(color: Colors.red[400]!, width: 2)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          borderSide:
                          BorderSide(color: Colors.transparent, width: 1)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          borderSide:
                          BorderSide(color: Colors.transparent, width: 1)),
                      disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          borderSide:
                          BorderSide(color: Colors.transparent, width: 1)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 2),
                  child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 10,
                      height: SizeConfig.blockSizeHorizontal * 10,
                      child: Icon(
                        HabitozIcons.epSearch,
                        size: 20,
                        color: Colors.grey[700],
                      )
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget zoneListView(List<ZoneResult> zoneList,bool isLoading){
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: zoneList.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: SizeConfig.blockSizeHorizontal*4),
                child: InkWell(
                  onTap: (){
                    Map<String,dynamic> data = {
                      'zone_id' : zoneList[index].id,
                      'location_name' : '',
                    };
                    setLocationApi(data);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: SizeConfig.blockSizeHorizontal*15,
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!,width: 1),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 23.0),
                          child: Text(
                            (zoneList[index].name != null) ? zoneList[index].name! : '',
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: Constants.fontMedium,
                                fontSize: 14),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),

        (isLoading) ? Container(
          height: SizeConfig.blockSizeHorizontal*40,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: ColorLoader5(),
        ):Container()

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

  setLocationApi(Map<String, dynamic> data) async{
    try{
      setState(() {
        isLoading = true;
      });
      Fluttertoast.showToast(msg: 'Setting location.....');

      Response? response = await productRepository.setLocation(data);

      print('setLocationApi');
      print(data);
      print(response!.statusCode);
      print(response.statusMessage);
      print(response.data);

      if(response != null){
        if(response.statusCode == 200){
          // store location local
          LocationResponseModel locationResponseModel = LocationResponseModel.fromJson(response.data);
          if(locationResponseModel.zone != null){
            await userRepository.storeZoneDetails(locationResponseModel.zone!);
            widget.onLocationUpdated(locationResponseModel.zone!);
          }
          if (!mounted) return;
          Navigator.pop(context);
        }
        else{
          showSnackBar('Unable to set location: ${response.statusMessage}');
        }
      }
      else{
        showSnackBar('Unable to set location');
      }
      setState(() {
        isLoading = false;
      });
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
      showSnackBar('Unable to set location');
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

  Route _createSearchRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
          create: (context) => SearchZoneBLoc(
            productRepository: productRepository,
          ),
          child: SearchZonePage(
            productRepository: productRepository,
            onZoneSelected: (data){
              setLocationApi(data!);
            },
            onBackPressed: (){
              _pageNo = 1;
              //_zoneList.clear();
              _locationBloc.add(LoadLocationPage(
                forceRefresh: true,
                isLoading: true,
                pageNo: _pageNo,
              ));
            },
          )
        ),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
