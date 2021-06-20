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
