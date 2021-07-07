import 'package:flutter/material.dart';
import 'components/new_arrival_screen.dart';
import 'components/next_three_product_screen.dart';
import 'components/poroduct_screen.dart';
import 'components/remaining_product_screen.dart';
import 'components/seller_screen.dart';
import 'components/shop_screen.dart';
import 'components/treding_products_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: _body()),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        SellerScreen(),
        TredingProductsScreen(),
        ProductsScreen(),
        NewArrivalScreen(),
        NextThreeProductScreen(),
        ShopScreen(),
        ProductsScreen(),
        RemainingProductScreen(),
      ],
    );
  }
}
