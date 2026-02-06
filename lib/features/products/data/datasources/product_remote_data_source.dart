import 'package:dio/dio.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final response = await _dio.get<List<dynamic>>('/products');
    final data = response.data ?? [];
    return data
        .map(
          (e) => ProductModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}

