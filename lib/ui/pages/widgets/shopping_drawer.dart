part of 'widgets.dart';

class ShoppingDrawer extends StatelessWidget {
  const ShoppingDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushNamed(context, '/${HomePage.NAME}');
            },
          ),
          ListTile(
            title: Text('Crear producto'),
            onTap: () {
              Navigator.pushNamed(context, '/${ProductCreatorPage.NAME}');
            },
          )
        ],
      ),
    );
  }
}
