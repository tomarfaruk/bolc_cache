import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/bloc/treding_products_bloc/treding_seller_bloc.dart';
import 'package:flutter_demos/bloc/treding_products_bloc/treding_seller_events.dart';
import 'package:flutter_demos/bloc/treding_products_bloc/treding_seller_states.dart';
import 'package:flutter_demos/model/trading_products_model.dart';

import 'package:flutter_demos/widgets/error.dart';

import 'package:flutter_demos/widgets/loading.dart';
import 'package:flutter_demos/widgets/trending_product_item.dart';

class TredingProductsScreen extends StatefulWidget {
  @override
  _TredingProductsScreenState createState() => _TredingProductsScreenState();
}

class _TredingProductsScreenState extends State<TredingProductsScreen> {
  @override
  void initState() {
    super.initState();

    _loadSeller();
  }

  _loadSeller() async {
    context.read<TrendingProductsBloc>().add(TrendingProductsEvents.fetchData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingProductsBloc, TrendingProductsState>(
        builder: (BuildContext context, TrendingProductsState state) {
      if (state is TrendingProductsListError) {
        final error = state.error;
        String message = '${error.message} Tap to Retry.';
        return ErrorTxt(message: message, onTap: _loadSeller);
      }
      if (state is TrendingProductsLoaded) {
        List<TrendingProductsModel> tredingSellers = state.tredingSellers;
        return _list(tredingSellers);
      }
      return Container(height: 180, child: Loading());
    });
  }

  Widget _list(List<TrendingProductsModel> trendingProducts) {
    return Card(
      elevation: 10,
      child: Container(
        height: 180,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text("Trending products",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: trendingProducts?.length ?? 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => TrendingProductItem(
                    trendingProductsModel: trendingProducts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
