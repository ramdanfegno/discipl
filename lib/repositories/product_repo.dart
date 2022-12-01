

import 'package:dio/dio.dart';
import 'package:habitoz_fitness_app/models/zone_list_model.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';

import '../models/login_response.dart';
import '../utils/api_query.dart';
import '../utils/constants.dart';

class ProductRepository{
  ApiQuery apiQuery = ApiQuery();
  final UserRepository userRepository = UserRepository();


  //home page
  Future<Response?> getHomePage(bool forceRefresh,ZoneResult? zone) async {
      LoginResponse? loginResponse = await userRepository.getLoginResponse();
      Map<String,String> headers = {};
      if(loginResponse != null){
        String? token = loginResponse.token;
        headers['Authorization'] = 'Token $token';
      }

      Map<String,dynamic> queryParams = {};
      if(zone != null){
        queryParams['zone_id'] = zone.id;
      }

      Response? response = await apiQuery.getQuery(
          Constants.apiHome, headers, queryParams,
          'HomeApi', true, true, forceRefresh);
      return response;
      try {

      }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //fitness center list
  Future<Response?> getFitnessCenterList(bool forceRefresh,String? slug,int pageNo,String? searchQ,String? categoryId,int? zoneId) async {
    try {
      LoginResponse? loginResponse = await userRepository.getLoginResponse();
      Map<String,String> headers = {};
      if(loginResponse != null){
        String? token = loginResponse.token;
        headers['Authorization'] = 'Token $token';
      }

      Map<String,dynamic> queryParams = {
        'page' : pageNo.toString()
      };

      if(categoryId != null){
        queryParams['category_id'] = categoryId;
      }

      if(zoneId != null){
        queryParams['zone_id'] = zoneId;
      }

      print(queryParams);
      String apiName = 'FitnessCenterListApi$slug${pageNo.toString()}';

      if(searchQ != null){
        queryParams['q'] = searchQ;
        apiName += searchQ;
      }

      String url =  Constants.apiFitnessCenterList;
      if(slug != null){
        url += '$slug/';
      }

      Response? response = await apiQuery.getQuery(
          url, headers, queryParams,
          apiName, true, true, forceRefresh);
      return response;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //fitness center details
  Future<Response?> getFitnessCenterDetail(bool forceRefresh,String id) async {
    try {
      print('getFitnessCenterDetail');
      LoginResponse? loginResponse = await userRepository.getLoginResponse();
      Map<String,String> headers = {};
      if(loginResponse != null){
        String? token = loginResponse.token;
        headers['Authorization'] = 'Token $token';
      }

      Response? response = await apiQuery.getQuery(
          '${Constants.apiFitnessCenterList}fc/$id/', headers, {},
          'FitnessCenterApi$id', true, true, forceRefresh);
      print('getFitnessCenterDetail response');
      print(response!.statusCode);
      print(response.statusMessage);
      print(response.data);

      return response;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //feed list
  Future<Response?> getZoneList(bool forceRefresh,int pageNo,String? searchQ) async {
    try {
      LoginResponse? loginResponse = await userRepository.getLoginResponse();
      Map<String,String> headers = {};
      if(loginResponse != null){
        String? token = loginResponse.token;
        headers['Authorization'] = 'Token $token';
      }

      Map<String,String> queryParams = {
        'page' : pageNo.toString()
      };

      print(queryParams);
      String apiName = 'ZoneListApi${pageNo.toString()}';

      if(searchQ != null){
        queryParams['q'] = searchQ;
        apiName += searchQ;
      }

      Response? response = await apiQuery.getQuery(
          Constants.apiZoneList, headers, queryParams,
          apiName, true, true, forceRefresh);
      return response;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //post enquiry
  Future<Response?> postEnquiry(Map<String,dynamic> details) async {
    try {

    LoginResponse? loginResponse = await userRepository.getLoginResponse();
    Map<String,String> headers = {};
    if(loginResponse != null){
      String? token = loginResponse.token;
      headers['Authorization'] = 'Token $token';
    }

    Map<String, dynamic> body = {};

    body = details;

    print(body);

      Response? response = await apiQuery.postQuery(
          Constants.apiPostEnquiry,headers, body, 'PostEnquiry');
      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }


  //set location api
  Future<Response?> setLocation(Map<String,dynamic> data) async {

    LoginResponse? loginResponse = await userRepository.getLoginResponse();
    Map<String,String> headers = {};
    if(loginResponse != null){
      String? token = loginResponse.token;
      headers['Authorization'] = 'Token $token';
    }

    Map<String, dynamic> body = {};

    body = data;

    print(body);

    try {
      Response? response = await apiQuery.postQuery(
          Constants.apiSetLocation,headers, body, 'SetLocation');
      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

/*  _getCurrentLocation() async{
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
    l.PermissionStatus permissionGranted;
    permissionGranted = await location.hasPermission();
    if (permissionGranted == l.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != l.PermissionStatus.granted) {
        setState(() {});
        _locationBloc.add(LoadLocationPage(forceRefresh: false, pageNo: _pageNo,isLoading: true));
        return;
      }
      else if(permissionGranted == l.PermissionStatus.granted || permissionGranted == l.PermissionStatus.grantedLimited){
        location.getLocation().then((value) async {
          _currentLat = value.latitude;
          _currentLong = value.longitude;

          // From coordinates
          List<Placemark> placeMarks = await placemarkFromCoordinates(_currentLat!, _currentLong!);
          print('placeMarks[0].locality');
          print(placeMarks[0].locality);
          print('placeMarks[0].name');
          print(placeMarks[0].name);
          print('placeMarks[0].administrativeArea');
          print(placeMarks[0].administrativeArea);
          print('placeMarks[0].street');
          print(placeMarks[0].street);
          print('placeMarks[0].postalCode');
          print(placeMarks[0].postalCode);
          print('placeMarks[0].subLocality');
          print(placeMarks[0].subLocality);
          print('placeMarks[0].subAdministrativeArea');
          print(placeMarks[0].subAdministrativeArea);
          print('placeMarks[0].subThoroughfare');
          print(placeMarks[0].subThoroughfare);
          _currentPlace = placeMarks[0].locality;
          if(mounted){
            setState(() {});
            _locationBloc.add(LoadLocationPage(forceRefresh: false, pageNo: _pageNo,isLoading: true));
          }
        }).timeout(const Duration(seconds: 3), onTimeout: (){
          isCalledAgain = isCalledAgain! + 1;
          if(isCalledAgain! <= 5){
            getLocation();
          }
          else{
            if(mounted){
              setState(() {});
              _locationBloc.add(LoadLocationPage(forceRefresh: false, pageNo: _pageNo,isLoading: true));
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
        print('placeMarks[0].locality');
        print(placeMarks[0].locality);
        print('placeMarks[0].name');
        print(placeMarks[0].name);
        print('placeMarks[0].administrativeArea');
        print(placeMarks[0].administrativeArea);
        print('placeMarks[0].street');
        print(placeMarks[0].street);
        print('placeMarks[0].subLocality');
        print(placeMarks[0].subLocality);
        print('placeMarks[0].subAdministrativeArea');
        print(placeMarks[0].subAdministrativeArea);
        print('placeMarks[0].subThoroughfare');
        print(placeMarks[0].subThoroughfare);

        _currentPlace = placeMarks[0].locality;

        if(mounted){
          setState(() {});
          _locationBloc.add(LoadLocationPage(forceRefresh: false, pageNo: _pageNo,isLoading: true));
        }

      }).timeout(const Duration(seconds: 3), onTimeout: (){
        isCalledAgain = isCalledAgain! + 1;
        if(isCalledAgain! <= 5){
          getLocation();
        }
        else{
          if(mounted){
            setState(() {});
            _locationBloc.add(LoadLocationPage(forceRefresh: false, pageNo: _pageNo,isLoading: true));
          }
          isCalledAgain = 0 ;
          Fluttertoast.showToast(msg: 'Timed out! Unable to obtain location');
        }
      });
    }
  }*/

}