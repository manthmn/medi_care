import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class ProductsTable extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  RealColumn get price => real()();
  TextColumn get description => text()();
  TextColumn get image => text()();
  RealColumn get rating => real().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class CartTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer()();
  IntColumn get quantity => integer()();
}

class MetadataTable extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [
    ProductsTable,
    CartTable,
    MetadataTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Products
  Future<void> upsertProducts(List<ProductsTableCompanion> products) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(productsTable, products);
    });
  }

  Future<List<ProductsTableData>> getAllProducts() async {
    final rows = await select(productsTable).get();
    return rows;
  }

  Future<ProductsTableData?> getProduct(int id) {
    return (select(productsTable)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  // Cart
  Future<List<CartTableData>> getCartItems() => select(cartTable).get();

  Future<void> upsertCartItem(int productId, int quantity) async {
    final existing = await (select(cartTable)
          ..where((tbl) => tbl.productId.equals(productId)))
        .getSingleOrNull();

    if (existing == null) {
      await into(cartTable).insert(
        CartTableCompanion.insert(
          productId: productId,
          quantity: quantity,
        ),
      );
    } else {
      await update(cartTable).replace(
        existing.copyWith(quantity: quantity),
      );
    }
  }

  Future<void> removeCartItem(int productId) {
    return (delete(cartTable)..where((tbl) => tbl.productId.equals(productId)))
        .go();
  }

  Future<void> clearCart() => delete(cartTable).go();

  // Metadata (e.g. last synced timestamp)
  Future<void> setMetadata(String key, String value) async {
    await into(metadataTable).insertOnConflictUpdate(
      MetadataTableCompanion(
        key: Value(key),
        value: Value(value),
      ),
    );
  }

  Future<String?> getMetadata(String key) async {
    final row = await (select(metadataTable)
          ..where((tbl) => tbl.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'medicare.sqlite');
    return NativeDatabase(File(path));
  });
}

