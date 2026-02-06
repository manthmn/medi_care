import '../../../../shared/data/local/app_database.dart';

abstract class CartLocalDataSource {
  Future<List<CartTableData>> getCartRows();
  Future<ProductsTableData?> getProductForCartRow(int productId);
  Future<void> upsertCartItem(int productId, int quantity);
  Future<void> removeCartItem(int productId);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> clearCart() => _db.clearCart();

  @override
  Future<List<CartTableData>> getCartRows() => _db.getCartItems();

  @override
  Future<ProductsTableData?> getProductForCartRow(int productId) =>
      _db.getProduct(productId);

  @override
  Future<void> removeCartItem(int productId) => _db.removeCartItem(productId);

  @override
  Future<void> upsertCartItem(int productId, int quantity) =>
      _db.upsertCartItem(productId, quantity);
}

