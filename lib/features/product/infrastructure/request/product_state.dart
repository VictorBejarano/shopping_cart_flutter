import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/features/product/domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class Empty extends ProductState {}

class Loading extends ProductState {}

class Loaded extends ProductState {
  final List<Product> products;

  Loaded({@required this.products});

  @override
  List<Object> get props => [products];
}

class Error extends ProductState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
