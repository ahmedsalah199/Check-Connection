import 'package:flutter/material.dart';
import 'package:internet_connection/core/utils/app_strings.dart';

import '../../core/utils/app_font.dart';
import '../../core/utils/app_values.dart';

class ConnectionWidget extends StatelessWidget {
  final String network, internet;
  final Icon iconNetwork, iconInternet;

  const ConnectionWidget(
      {Key? key,
      required this.network,
      required this.iconNetwork,
      required this.internet,
      required this.iconInternet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.connectionStatus,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.s30,
                color: Colors.white),
          ),
          const SizedBox(
            height: AppSize.s40,
          ),
          Row(
            children: [
              iconNetwork,
              const SizedBox(
                width: AppSize.s17,
              ),
              Expanded(
                child: Text(
                  network,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppFontSize.s25,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSize.s25,
          ),
          Row(
            children: [
              iconInternet,
              const SizedBox(
                width: AppSize.s17,
              ),
              Text(
                internet,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: AppFontSize.s25,
                    color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}
