import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../models/fitness_center_list_model.dart';
import '../../models/zone_list_model.dart';
import '../../repositories/product_repo.dart';

part 'search_zone_event.dart';
part 'search_zone_state.dart';

class SearchZoneBLoc extends Bloc<SearchZoneEvent, SearchZoneState> {
  final ProductRepository _productRepository;

  SearchZoneBLoc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(SearchInitial());

  SearchZoneState get initialState => SearchInitial();

  @override
  Stream<SearchZoneState> mapEventToState(SearchZoneEvent event) async* {
    if (event is SearchInitiate) {
      yield* _mapGetSearchResultState(
          searchQ: event.searchQ, forceRefresh: event.forceRefresh);
    }
  }

  Stream<SearchZoneState> _mapGetSearchResultState({required String searchQ, required bool forceRefresh}) async* {
    yield SearchLoading();
    try {
      if (searchQ != '') {
        Response? response = await _productRepository.getZoneList(forceRefresh,1,searchQ);
        print(response!.statusMessage);
        print(response.statusCode);
        print(response.data);
        if (response.statusCode == 200) {
          print(response.data);
          ZoneListModel zoneListModel = ZoneListModel.fromJson(response.data);
          if (zoneListModel.results!.isNotEmpty) {
            yield SearchDisplay(locationList: zoneListModel.results!);
          } else {
            yield SearchEmpty();
          }
        } else if (response.statusCode == 400) {
          yield SearchEmpty();
        } else {
          yield SearchEmpty();
        }
      } else {
        yield SearchEmpty();
      }
    } catch (e) {
      print("============ \n\n\n $Error\n\n\n ===========");
      yield SearchError(message: e.toString());
    }
  }
}
