import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_cart/features/product/infrastructure/product_manager/product_manager_bloc.dart';
import 'package:shopping_cart/features/product/infrastructure/product_manager/product_manager_state.dart';
import 'package:shopping_cart/ui/pages/image_select/image_select_page.dart';

class ProductCreatorPage extends StatefulWidget {
  static const String NAME = 'product_creator';
  ProductCreatorPage({Key key}) : super(key: key);

  @override
  _ProductCreatorPageState createState() => _ProductCreatorPageState();
}

class _ProductCreatorPageState extends State<ProductCreatorPage> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        children: [
          Material(
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return ImageSelectPage();
                  },
                );
              },
              child: BlocBuilder<ProductManagerBloc, ProductManagerState>(
                  builder: (BuildContext context, ProductManagerState state) {
                final image = (state.uploadImage == null)
                    ? AssetImage('assets/image/null.jpg')
                    : (kIsWeb)
                        ? NetworkImage(state.uploadImage.path)
                        : FileImage(state.uploadImage);
                return CircleAvatar(
                  maxRadius: 100,
                  backgroundImage: image,
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
