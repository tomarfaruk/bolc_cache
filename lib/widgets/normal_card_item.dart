import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/model/propduct_model.dart';
import 'loading.dart';

class ProductCardItem extends StatelessWidget {
  ProductCardItem({Key key, this.product}) : super(key: key);

  ProductsModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Container(
        width: double.infinity,
        height: 300,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(),
            _buildTitle(),
            SizedBox(height: 4),
            _buildImage(),
            SizedBox(height: 8),
            _buildFooter()
          ],
        ),
      ),
    );
  }

  Row _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconText(
            Icon(Icons.shopping_bag_outlined), 'BDT: ${product?.unitPrice}'),
        _buildIconText(
            Icon(Icons.menu), '${product?.availableStock} Available Stock'),
        _buildIconText(
            Icon(Icons.shopping_cart_outlined), '${product?.orderQty} Order'),
      ],
    );
  }

  Row _buildIconText(Widget icon, String text) {
    return Row(
      children: [
        icon,
        Text(
          text,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Container _buildImage() {
    return Container(
      height: 150,
      margin: EdgeInsets.only(left: 14, right: 14),
      child: CachedNetworkImage(
        imageUrl: product?.storyImage ?? 'https://picsum.photos/id/870/100/100',
        placeholder: (context, url) => ImageLoading(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Container _buildTitle() {
    return Container(
      margin: EdgeInsets.only(left: 14, right: 14),
      child: Text(
        product?.story ?? "",
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          height: 1.4,
          letterSpacing: 1.2,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(
            imageUrl:
                product?.companyLogo ?? 'https://picsum.photos/id/870/100/100',
            placeholder: (context, url) => ImageLoading(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: 30,
            width: 30,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                product?.companyName ?? 'Name',
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
              SizedBox(height: 4),
              Text(
                product?.friendlyTimeDiff ?? 'time',
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
