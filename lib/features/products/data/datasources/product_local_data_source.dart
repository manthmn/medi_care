import 'package:medi_care/core/constants/app_constants.dart';

import '../../../../shared/data/local/app_database.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
  Future<void> setLastSynced(DateTime time);
  Future<DateTime?> getLastSynced();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  ProductLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    await _db.upsertProducts(products.map((e) => e.toCompanion()).toList());
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final rows = await _db.getAllProducts();
    return rows.map(ProductModel.fromDb).toList();
  }

  @override
  Future<void> setLastSynced(DateTime time) {
    return _db.setMetadata(
        AppConstants.productsLastSyncedKey, time.toIso8601String());
  }

  @override
  Future<DateTime?> getLastSynced() async {
    final value = await _db.getMetadata(AppConstants.productsLastSyncedKey);
    if (value == null) return null;
    return DateTime.tryParse(value);
  }
}
