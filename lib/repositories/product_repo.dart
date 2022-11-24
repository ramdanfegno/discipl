

import 'package:dio/dio.dart';
import 'package:habitoz_fitness_app/repositories/user_repo.dart';

import '../models/login_response.dart';
import '../utils/api_query.dart';
import '../utils/constants.dart';

class ProductRepository{
  ApiQuery apiQuery = ApiQuery();
  final UserRepository userRepository = UserRepository();


  //home page
  Future<Response?> getHomePage(bool forceRefresh) async {
    try {
      LoginResponse? loginResponse = await userRepository.getLoginResponse();
      String? token = loginResponse!.token;

      Map<String,String> headers = {
        'Authorization' : 'Token $token'
      };

      Response? response = await apiQuery.getQuery(
          Constants.apiHome, headers, {},
          'HomeApi', true, true, forceRefresh);
      return response;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //fitness center list
  Future<Response?> getFitnessCenterList(bool forceRefresh) async {
    try {
      LoginResponse? loginResponse = await userRepository.getLoginResponse();
      String? token = loginResponse!.token;

      Map<String,String> headers = {
        'Authorization' : 'Token $token'
      };

      Response? response = await apiQuery.getQuery(
          Constants.apiFitnessCenterList, headers, {},
          'FitnessCenterListApi', true, true, forceRefresh);
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
      LoginResponse? loginResponse = await userRepository.getLoginResponse();
      String? token = loginResponse!.token;

      Map<String,String> headers = {
        'Authorization' : 'Token $token'
      };

      Response? response = await apiQuery.getQuery(
          '${Constants.apiFitnessCenterList}/$id/', headers, {},
          'FitnessCenterApi$id', true, true, forceRefresh);
      return response;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //feed list
  Future<Response?> getFeedList(bool forceRefresh) async {
    try {
      LoginResponse? loginResponse = await userRepository.getLoginResponse();
      String? token = loginResponse!.token;

      Map<String,String> headers = {
        'Authorization' : 'Token $token'
      };

      Response? response = await apiQuery.getQuery(
          Constants.apiFeedList, headers, {},
          'FeedListApi', true, true, forceRefresh);
      return response;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //post enquiry
  Future<Response?> postEnquiry(String? name, String? phone, String? email) async {

    LoginResponse? loginResponse = await userRepository.getLoginResponse();
    String? token = loginResponse!.token;

    Map<String,String> headers = {
      'Authorization' : 'Token $token'
    };

    Map<String, dynamic> body = {
      "name": name!,
      "phone": phone!,
      "email": email!,
    };

    print(body);

    try {
      Response? response = await apiQuery.postQuery(
          Constants.apiPostEnquiry,headers, body, 'PostEnquiry');
      return response;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }


  //set location api
  Future<Response?> setLocation(double? lat,double? long,String? placeName) async {

    LoginResponse? loginResponse = await userRepository.getLoginResponse();
    String? token = loginResponse!.token;

    Map<String,String> headers = {
      'Authorization' : 'Token $token'
    };

    Map<String, dynamic> body = {
      "lat": lat!,
      "long": long!,
      "placeName": placeName!,
    };

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

}