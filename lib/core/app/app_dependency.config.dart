// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:readback/core/app/app_dependency.dart' as _i20;
import 'package:readback/core/app/app_preference.dart' as _i3;
import 'package:readback/data/network/api_client.dart' as _i12;
import 'package:readback/data/network/api_request.dart' as _i10;
import 'package:readback/data/network/demo_api_client.dart' as _i11;
import 'package:readback/features/home/cubit/home_cubit.dart' as _i19;
import 'package:readback/features/home/repository/home_repo.dart' as _i17;
import 'package:readback/features/home/repository/home_repo_imp.dart' as _i18;
import 'package:readback/features/no_internet/cubit/internet_cubit.dart' as _i9;
import 'package:readback/features/theme/cubit/theme_cubit.dart' as _i8;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.factory<_i3.AppPreferences>(() => _i3.AppPreferences());
  await gh.factoryAsync<_i4.SharedPreferences>(
    () => appModule.prefs,
    preResolve: true,
  );
  gh.factory<_i5.Dio>(() => appModule.dio);
  gh.factory<_i8.ThemeCubit>(() => _i8.ThemeCubit());
  gh.factory<_i9.InternetCubit>(() => _i9.InternetCubit());
  gh.factory<_i10.ApiRequest>(() => _i10.ApiRequest());
  gh.factory<_i11.ApiClient>(() => _i11.ApiClient(gh<_i5.Dio>()));
  gh.factory<_i12.ApiClient>(() => _i12.ApiClient(gh<_i5.Dio>()));
  gh.factory<_i17.HomeRepository>(
      () => _i18.HomeRepositoryImp(apiRequest: gh<_i10.ApiRequest>()));
  gh.factory<_i19.HomeCubit>(() => _i19.HomeCubit(gh<_i17.HomeRepository>()));
  return getIt;
}

class _$AppModule extends _i20.AppModule {}
