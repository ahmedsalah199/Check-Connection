import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  StreamSubscription? _subscription;
  StreamSubscription<InternetConnectionStatus>? listener;
  InternetCubit() : super(InternetInitial());

  void connected() {
    emit(ConnectedState());
  }

  void notConnected() {
    emit(NotConnectedState());
  }

  void checkConnection() {
    initConnectivity();
    _subscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      emit(CheckConnectionState());
      listener = InternetConnectionChecker()
          .onStatusChange
          .listen((InternetConnectionStatus status) async {
        if (status == InternetConnectionStatus.connected) {
          connected();
          if (kDebugMode) {
            print(status);
          }
        } else {
          notConnected();
          if (kDebugMode) {
            print(status);
          }
        }
        await Future<void>.delayed(const Duration(seconds: 30));
        await listener!.cancel();
      });
    } else {
      notConnected();
    }
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
