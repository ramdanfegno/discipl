import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/fitness_center_list_model.dart';
import '../../models/home_page_model.dart';
import '../../repositories/product_repo.dart';
import '../../repositories/user_repo.dart';

part 'fc_detail_event.dart';

part 'fc_detail_state.dart';

class FCDetailBloc extends Bloc<FCDetailEvent, FCDetailState> {
  final ProductRepository _productRepository;

  FCDetailBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(FCDetailFetchInitial());

  FCDetailState get initialState => FCDetailFetchInitial();

  @override
  Stream<FCDetailState> mapEventToState(FCDetailEvent event) async* {
    if (event is LoadDetailPage) {
      yield* _mapLoadDetailPageToState(event.forceRefresh, event.id);
    }
  }

  Stream<FCDetailState> _mapLoadDetailPageToState(
      bool forceRefresh, String? id) async* {
    try {
      yield FCDetailFetchLoading();
      Response? response =
          await _productRepository.getFitnessCenterDetail(forceRefresh, id!);
      if (response != null) {
        if (response.statusCode == 200) {
          FitnessCenterModel fitnessCenterModel =
              FitnessCenterModel.fromJson(response.data);
          yield FCDetailFetchSuccess(
              details: fitnessCenterModel, isLoading: false);
        } else if (response.statusCode == 401) {
          yield FCDetailUnAuth(
              dialBox: Dialog(
            child: Column(
              children: [
                Text(response.statusMessage!),

                Text('Please login again')
              ],
            ),
          ));
        }
      } else {
        yield const FCDetailFetchFailure(message: 'Error loading data');
      }
    } catch (e) {
      print(e.toString());
      yield FCDetailFetchFailure(message: e.toString());
    }
  }
}
