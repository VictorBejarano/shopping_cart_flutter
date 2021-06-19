import 'package:meta/meta.dart';
import 'package:shopping_cart/core/error/exceptions.dart';
import 'package:shopping_cart/features/product/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductDataSource {
  /// Throws a [ServerException] for all error codes.
  Stream<List<ProductModel>> getAllProducts();
}

class ProductDataSourceImpl implements ProductDataSource {
  final FirebaseFirestore firebase;

  ProductDataSourceImpl({@required this.firebase});

  @override
  Stream<List<ProductModel>> getAllProducts() async* {
    yield* _getAllProductsFromFirebase();
  }

  Stream<List<ProductModel>> _getAllProductsFromFirebase() async* {
    yield* firebase.collection('products').orderBy('id').snapshots().map(
        (products) => products.docs
            .map((product) => ProductModel.fromJson(product.data())));
  }
}
