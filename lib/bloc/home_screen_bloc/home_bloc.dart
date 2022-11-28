import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../models/home_page_model.dart';
import '../../repositories/product_repo.dart';
import '../../repositories/user_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc
    extends Bloc<HomeEvent, HomeState> {
  final ProductRepository _productRepository;


  HomeBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(HomeFetchInitial());

  HomeState get initialState => HomeFetchInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadHome) {
      yield* _mapLoadHomeToState(event.forceRefresh);
    }
  }

  Stream<HomeState> _mapLoadHomeToState(bool forceRefresh) async* {
      yield HomeFetchLoading();
      Response? response = await _productRepository.getHomePage(forceRefresh);
      if(response != null){
        print(response.statusMessage);
        print(response.data);
        print(response.statusCode);

        if(response.statusCode == 200){
          HomePageModel homePageModel = HomePageModel.fromJson(response.data);
          yield HomeFetchSuccess(homeDate: homePageModel,isLoading: false);
        }
        else{
          yield const HomeFetchFailure(message: 'Error loading data');
        }
      }
      else{
        yield const HomeFetchFailure(message: 'Error loading data');
      }

      try{
      }

    catch(e){
      print(e.toString());
      yield HomeFetchFailure(message: e.toString());
    }
  }
}