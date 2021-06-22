import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final String id;
  final String status;

  Cart({
    this.id,
    this.status,
  });

  @override
  List<Object> get props => [
        id,
        status,
      ];
}
