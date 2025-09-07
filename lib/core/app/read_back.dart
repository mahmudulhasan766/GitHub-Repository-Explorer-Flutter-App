import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readback/features/no_internet/cubit/internet_cubit.dart';
import 'package:readback/features/no_internet/no_internet_view.dart';
import 'package:readback/features/theme/app_theme.dart';
import 'package:readback/features/theme/cubit/theme_cubit.dart';
import '../router/routes.dart';
import 'app_context.dart';
import 'app_providers.dart';

class ReadBack extends StatelessWidget {
  const ReadBack({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProviders.providers,
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocConsumer<InternetCubit, InternetState>(
          listener: (context, internetState) {
            if (internetState.status == NetworkState.disconnected) {
              AppContext.to(const NoInternetScreen());
            }
          },
          builder: (context, state) {
            return ScreenUtilInit(
              designSize: const Size(430, 932), // App screen size
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (BuildContext context, Widget? child) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: MaterialApp(
                    scrollBehavior: ScrollConfiguration.of(context)
                        .copyWith(physics: const BouncingScrollPhysics()),
                    debugShowCheckedModeBanner: false,
                    navigatorKey: AppContext.navigatorKey,
                    theme: themeState.themeMode == ThemeModeStatus.light? AppTheme.lightTheme:AppTheme.darkTheme,
                    builder: EasyLoading.init(),
                    onGenerateRoute: RouteGenerator.getRoute,
                    initialRoute: Routes.splash,
                    localizationsDelegates: [
                      ...context.localizationDelegates,
                    ],
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
