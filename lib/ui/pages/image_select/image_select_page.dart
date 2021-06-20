import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_cart/features/product/infrastructure/product_manager/bloc.dart';

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
      height: 200,
      color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Modal BottomSheet'),
            ElevatedButton(
              onPressed: () async {
                final pickedFile =
                    await picker.getImage(source: ImageSource.camera);
                BlocProvider.of<ProductManagerBloc>(context).add(
                    SetImageToUploadEvent(uploadImage: File(pickedFile.path)));
              },
              child: Text('Close BottomSheet'),
            )
          ],
        ),
      ),
    );
  }
}
