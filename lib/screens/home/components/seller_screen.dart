import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/bloc/seller_bloc/seller_bloc.dart';
import 'package:flutter_demos/bloc/seller_bloc/seller_events.dart';
import 'package:flutter_demos/bloc/seller_bloc/seller_states.dart';
import 'package:flutter_demos/model/seller_model.dart';
import 'package:flutter_demos/widgets/error.dart';
import 'package:flutter_demos/widgets/loading.dart';
import 'package:flutter_demos/widgets/trending_seller_item.dart';

class SellerScreen extends StatefulWidget {
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  void initState() {
    super.initState();

    _loadSeller();
  }

  _loadSeller() async {
    context.read<SellerBloc>().add(SellerEvents.fetchSeller);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerBloc, SellerState>(
        builder: (BuildContext context, SellerState state) {
      if (state is SellerListError) {
        final error = state.error;
        String message = '${error.message}\nTap to Retry.';
        return ErrorTxt(message: message, onTap: _loadSeller);
      }
      if (state is SellerLoaded) {
        List<SellerModel> sellers = state.sellers;
        return _list(sellers);
      }
      return Container(height: 180, child: Loading());
    });
  }

  Widget _list(List<SellerModel> sellers) {
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
              child: Text("Trending sellers",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: sellers.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) =>
                    TrendingSellerItem(sellerModel: sellers[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
