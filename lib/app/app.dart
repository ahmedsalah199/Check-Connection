import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/app_theme.dart';
import '../core/utils/app_strings.dart';
import '../cubit/cubit_used/network_cubit.dart';
import '../presentation/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();
  static const _instance = MyApp._internal();
  factory MyApp() => _instance;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionCubit()
        ..checkNetworkConnection()
        ..checkInternetConnection(),
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
