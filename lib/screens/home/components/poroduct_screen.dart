import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/bloc/product_bloc/product_bloc.dart';
import 'package:flutter_demos/bloc/product_bloc/product_events.dart';
import 'package:flutter_demos/bloc/product_bloc/product_states.dart';
import 'package:flutter_demos/model/propduct_model.dart';
import 'package:flutter_demos/widgets/error.dart';
import 'package:flutter_demos/widgets/loading.dart';
import 'package:flutter_demos/widgets/normal_card_item.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();

    _loadSeller();
  }

  _loadSeller() async {
    context.read<ProductBloc>().add(ProductEvents.fetchData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
      if (state is ProductListError) {
        final error = state.error;
        String message = '${error.message} Tap to Retry.';
        return Container(
            height: 180, child: ErrorTxt(message: message, onTap: _loadSeller));
      }
      if (state is ProductLoaded) {
        List<ProductsModel> products = state.products;
        return _list(products);
      }
      return Container(height: 180, child: Loading());
    });
  }

  Widget _list(List<ProductsModel> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
          products.length > 3 ? 3 : products.length,
          (index) => ProductCardItem(product: products[index]),
        ),
      ],
    );
  }
}
