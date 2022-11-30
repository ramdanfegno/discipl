import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../models/home_page_model.dart';
import '../../models/zone_list_model.dart';
import '../../repositories/product_repo.dart';
import '../../repositories/user_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc
    extends Bloc<HomeEvent, HomeState> {
  final ProductRepository _productRepository;
  final UserRepository _userRepository;


  HomeBloc({required ProductRepository productRepository,required UserRepository userRepository})
      : _productRepository = productRepository, _userRepository = userRepository,
        super(HomeFetchInitial());

  HomeState get initialState => HomeFetchInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadHome) {
      yield* _mapLoadHomeToState(event.forceRefresh,event.zone);
    }
  }

  Stream<HomeState> _mapLoadHomeToState(bool forceRefresh,ZoneResult? zoneResult) async* {
    try{

      yield HomeFetchLoading();
      Response? response = await _productRepository.getHomePage(forceRefresh,zoneResult);
      if(response != null){
        print(response.statusMessage);
        print(response.data);
        print(response.statusCode);
        if(response.statusCode == 200){
          HomePageModel homePageModel = HomePageModel.fromJson(response.data);
          ZoneResult? zone = await _userRepository.getZoneDetailsLocal();
          if(zoneResult != null){
            zone = zoneResult;
            await _userRepository.storeZoneDetails(zone);
          }
          yield HomeFetchSuccess(homeDate: homePageModel,isLoading: false,zone: zone!);
        }
        else{
          yield const HomeFetchFailure(message: 'Error loading data');
        }
      }
      else{
        yield const HomeFetchFailure(message: 'Error loading data');
      }

      }

    catch(e){
      print(e.toString());
      yield HomeFetchFailure(message: e.toString());
    }
  }
}