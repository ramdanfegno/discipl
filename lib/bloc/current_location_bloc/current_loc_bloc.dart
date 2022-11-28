import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../models/home_page_model.dart';
import '../../repositories/product_repo.dart';
import '../../repositories/user_repo.dart';

part 'current_loc_event.dart';
part 'current_loc_state.dart';

class CurrentLocBloc
    extends Bloc<CurrentLocEvent, CurrentLocState> {
  final ProductRepository _productRepository;


  CurrentLocBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(CurrentLocInitial());

  CurrentLocState get initialState => CurrentLocInitial();

  @override
  Stream<CurrentLocState> mapEventToState(CurrentLocEvent event) async* {
    if (event is LoadCurrentLoc) {
      yield* _mapLoadCurrentLocToState();
    }
  }

  Stream<CurrentLocState> _mapLoadCurrentLocToState() async* {
    try{
      yield FetchCurrentLocLoading();


    }
    catch(e){
      print(e.toString());
      yield CurrentLocFailure(message: e.toString());
    }
  }
}