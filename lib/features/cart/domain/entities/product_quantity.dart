import 'package:equatable/equatable.dart';
import 'package:shopping_cart/features/product/domain/entities/product.dart';

class ProductQuantity extends Equatable {
  final int quantity;
  final Product product;

  ProductQuantity({
    this.quantity,
    this.product,
  });

  @override
  List<Object> get props => [
        quantity,
        product,
      ];
}
