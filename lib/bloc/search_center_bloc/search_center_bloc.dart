import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../models/fitness_center_list_model.dart';
import '../../repositories/product_repo.dart';

part 'search_center_event.dart';

part 'search_center_state.dart';

class SearchBLoc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository _productRepository;

  SearchBLoc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(SearchInitial());

  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchInitiate) {
      yield* _mapGetSearchResultState(
          searchQ: event.searchQ, forceRefresh: event.forceRefresh);
    }
  }

  Stream<SearchState> _mapGetSearchResultState({required String searchQ, required bool forceRefresh}) async* {
    yield SearchLoading();
    try {
      if (searchQ != '') {
        Response? response = await _productRepository.getFitnessCenterList(forceRefresh,'fc',1,searchQ,null,null);
        print(response!.statusMessage);
        print(response.statusCode);
        print(response.data);
        if (response.statusCode == 200) {
          print(response.data);
          FitnessCenterListModel fitnessCenterModel = FitnessCenterListModel.fromJson(response.data);
          if (fitnessCenterModel.results!.isNotEmpty) {
            yield SearchDisplay(fcList: fitnessCenterModel.results!);
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
