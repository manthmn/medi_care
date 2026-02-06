import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/repositories/sync_repository.dart';

part 'sync_cubit.freezed.dart';

@freezed
class SyncState with _$SyncState {
  const factory SyncState({DateTime? lastSyncedAt}) = _SyncState;

  factory SyncState.initial() => const SyncState(lastSyncedAt: null);
}

class SyncCubit extends Cubit<SyncState> {
  SyncCubit({required SyncRepository syncRepository})
      : _syncRepository = syncRepository,
        super(SyncState.initial());

  final SyncRepository _syncRepository;

  Future<void> loadLastSynced() async {
    final lastSynced = await _syncRepository.getLastSynced();
    emit(state.copyWith(lastSyncedAt: lastSynced));
  }

  Future<void> updateLastSynced() async {
    final now = DateTime.now();
    await _syncRepository.setLastSynced(now);
    emit(state.copyWith(lastSyncedAt: now));
  }
}
