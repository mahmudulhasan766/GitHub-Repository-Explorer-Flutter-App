import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_style.dart';
import 'cubit/internet_cubit.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocConsumer<InternetCubit, InternetState>(
        listener: (context, state) {
         /* if (state.status == NetworkState.connected) {
            Navigator.pop(context);
          }*/
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.wifi_off, // Using Material Icons wifi_off icon
                    color: AppColors.error1,
                    size: 100.r,
                  ),
                  8.verticalSpace,
                  Text(
                    AppStrings.noInternetConnection.tr(),
                    style: kBodyLarge,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
