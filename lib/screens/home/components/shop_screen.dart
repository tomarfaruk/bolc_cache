import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/bloc/new_shop_bloc/shop_bloc.dart';
import 'package:flutter_demos/bloc/new_shop_bloc/shop_events.dart';
import 'package:flutter_demos/bloc/new_shop_bloc/shop_states.dart';
import 'package:flutter_demos/model/seller_model.dart';
import 'package:flutter_demos/widgets/error.dart';
import 'package:flutter_demos/widgets/loading.dart';
import 'package:flutter_demos/widgets/trending_seller_item.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    super.initState();

    _loadSeller();
  }

  _loadSeller() async {
    context.read<ShopBloc>().add(ShopEvents.fetchData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (BuildContext context, ShopState state) {
          if (state is ShopListError) {
            final error = state.error;
            String message = '${error.message} Tap to Retry.';
            return ErrorTxt(message: message, onTap: _loadSeller);
          }
          if (state is ShopLoaded) {
            List<SellerModel> shopList = state.shopList;
            return _list(shopList);
          }
          return Container(height: 180, child: Loading());
        },
      ),
    );
  }

  Widget _list(List<SellerModel> shopList) {
    return Card(
      elevation: 10,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text("New Shops",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: shopList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) =>
                    TrendingSellerItem(sellerModel: shopList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
