import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_info.dart';

part 'connectivity_state.dart';
part 'connectivity_cubit.freezed.dart';

/// Bloc is chosen for predictable state transitions, strong debugging,
/// and scalability for offline-first flows.
class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit({
    required Connectivity connectivity,
    required NetworkInfo networkInfo,
  })  : _connectivity = connectivity,
        _networkInfo = networkInfo,
        super(const ConnectivityState(status: ConnectivityStatus.online));

  final Connectivity _connectivity;
  final NetworkInfo _networkInfo;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void startListening() {
    _subscription ??=
        _connectivity.onConnectivityChanged.listen(_onConnectivityChange);
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final connected = await _networkInfo.isConnected;
    emit(state.copyWith(
      status:
          connected ? ConnectivityStatus.online : ConnectivityStatus.offline,
    ));
  }

  void _onConnectivityChange(List<ConnectivityResult> results) {
    final connected = !results.contains(ConnectivityResult.none);
    emit(state.copyWith(
      status:
          connected ? ConnectivityStatus.online : ConnectivityStatus.offline,
    ));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
