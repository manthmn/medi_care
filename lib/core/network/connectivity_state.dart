part of 'connectivity_cubit.dart';

enum ConnectivityStatus { online, offline }

@freezed
class ConnectivityState with _$ConnectivityState {
  const ConnectivityState._();

  const factory ConnectivityState({
    required ConnectivityStatus status,
  }) = _ConnectivityState;

  bool get isOffline => status == ConnectivityStatus.offline;
}
