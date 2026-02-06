import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:drift/drift.dart' show Value;

import '../../domain/entities/product.dart';
import '../../../../shared/data/local/app_database.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class RatingModel with _$RatingModel {
  const factory RatingModel({
    required double rate,
    required int count,
  }) = _RatingModel;

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required int id,
    required String title,
    required double price,
    required String description,
    required String image,
    required RatingModel rating,
    DateTime? updatedAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json).copyWith(updatedAt: DateTime.now());

  factory ProductModel.fromDb(ProductsTableData row) {
    return ProductModel(
      id: row.id,
      title: row.title,
      price: row.price,
      description: row.description,
      image: row.image,
      rating: RatingModel(rate: row.rating, count: 0),
      updatedAt: row.updatedAt,
    );
  }

  ProductsTableCompanion toCompanion() {
    return ProductsTableCompanion(
      id: Value(id),
      title: Value(title),
      price: Value(price),
      description: Value(description),
      image: Value(image),
      rating: Value(rating.rate),
      updatedAt: Value(updatedAt),
    );
  }

  Product toDomain() {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      image: image,
      rating: rating.rate,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
