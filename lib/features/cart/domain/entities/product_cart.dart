import 'package:equatable/equatable.dart';

class ProductCart extends Equatable {
  final int quantity;
  final String productId;
  final String cartId;

  ProductCart({
    this.quantity,
    this.productId,
    this.cartId,
  });

  @override
  List<Object> get props => [
        quantity,
        productId,
        cartId,
      ];
}
