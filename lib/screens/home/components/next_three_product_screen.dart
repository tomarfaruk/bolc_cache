import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/bloc/product_bloc/product_bloc.dart';
import 'package:flutter_demos/bloc/product_bloc/product_states.dart';
import 'package:flutter_demos/model/propduct_model.dart';
import 'package:flutter_demos/widgets/normal_card_item.dart';

class NextThreeProductScreen extends StatelessWidget {
  const NextThreeProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
      if (state is ProductLoaded) {
        List<ProductsModel> products = state.products;
        if (products.length <= 3) return Container();
        int last = 6;
        if (products.length < 6) last = products.length;
        products = products.getRange(3, last).toList();
        return _list(products);
      }
      return Container();
    });
  }

  Widget _list(List<ProductsModel> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
          products.length > 6 ? 3 : products.length,
          (index) => ProductCardItem(product: products[index + 3]),
        ),
      ],
    );
  }
}
