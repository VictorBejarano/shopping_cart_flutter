import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/core/error/exceptions.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/features/cart/data/datasources/cart_data_source.dart';
import 'package:shopping_cart/features/cart/domain/entities/product_quantity.dart';
import 'package:shopping_cart/features/cart/domain/repositories/cart_repositoy.dart';

typedef _VoidChooser = Future<void> Function();

class CartRepositoryImpl implements CartRepository {
  final CartDataSource cartDataSource;

  CartRepositoryImpl({@required this.cartDataSource});

  @override
  Future<Either<Failure, void>> createCart(String id, String status) async {
    return await _createCart(() => cartDataSource.createCart(
          id,
          status,
        ));
  }

  Future<Either<Failure, void>> _createCart(
    _VoidChooser createCart,
  ) async {
    try {
      return Right(createCart());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> buyProducts(
      String id, List<ProductQuantity> products) async {
    // TODO: implement buyProducts
    return await _createCart(() => cartDataSource.buyProducts(
          id,
          products,
        ));
  }
}
