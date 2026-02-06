abstract class SyncRepository {
  Future<DateTime?> getLastSynced();
  Future<void> setLastSynced(DateTime time);
}
