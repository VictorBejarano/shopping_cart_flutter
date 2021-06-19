import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/injections/injections.dart' as di;

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
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Material App',
              home: Scaffold(
                appBar: AppBar(
                  title: Text('Material App Bar'),
                ),
                body: Center(
                  child: Container(
                    child: Text('Hello World'),
                  ),
                ),
              ),
            );
          }

          // TODO: Crear vista cuando se esta cargando
          return Container();
        });
  }
}
