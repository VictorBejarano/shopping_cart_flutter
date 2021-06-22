import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_cart/features/product/infrastructure/product_manager/bloc.dart';
import 'package:shopping_cart/ui/pages/widgets/widgets.dart';

class ImageSelectPage extends StatefulWidget {
  const ImageSelectPage({Key key}) : super(key: key);

  @override
  _ImageSelectPageState createState() => _ImageSelectPageState();
}

class _ImageSelectPageState extends State<ImageSelectPage> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              StadiumButton(
                enabled: true,
                onPressed: () async {
                  final pickedFile = await picker.getImage(
                    source: ImageSource.gallery,
                    maxWidth: 600.0,
                  );
                  BlocProvider.of<ProductManagerBloc>(context).add(
                      SetImageToUploadEvent(
                          uploadImage: File(pickedFile.path)));
                },
                text: 'Subir imagen',
              ),
              SizedBox(
                height: 10,
              ),
              (!kIsWeb)
                  ? StadiumButton(
                      enabled: true,
                      onPressed: () async {
                        final pickedFile = await picker.getImage(
                          source: ImageSource.camera,
                          maxWidth: 600.0,
                        );
                        BlocProvider.of<ProductManagerBloc>(context).add(
                            SetImageToUploadEvent(
                                uploadImage: File(pickedFile.path)));
                      },
                      text: 'Tomar foto',
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
