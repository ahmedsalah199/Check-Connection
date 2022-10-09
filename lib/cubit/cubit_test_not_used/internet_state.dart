part of 'internet_cubit.dart';

abstract class InternetState {}

class InternetInitial extends InternetState {}

class ConnectedState extends InternetState {}

class CheckConnectionState extends InternetState {}

class NotConnectedState extends InternetState {}
