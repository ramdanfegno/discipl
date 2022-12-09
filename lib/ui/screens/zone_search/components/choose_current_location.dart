import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/color_loader.dart';
import 'package:location/location.dart' as l;

import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';

class ChooseCurrentLocation extends StatefulWidget {

  final Function(Map<String,dynamic>) onLocationFetched;
  const ChooseCurrentLocation({Key? key,required this.onLocationFetched}) : super(key: key);

  @override
  _ChooseCurrentLocationState createState() => _ChooseCurrentLocationState();
}

class _ChooseCurrentLocationState extends State<ChooseCurrentLocation> {


  late String? _currentPlace;
  late double? _currentLat,_currentLong;
  l.Location location = l.Location();
  int? isCalledAgain;
  bool? isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    isCalledAgain = 0 ;
    _currentPlace = '';
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: (){
        if(!isLoading!){
          if(_currentLat != null && _currentLong != null){
            Map<String,dynamic> data = {
              'latitude' : _currentLat.toString(),
              'longitude' : _currentLong.toString(),
              'location_name' : _currentPlace!,
              //'zone' : null
            };
            //setLocationApi(data);
            widget.onLocationFetched(data);
          }
          else{
            _getCurrentLocation();
          }
        }
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

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.gps_fixed,
                  color: Colors.red,
                  size: 16,
                ),

                const SizedBox(
                  width: 7,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Use current location',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Constants.fontMedium,
                          fontSize: 14),
                    ),


                    const SizedBox(
                      width: 15,
                    ),

                    (isLoading!) ? ColorLoader5() : Text(
                      (_currentPlace != null && _currentPlace != '') ? _currentPlace! : 'No location available',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: Constants.fontMedium,
                          fontSize: 12),
                    ),
                  ],
                )
              ],
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
    );
  }

  _getCurrentLocation() async{
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
      else if(serviceEnabled){
        getLocation();
        return;
      }
    }
    else if(serviceEnabled){
      getLocation();
    }
  }

  getLocation() async{
    setState(() {
      isLoading = true;
    });
    l.PermissionStatus permissionGranted;
    permissionGranted = await location.hasPermission();
    if (permissionGranted == l.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != l.PermissionStatus.granted) {
        setState(() {
          isLoading = false;
        });
        //_locationBloc.add(LoadLocationPage(forceRefresh: false, pageNo: _pageNo,isLoading: true));
        return;
      }
      else if(permissionGranted == l.PermissionStatus.granted || permissionGranted == l.PermissionStatus.grantedLimited){
        location.getLocation().then((value) async {
          _currentLat = value.latitude;
          _currentLong = value.longitude;

          // From coordinates
          List<Placemark> placeMarks = await placemarkFromCoordinates(_currentLat!, _currentLong!);
          _currentPlace = placeMarks[0].locality;
          if(mounted){
            setState(() {
              isLoading = false;
            });
            //_locationBloc.add(LoadLocationPage(forceRefresh: false, pageNo: _pageNo,isLoading: true));
          }
        }).timeout(const Duration(seconds: 3), onTimeout: (){
          isCalledAgain = isCalledAgain! + 1;
          if(isCalledAgain! <= 5){
            getLocation();
          }
          else{
            if(mounted){
              setState(() {
                isLoading = false;
              });
              //_locationBloc.add(LoadLocationPage(forceRefresh: false, pageNo: _pageNo,isLoading: true));
            }
            isCalledAgain = 0 ;
            Fluttertoast.showToast(msg: 'Timed out! Unable to obtain location');
          }
        });
      }
    }
    else if(permissionGranted == l.PermissionStatus.granted || permissionGranted == l.PermissionStatus.grantedLimited){
      location.getLocation().then((value) async {
        _currentLat = value.latitude;
        _currentLong = value.longitude;

        // From coordinates
        List<Placemark> placeMarks = await placemarkFromCoordinates(_currentLat!, _currentLong!);
        _currentPlace = '';
        if(placeMarks[0].subLocality != null){
          _currentPlace = _currentPlace! + placeMarks[0].subLocality!;
          _currentPlace = '${_currentPlace!},';
        }
        _currentPlace = placeMarks[0].locality;

        if(mounted){
          setState(() {
            isLoading = false;
          });
          //_locationBloc.add(LoadLocationPage(forceRefresh: false, pageNo: _pageNo,isLoading: true));
        }

      }).timeout(const Duration(seconds: 3), onTimeout: (){
        isCalledAgain = isCalledAgain! + 1;
        if(isCalledAgain! <= 5){
          getLocation();
        }
        else{
          if(mounted){
            setState(() {
              isLoading = false;
            });
            //_locationBloc.add(LoadLocationPage(forceRefresh: false, pageNo: _pageNo,isLoading: true));
          }
          isCalledAgain = 0 ;
          Fluttertoast.showToast(msg: 'Timed out! Unable to obtain location');
        }
      });
    }
  }
}
