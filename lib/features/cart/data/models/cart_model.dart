import 'package:meta/meta.dart';
import 'package:shopping_cart/features/cart/domain/entities/cart.dart';

class CartModel extends Cart {
  CartModel({
    @required String id,
    @required String status,
  }) : super(
          id: id,
          status: status,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['id'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
      };
}
