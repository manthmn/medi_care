part of 'connectivity_cubit.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityState extends Equatable {
  const ConnectivityState({
    required this.status,
  });

  const ConnectivityState.initial() : status = ConnectivityStatus.online;

  final ConnectivityStatus status;

  ConnectivityState copyWith({
    ConnectivityStatus? status,
  }) {
    return ConnectivityState(
      status: status ?? this.status,
    );
  }

  bool get isOffline => status == ConnectivityStatus.offline;

  @override
  List<Object?> get props => [status];
}

