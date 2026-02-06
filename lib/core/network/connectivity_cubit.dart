import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import '../../features/products/data/datasources/product_local_data_source.dart';
import 'network_info.dart';

part 'connectivity_state.dart';

/// Bloc is chosen for predictable state transitions, strong debugging,
/// and scalability for offline-first flows.
class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit({
    required Connectivity connectivity,
    required NetworkInfo networkInfo,
    required ProductLocalDataSource productLocalDataSource,
  })  : _connectivity = connectivity,
        _networkInfo = networkInfo,
        _productLocalDataSource = productLocalDataSource,
        super(const ConnectivityState.initial());

  final Connectivity _connectivity;
  final NetworkInfo _networkInfo;
  final ProductLocalDataSource _productLocalDataSource;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void startListening() {
    _subscription ??=
        _connectivity.onConnectivityChanged.listen(_onConnectivityChange);
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final connected = await _networkInfo.isConnected;
    final lastSynced = await _productLocalDataSource.getLastSynced();
    emit(state.copyWith(
      status:
          connected ? ConnectivityStatus.online : ConnectivityStatus.offline,
      lastSyncedAt: lastSynced,
    ));
  }

  void _onConnectivityChange(List<ConnectivityResult> results) {
    final connected = !results.contains(ConnectivityResult.none);
    emit(state.copyWith(
      status:
          connected ? ConnectivityStatus.online : ConnectivityStatus.offline,
    ));
  }

  /// Call this after products are successfully synced to update the last synced time
  Future<void> updateLastSynced() async {
    final lastSynced = await _productLocalDataSource.getLastSynced();
    emit(state.copyWith(lastSyncedAt: lastSynced));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
