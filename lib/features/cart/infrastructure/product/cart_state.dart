import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/features/product/domain/entities/product.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class Empty extends CartState {}

class Loading extends CartState {}

class Loaded extends CartState {
  final List<Product> products;
  final String id;

  Loaded({@required this.id, @required this.products});

  @override
  List<Object> get props => [id, products];
}

class Error extends CartState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
