import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/model/trading_products_model.dart';

import 'loading.dart';

class TrendingProductItem extends StatelessWidget {
  TrendingProductsModel trendingProductsModel;

  TrendingProductItem({Key key, this.trendingProductsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Container(
        width: 100,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: trendingProductsModel?.productImage ??
                      'https://picsum.photos/id/870/100/100',
                  placeholder: (context, url) => ImageLoading(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Container(
              height: 35,
              padding: EdgeInsets.all(3),
              child: Column(
                children: [
                  Text(
                    trendingProductsModel.productName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "price: BDT ${trendingProductsModel.unitPrice}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
