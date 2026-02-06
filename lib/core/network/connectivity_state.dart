part of 'connectivity_cubit.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityState extends Equatable {
  const ConnectivityState({
    required this.status,
    this.lastSyncedAt,
  });

  const ConnectivityState.initial()
      : status = ConnectivityStatus.online,
        lastSyncedAt = null;

  final ConnectivityStatus status;
  final DateTime? lastSyncedAt;

  ConnectivityState copyWith({
    ConnectivityStatus? status,
    DateTime? lastSyncedAt,
  }) {
    return ConnectivityState(
      status: status ?? this.status,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  bool get isOffline => status == ConnectivityStatus.offline;

  @override
  List<Object?> get props => [status, lastSyncedAt];
}
