import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/core/utils/app_strings.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/utils/app_components.dart';
import 'network_state.dart';

class ConnectionCubit extends Cubit<NetWorkState> {
  StreamSubscription? _subscription;
  StreamSubscription<InternetConnectionStatus>? _listener;
  String hasInternet = AppStrings.noInternet;
  String result = AppStrings.noNetwork;
  bool isCheckInternet = false;

  Icon iconNetwork = iconApp(icon: Icons.info, color: Colors.red);
  Icon iconInternet = iconApp(icon: Icons.info, color: Colors.red);

  ConnectionCubit() : super(ConnectionInitial());
  static ConnectionCubit getCubit(context) => BlocProvider.of(context);

  void connectedWifi() {
    result = AppStrings.wifiNetwork;
    iconNetwork = iconApp(
      icon: Icons.wifi,
    );
    emit(WifiNetworkConnectedState());
  }

  void connectedMobileData() {
    result = AppStrings.mobileDataNetwork;
    iconNetwork = iconApp(
      icon: Icons.mobile_friendly,
    );
    emit(MobileDataNetworkConnectionState());
  }

  void noNetwork() {
    result = AppStrings.noNetwork;
    iconNetwork = iconApp(icon: Icons.info, color: Colors.red);
    emit(NoNetworkConnectionState());
  }

  void noInternet() {
    hasInternet = AppStrings.noInternet;
    iconInternet = iconApp(icon: Icons.info, color: Colors.red);
    emit(NoInternetConnectionState());
  }

  void activeInternet() {
    hasInternet = AppStrings.activeInternet;
    iconInternet = iconApp(icon: Icons.check, color: Colors.green);
    emit(ActiveInternetConnectionState());
  }

  void checkNetworkConnection() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen(_updateNetworkConnectionStatus);
  }

  Future<void> initCheckNetworkConnection() async {
    var result = await Connectivity().checkConnectivity();
    return _updateNetworkConnectionStatus(result);
  }

  Future<void> _updateNetworkConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi) {
      connectedWifi();
    } else if (result == ConnectivityResult.mobile) {
      connectedMobileData();
    } else {
      noNetwork();
    }
  }

  void checkInternetConnection() async {
    _listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      if (status == InternetConnectionStatus.connected) {
        activeInternet();
      } else {
        noInternet();
      }
    });
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    _listener!.cancel();
    return super.close();
  }
}
