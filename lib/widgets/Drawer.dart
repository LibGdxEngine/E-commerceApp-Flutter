import 'package:flutter/material.dart';
import 'package:online_market/screens/orders_screen.dart';
import 'package:online_market/screens/products_overview_screen.dart';
import 'package:online_market/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("Online Shop"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: () {
              Navigator.pushNamed(context, ProductsOverView.id);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: () {
              Navigator.pushNamed(context, OrdersScreen.id);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings_input_composite),
            title: Text("Products"),
            onTap: () {
              Navigator.pushNamed(context, UserProductsScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
