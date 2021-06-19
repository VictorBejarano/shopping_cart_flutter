import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String sku;
  final String description;

  Product({
    this.id,
    this.name,
    this.sku,
    this.description,
  });

  @override
  List<Object> get props => [
        id,
        name,
        sku,
        description,
      ];
}
