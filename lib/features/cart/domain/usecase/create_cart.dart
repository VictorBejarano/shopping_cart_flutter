import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/core/usecases/usecases.dart';
import 'package:shopping_cart/features/cart/domain/repositories/cart_repositoy.dart';

class CreateCart implements UseCase<void, Params> {
  final CartRepository repository;

  CreateCart(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return repository.createCart(params.id, params.status);
  }
}

class Params extends Equatable {
  final String id;
  final String status;

  Params({
    this.id,
    this.status,
  });

  @override
  List<Object> get props => [
        id,
        status,
      ];
}
