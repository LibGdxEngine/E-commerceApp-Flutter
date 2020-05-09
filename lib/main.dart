import 'package:flutter/material.dart';
import 'package:online_market/providers/Auth.dart';
import 'package:online_market/providers/Cart.dart';
import 'package:online_market/providers/Orders.dart';
import 'package:online_market/providers/products.dart';
import 'package:online_market/screens/auth_screen.dart';
import 'package:online_market/screens/cart_screen.dart';
import 'package:online_market/screens/edit_product_screen.dart';
import 'package:online_market/screens/orders_screen.dart';
import 'package:online_market/screens/product_details_screen.dart';
import 'package:online_market/screens/products_overview_screen.dart';
import 'package:online_market/screens/splash_screen.dart';
import 'package:online_market/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductsOverView()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductsOverView.id: (ctx) => ProductsOverView(),
            ProductDetailScreen.id: (ctx) => ProductDetailScreen(),
            CartScreen.id: (ctx) => CartScreen(),
            OrdersScreen.id: (ctx) => OrdersScreen(),
            UserProductsScreen.id: (ctx) => UserProductsScreen(),
            EditProductScreen.id: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
