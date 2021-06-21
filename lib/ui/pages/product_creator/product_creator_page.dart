import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_cart/features/product/data/models/product_model.dart';
import 'package:shopping_cart/features/product/infrastructure/product_manager/product_manager_bloc.dart';
import 'package:shopping_cart/features/product/infrastructure/product_manager/product_manager_event.dart';
import 'package:shopping_cart/features/product/infrastructure/product_manager/product_manager_state.dart';
import 'package:shopping_cart/ui/pages/image_select/image_select_page.dart';
import 'package:shopping_cart/ui/pages/widgets/widgets.dart';

class ProductCreatorPage extends StatefulWidget {
  static const String NAME = 'product_creator';
  ProductCreatorPage({Key key}) : super(key: key);

  @override
  _ProductCreatorPageState createState() => _ProductCreatorPageState();
}

class _ProductCreatorPageState extends State<ProductCreatorPage> {
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              imageSquare(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Error';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: _skuController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'SKU',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Error';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        maxLines: 8,
                        controller: _descriptionController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          labelText: 'TEST',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Error';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    StadiumButton(
                        text: 'Crear',
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            log('Es valido');
                            log(_descriptionController.text);
                            BlocProvider.of<ProductManagerBloc>(context)
                                .add(CreateProductEvent(
                              name: _nameController.text,
                              description: _descriptionController.text,
                              photoUrl: _descriptionController.text,
                              sku: _skuController.text,
                            ));
                          } else {
                            log('No es valido');
                          }
                        },
                        enabled: true)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Material imageSquare() {
    return Material(
      child: InkWell(
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
          return Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(image: image),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.blueGrey)),
          );
        }),
      ),
    );
  }
}
