import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:shopping_cart/core/error/failures.dart';
import 'package:shopping_cart/features/product/data/datasources/product_data_source.dart';
import 'package:shopping_cart/features/product/domain/entities/product.dart';
import 'package:shopping_cart/features/product/domain/repositories/product_repositoy.dart';

typedef _ListProductChooser = Stream<List<Product>> Function();

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl({@required this.productDataSource});

  @override
  Stream<Either<Failure, List<Product>>> getAllProducts() async* {
    yield* _getAllProducts(() {
      return productDataSource.getAllProducts();
    });
  }

  Stream<Either<Failure, List<Product>>> _getAllProducts(
      _ListProductChooser getAllProducts) async* {
    yield* getAllProducts().map<Either<Failure, List<Product>>>((products) {
      try {
        return Right(products);
      } on Exception {
        return Left(ServerFailure());
      }
    });
  }
}
