import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';

part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? streamSubscription;

  InternetBloc() : super(InternetInitial()) {
    on<onConnected>((event, emit) {
      connectedState(msg: "connected");
    });

    on<notConnected>((event, emit) {
      notConnectedState(msg: "Not connected");
    });

    on<InternetEvent>((event, emit) {});

    streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        add(onConnected());
      } else {
        add(notConnected());
      }
    });
  }
}
