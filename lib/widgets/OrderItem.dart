import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/Orders.dart' as oi;

class OrderItem extends StatefulWidget {
  final oi.OrderItem orderItem;

  OrderItem.name(@required this.orderItem);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(DateFormat('dd/mm/yyyy - hh:mm')
                .format(widget.orderItem.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          _expanded
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  height: min(widget.orderItem.amount * 20.0 + 10, 100),
                  child: ListView(
                    children: widget.orderItem.products
                        .map(
                          (product) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                product.title,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '${product.quantity}x ${product.price}',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
