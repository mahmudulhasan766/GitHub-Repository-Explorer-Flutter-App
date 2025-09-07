import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readback/features/home/cubit/home_cubit.dart';
import 'package:readback/features/no_internet/cubit/internet_cubit.dart';
import 'package:readback/features/theme/cubit/theme_cubit.dart';
import 'app_dependency.dart';

class AppProviders {
  static final providers = <BlocProvider>[
    BlocProvider<ThemeCubit>(
      create: (BuildContext context) => instance<ThemeCubit>(),
    ),
    BlocProvider<InternetCubit>(
      create: (BuildContext context) => instance<InternetCubit>(),
    ),
    BlocProvider<HomeCubit>(
      create: (BuildContext context) => instance<HomeCubit>(),
    ),
  ];
}
