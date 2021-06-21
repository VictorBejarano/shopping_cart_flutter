import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

abstract class ProductManagerEvent extends Equatable {
  const ProductManagerEvent();

  @override
  List<Object> get props => [];
}

class SetImageToUploadEvent extends ProductManagerEvent {
  final File uploadImage;

  SetImageToUploadEvent({@required this.uploadImage});

  @override
  List<Object> get props => [uploadImage];
}

class CreateProductEvent extends ProductManagerEvent {
  final String name;
  final String sku;
  final String photoUrl;
  final String description;

  CreateProductEvent({
    @required this.name,
    @required this.sku,
    @required this.photoUrl,
    @required this.description,
  });

  @override
  List<Object> get props => [name, sku, photoUrl, description];
}
