import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../models/fitness_center_list_model.dart';
import '../../models/home_page_model.dart';
import '../../models/zone_list_model.dart';
import '../../repositories/product_repo.dart';
import '../../repositories/user_repo.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc
    extends Bloc<LocationEvent, LocationState> {
  final ProductRepository _productRepository;


  LocationBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(LocationFetchInitial());

  LocationState get initialState => LocationFetchInitial();

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is LoadLocationPage) {
      yield* _mapLoadLocationToState(event.forceRefresh,event.pageNo,event.searchQ,event.isLoading);
    }
    if (event is SearchLocationPage) {
      yield* _mapLoadLocationToState(event.forceRefresh,event.pageNo,event.searchQ!,true);
    }
    if (event is PaginateLocationPage) {
      yield* _mapPaginateLocationPageToState(event.forceRefresh,event.pageNo,event.searchQ,event.locationList!);
    }
  }

  Stream<LocationState> _mapLoadLocationToState(bool forceRefresh,int pageNo,String? searchQ,bool isLoading) async* {
    try{
      if(isLoading){
        yield LocationFetchLoading();
      }
      Response? response = await _productRepository.getZoneList(forceRefresh,pageNo,searchQ);
      if(response != null){
        if(response.statusCode == 200){
          ZoneListModel zoneListModel = ZoneListModel.fromJson(response.data);
          yield LocationFetchSuccess(
              locationList: (zoneListModel.results != null)
                  ? zoneListModel.results! : [],
              isLoading: false,
              pageNo: 1
          );
        }
        else{
          yield const LocationFetchFailure(message: 'Error loading data',locationList: []);
        }
      }
      else{
        yield const LocationFetchFailure(message: 'Error loading data',locationList: []);
      }
    }
    catch(e){
      print(e.toString());
      yield LocationFetchFailure(message: e.toString(),locationList: const []);
    }
  }

  Stream<LocationState> _mapPaginateLocationPageToState(bool forceRefresh,int pageNo,String? searchQ,List<ZoneResult> locationList) async* {
    try{
      yield LocationFetchSuccess(locationList: locationList, isLoading: true,pageNo: pageNo);
      List<ZoneResult> locList = locationList;
      Response? response = await _productRepository.getZoneList(forceRefresh,pageNo++,searchQ);
      if(response != null){
        if(response.statusCode == 200){
          ZoneListModel zoneListModel = ZoneListModel.fromJson(response.data);
          locList.addAll(zoneListModel.results!);
          yield LocationFetchSuccess(locationList: locList,isLoading: false,pageNo: pageNo++);
        }
        else if(response.statusCode == 404){
          yield LocationFetchSuccess(locationList: locationList, isLoading: true,pageNo: pageNo);
        }
        else{
          yield LocationFetchSuccess(locationList: locationList, isLoading: true,pageNo: pageNo,errorMsg: 'Error loading data');
        }
      }
      else{
        yield LocationFetchSuccess(locationList: locationList, isLoading: true,pageNo: pageNo,errorMsg: 'Error loading data');
      }
    }
    catch(e){
      print(e.toString());
      yield LocationFetchSuccess(locationList: locationList, isLoading: false,pageNo: pageNo, errorMsg: 'Error loading data : ${e.toString()}');
    }
  }


}
