part of 'widgets.dart';

class ShoppingDrawer extends StatelessWidget {
  final int quantity;
  const ShoppingDrawer({Key key, @required this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/wallpaper.jpeg')),
              color: Colors.blue,
            ),
            child: Text('Shopping Cart', style: TextStyle(color: Colors.white)),
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
          ),
          ListTile(
            title: Badge(
                alignment: Alignment.centerLeft,
                position: BadgePosition.topStart(start: 110),
                badgeContent: Text(
                    (quantity < 100) ? quantity.toString() : '+99',
                    style: TextStyle(color: Colors.white)),
                child: Text('Carrito de compras')),
            onTap: () {
              Navigator.pushNamed(context, '/${CartPage.NAME}');
            },
          ),
        ],
      ),
    );
  }
}
