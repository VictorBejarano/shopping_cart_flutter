import 'dart:io';

import 'package:meta/meta.dart';

class ProductManagerState {
  final File uploadImage;

  ProductManagerState({
    File uploadImage,
  }) : uploadImage = uploadImage;

  ProductManagerState copyWith({File uploadImage}) => ProductManagerState(
        uploadImage: uploadImage ?? this.uploadImage,
      );
}

class Error extends ProductManagerState {
  final String message;

  Error({@required this.message});
}
