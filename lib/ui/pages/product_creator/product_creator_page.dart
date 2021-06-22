import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_cart/features/file/infrastructure/file/bloc.dart'
    as file_bloc;
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
    return BlocListener<file_bloc.FileBloc, file_bloc.FileState>(
      listener: (context, state) {
        if (state is file_bloc.Loaded) {
          BlocProvider.of<ProductManagerBloc>(context).add(CreateProductEvent(
            name: _nameController.text,
            description: _descriptionController.text,
            photoUrl: state.urls[0],
            sku: _skuController.text,
          ));
          Navigator.pop(context);
        } else if (state is file_bloc.Loading) {
        } else if (state is file_bloc.Error) {}
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Crear Producto'),
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
                            labelText: 'Descripción',
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
                              BlocProvider.of<file_bloc.FileBloc>(context).add(
                                  file_bloc.SendFilesEvent(
                                      route: '/products/image',
                                      paths: [
                                    context
                                        .read<ProductManagerBloc>()
                                        .state
                                        .uploadImage
                                        .path
                                  ]));
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
                image: DecorationImage(image: image, fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.blueGrey)),
          );
        }),
      ),
    );
  }
}
