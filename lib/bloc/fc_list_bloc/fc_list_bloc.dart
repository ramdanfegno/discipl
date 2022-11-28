import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../models/fitness_center_list_model.dart';
import '../../models/home_page_model.dart';
import '../../repositories/product_repo.dart';
import '../../repositories/user_repo.dart';

part 'fc_list_event.dart';
part 'fc_list_state.dart';

class FCListBloc
    extends Bloc<FCListEvent, FCListState> {
  final ProductRepository _productRepository;


  FCListBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(FCListingFetchInitial());

  FCListState get initialState => FCListingFetchInitial();

  @override
  Stream<FCListState> mapEventToState(FCListEvent event) async* {
    if (event is LoadListingPage) {
      yield* _mapLoadDetailPageToState(event.forceRefresh,event.slug,event.pageNo,event.searchQ);
    }
    if (event is RefreshListingPage) {
      yield* _mapLoadDetailPageToState(event.forceRefresh,event.slug,event.pageNo,event.searchQ);
    }
    if (event is SearchListingPage) {
      yield* _mapLoadDetailPageToState(event.forceRefresh,event.slug,event.pageNo,event.searchQ!);
    }
    if (event is PaginateListingPage) {
      yield* _mapPaginateDetailPageToState(event.forceRefresh,event.slug,event.pageNo,event.searchQ,event.fcList!);
    }
  }

  Stream<FCListState> _mapLoadDetailPageToState(bool forceRefresh,String? slug,int pageNo,String? searchQ) async* {
    try{
      yield FCListingFetchLoading();
      Response? response = await _productRepository.getFitnessCenterList(forceRefresh,slug!,pageNo,searchQ);
      if(response != null){
        if(response.statusCode == 200){
          FitnessCenterListModel fitnessCenterModel = FitnessCenterListModel.fromJson(response.data);
          yield FCListingFetchSuccess(
              fcList: (fitnessCenterModel.results != null)
                  ? fitnessCenterModel.results! : [],
              isLoading: false,
              pageNo: 1
          );
        }
        else{
          yield const FCListingFetchFailure(message: 'Error loading data',fcList: []);
        }
      }
      else{
        yield const FCListingFetchFailure(message: 'Error loading data',fcList: []);
      }
    }
    catch(e){
      print(e.toString());
      yield FCListingFetchFailure(message: e.toString(),fcList: const []);
    }
  }

  Stream<FCListState> _mapPaginateDetailPageToState(bool forceRefresh,String? slug,int pageNo,String? searchQ,List<FitnessCenterModel> fcList) async* {
    try{
      yield FCListingFetchSuccess(fcList: fcList, isLoading: true,pageNo: pageNo);
      List<FitnessCenterModel> fCList = fcList;
      Response? response = await _productRepository.getFitnessCenterList(forceRefresh,slug!,pageNo++,searchQ);
      if(response != null){
        if(response.statusCode == 200){
          FitnessCenterListModel fitnessCenterModel = FitnessCenterListModel.fromJson(response.data);
          fCList.addAll(fitnessCenterModel.results!);
          yield FCListingFetchSuccess(fcList: fCList,isLoading: false,pageNo: pageNo++);
        }
        else if(response.statusCode == 404){
          yield FCListingFetchSuccess(fcList: fcList, isLoading: true,pageNo: pageNo);
        }
        else{
          yield FCListingFetchSuccess(fcList: fcList, isLoading: true,pageNo: pageNo,errorMsg: 'Error loading data');
        }
      }
      else{
        yield FCListingFetchSuccess(fcList: fcList, isLoading: true,pageNo: pageNo,errorMsg: 'Error loading data');
      }
    }
    catch(e){
      print(e.toString());
      yield FCListingFetchSuccess(fcList: fcList, isLoading: false,pageNo: pageNo, errorMsg: 'Error loading data : ${e.toString()}');
    }
  }


}
