import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_state.dart';

@injectable
class InternetCubit extends Cubit<InternetState> {
  final InternetConnection? connectivity = InternetConnection();
  StreamSubscription? connectivityStreamSubscription;

  InternetCubit() : super(const InternetState()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() async {
    connectivityStreamSubscription =
        connectivity!.onStatusChange.listen((connectivityResult) async {
      try {
        if (connectivityResult == InternetStatus.connected) {
          emit(state.copyWith(status: NetworkState.connected));
        } else if (connectivityResult == InternetStatus.disconnected) {
          emit(state.copyWith(
              status: NetworkState.disconnected, previousDisconnected: true));
        }
      } on SocketException catch (_) {
        emit(state.copyWith(
            status: NetworkState.disconnected, previousDisconnected: true));
      }
    });
  }

  @override
  Future<void> close() async {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}
