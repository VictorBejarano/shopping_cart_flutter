import 'package:meta/meta.dart';
import 'package:shopping_cart/core/error/exceptions.dart';
import 'package:shopping_cart/features/cart/data/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CartDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<void> createCart(
    String id,
    String status,
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
}
