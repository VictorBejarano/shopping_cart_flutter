import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/injections/injections.dart' as di;
import 'package:shopping_cart/ui/pages/home/home_page.dart';
import 'package:shopping_cart/ui/routes.dart';

import 'features/product/infrastructure/request/product_bloc.dart';

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
            // TODO: Crear vista cuando hay errores en la inicializacion
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => di.sl<ProductBloc>()),
                ],
                child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Material App',
                    initialRoute: '/${HomePage.NAME}',
                    routes: routes));
          }

          // TODO: Crear vista cuando se esta cargando
          return Container();
        });
  }
}
