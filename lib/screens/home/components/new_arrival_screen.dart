import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/bloc/new_arrival_bloc/new_arrival_bloc.dart';
import 'package:flutter_demos/bloc/new_arrival_bloc/new_arrival_events.dart';
import 'package:flutter_demos/bloc/new_arrival_bloc/new_arrival_states.dart';
import 'package:flutter_demos/model/trading_products_model.dart';
import 'package:flutter_demos/widgets/error.dart';
import 'package:flutter_demos/widgets/loading.dart';
import 'package:flutter_demos/widgets/trending_product_item.dart';

class NewArrivalScreen extends StatefulWidget {
  @override
  _NewArrivalScreenState createState() => _NewArrivalScreenState();
}

class _NewArrivalScreenState extends State<NewArrivalScreen> {
  @override
  void initState() {
    super.initState();

    _loadSeller();
  }

  _loadSeller() async {
    context.read<NewArrivalBloc>().add(NewArrivalEvents.fetchData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewArrivalBloc, NewArrivalState>(
        builder: (BuildContext context, NewArrivalState state) {
      if (state is NewArrivalListError) {
        final error = state.error;
        String message = '${error.message}\nTap to Retry.';
        return ErrorTxt(message: message, onTap: _loadSeller);
      }
      if (state is NewArrivalLoaded) {
        List<TrendingProductsModel> products = state.sellers;
        return _list(products);
      }
      return Container(height: 180, child: Loading());
    });
  }

  Widget _list(List<TrendingProductsModel> products) {
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
              child: Text("New Arrivals",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) =>
                    TrendingProductItem(trendingProductsModel: products[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
