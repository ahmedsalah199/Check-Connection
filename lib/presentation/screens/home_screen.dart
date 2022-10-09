import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_strings.dart';
import '../../cubit/cubit_used/network_cubit.dart';
import '../../cubit/cubit_used/network_state.dart';
import '../widgets/connection_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ConnectionCubit.getCubit(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.appName,
          ),
        ),
        body: BlocConsumer<ConnectionCubit, NetWorkState>(
          listener: (context, state) {
            if (state is ConnectionInitial) {
              cubit.initCheckNetworkConnection();
            }
          },
          builder: (context, state) {
            return BlocBuilder<ConnectionCubit, NetWorkState>(
              builder: (context, state) {
                return ConnectionWidget(
                  network: cubit.result,
                  iconNetwork: cubit.iconNetwork,
                  internet: cubit.hasInternet,
                  iconInternet: cubit.iconInternet,
                );
              },
            );
          },
        ));
  }
}
