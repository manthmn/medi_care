import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rating,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final double rating;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [id, title, price, description, image, rating, updatedAt];
}

