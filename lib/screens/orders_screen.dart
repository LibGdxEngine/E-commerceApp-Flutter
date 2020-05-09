import 'package:flutter/material.dart';
import 'package:online_market/providers/Orders.dart';
import 'package:online_market/widgets/Drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/OrderItem.dart' as oi;

class OrdersScreen extends StatelessWidget {
  static const id = '/orders';

  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) =>
                      oi.OrderItem.name(orderData.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
