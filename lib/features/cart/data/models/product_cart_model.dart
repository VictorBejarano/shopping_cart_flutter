import 'package:meta/meta.dart';
import 'package:shopping_cart/features/cart/domain/entities/product_cart.dart';

class ProductCartModel extends ProductCart {
  ProductCartModel({
    @required int quantity,
    @required String productId,
    @required String cartId,
  }) : super(
          quantity: quantity,
          productId: productId,
          cartId: cartId,
        );

  factory ProductCartModel.fromJson(Map<String, dynamic> json) =>
      ProductCartModel(
        quantity: json['quantity'],
        productId: json['product_id'],
        cartId: json['cart_id'],
      );

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'product_id': productId,
        'cart_id': cartId,
      };
}
