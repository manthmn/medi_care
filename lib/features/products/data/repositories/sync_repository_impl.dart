import '../../domain/repositories/sync_repository.dart';
import '../datasources/product_local_data_source.dart';

class SyncRepositoryImpl implements SyncRepository {
  SyncRepositoryImpl(this._localDataSource);

  final ProductLocalDataSource _localDataSource;

  @override
  Future<DateTime?> getLastSynced() => _localDataSource.getLastSynced();

  @override
  Future<void> setLastSynced(DateTime time) =>
      _localDataSource.setLastSynced(time);
}
