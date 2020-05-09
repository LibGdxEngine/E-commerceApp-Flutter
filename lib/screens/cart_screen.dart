import 'package:flutter/material.dart';
import 'package:online_market/providers/Cart.dart';
import 'package:online_market/providers/Orders.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatefulWidget {
  static final String id = "CartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Chip(
                        label: Text(
                          '\$${cartData.cartTotal.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      FlatButton(
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Order Now',
                                style: TextStyle(
                                    color: Colors.purple, fontSize: 18),
                              ),
                        onPressed: (cartData.cartTotal <= 0 || _isLoading)
                            ? null
                            : () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await Provider.of<Orders>(context,
                                        listen: false)
                                    .addOrder(
                                  cartData.items.values.toList(),
                                  cartData.cartTotal,
                                );
                                setState(() {
                                  _isLoading = false;
                                });
                                cartData.clearCart();
                              },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.cartItemsCount,
              itemBuilder: (_, index) => ci.CartItem.name(
                cartData.items.keys.toList()[index],
                cartData.items.values.toList()[index].id,
                cartData.items.values.toList()[index].price,
                cartData.items.values.toList()[index].quantity,
                cartData.items.values.toList()[index].title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
