import 'package:meta/meta.dart';
import 'package:shopping_cart/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    @required String id,
    @required String name,
    @required String sku,
    @required String description,
  }) : super(
          id: id,
          name: name,
          sku: sku,
          description: description,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['nombre'],
        sku: json['sku'],
        description: json['descripcion'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': name,
        'sku': sku,
        'descripcion': description,
      };
}
