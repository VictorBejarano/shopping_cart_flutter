import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/injections/injections.dart' as di;
import 'package:shopping_cart/ui/pages/home/home_page.dart';
import 'package:shopping_cart/ui/routes.dart';

import 'features/cart/infrastructure/product/cart_bloc.dart';
import 'features/file/infrastructure/file/file_bloc.dart';
import 'features/product/infrastructure/product/bloc.dart';
import 'features/product/infrastructure/product_manager/product_manager_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => di.sl<ProductBloc>()),
                  BlocProvider(create: (_) => di.sl<ProductManagerBloc>()),
                  BlocProvider(create: (_) => di.sl<CartBloc>()),
                  BlocProvider(create: (_) => di.sl<FileBloc>()),
                ],
                child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Material App',
                    initialRoute: '/${HomePage.NAME}',
                    routes: routes));
          }

          return Container();
        });
  }
}
