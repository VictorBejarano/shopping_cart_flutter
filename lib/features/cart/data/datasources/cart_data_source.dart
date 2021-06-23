import 'package:meta/meta.dart';
import 'package:shopping_cart/core/error/exceptions.dart';
import 'package:shopping_cart/features/cart/data/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/features/cart/data/models/product_cart_model.dart';
import 'package:shopping_cart/features/cart/domain/entities/product_cart.dart';
import 'package:shopping_cart/features/cart/domain/entities/product_quantity.dart';

abstract class CartDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<void> createCart(
    String id,
    String status,
  );
  Future<void> buyProducts(
    String id,
    List<ProductQuantity> products,
  );
}

class CartDataSourceImpl implements CartDataSource {
  final FirebaseFirestore firebase;

  CartDataSourceImpl({@required this.firebase});

  @override
  Future<void> createCart(
    String id,
    String status,
  ) async {
    try {
      final ref = firebase.collection('carts').doc(id);
      final cart = CartModel(id: id, status: status);
      return ref.set(cart.toJson());
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> buyProducts(String id, List<ProductQuantity> products) {
    try {
      var batch = firebase.batch();
      for (var prod in products) {
        DocumentReference document = firebase.collection('product_carts').doc();
        batch.set(
            document,
            ProductCartModel(
                    quantity: prod.quantity,
                    cartId: id,
                    productId: prod.product.id)
                .toJson());
      }

      return batch.commit();
    } catch (e) {
      throw ServerException();
    }
  }
}
