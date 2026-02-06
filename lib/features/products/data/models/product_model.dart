import 'package:drift/drift.dart';

import '../../domain/entities/product.dart';
import '../../../../shared/data/local/app_database.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.image,
    required super.rating,
    required super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final ratingJson = json['rating'] as Map<String, dynamic>?;
    return ProductModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      image: json['image'] as String,
      rating: ratingJson != null ? (ratingJson['rate'] as num).toDouble() : 0,
      updatedAt: DateTime.now(),
    );
  }

  factory ProductModel.fromDb(ProductsTableData row) {
    return ProductModel(
      id: row.id,
      title: row.title,
      price: row.price,
      description: row.description,
      image: row.image,
      rating: row.rating,
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
      rating: Value(rating),
      updatedAt: Value(updatedAt),
    );
  }
}

