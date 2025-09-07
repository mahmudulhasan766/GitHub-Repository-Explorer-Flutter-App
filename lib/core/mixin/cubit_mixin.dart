import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/custom_refresh/src/smart_refresher.dart';

mixin CubitMixin<T> on Cubit<T> {
  int page = 1;
  int perPage = 10;
  int total = -1;

  var refreshCtrl = RefreshController();
  final scrollCtrl = ScrollController();

  void resetPagination() {
    page = 1;
    total = -1;
  }

  void loadComplete() {
    refreshCtrl.loadComplete();
    refreshCtrl.refreshCompleted();
  }

  void updateUi(T state) => emit(state);
}
