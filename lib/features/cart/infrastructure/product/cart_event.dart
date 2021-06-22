import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/features/product/domain/entities/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CreateCartEvent extends CartEvent {}

class AddProductToCartEvent extends CartEvent {
  final Product product;

  AddProductToCartEvent({
    @required this.product,
  });

  @override
  List<Object> get props => [product];
}
