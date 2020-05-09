import 'package:flutter/material.dart';
import 'package:online_market/providers/Cart.dart';
import 'package:online_market/providers/product.dart';
import 'package:online_market/providers/products.dart';
import 'package:online_market/screens/cart_screen.dart';
import 'package:online_market/widgets/Badge.dart';
import 'package:online_market/widgets/Drawer.dart';
import 'package:online_market/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOption {
  OnlyFavourite,
  ShowAll,
}

class ProductsOverView extends StatefulWidget {
  static final String id = "ProductsOverView";

  @override
  _ProductsOverViewState createState() => _ProductsOverViewState();
}

class _ProductsOverViewState extends State<ProductsOverView> {
  final List<Product> loadedProducts = [];
  bool _isOnlyFavourite = false;
  var _isInit = true;
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Products>(context, listen: true)
          .fetchAndSetProducts()
          .then((_) {
        if (this.mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Shop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOption selection) {
              setState(() {
                if (selection == FilterOption.OnlyFavourite) {
                  _isOnlyFavourite = true;
                } else {
                  _isOnlyFavourite = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only Favourite'),
                  value: FilterOption.OnlyFavourite),
              PopupMenuItem(child: Text('ShowAll'), value: FilterOption.ShowAll)
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) {
              return Badge(
                child: child,
                value: cart.cartItemsCount.toString(),
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.id);
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_isOnlyFavourite),
    );
  }
}
