// To parse this JSON data, do
//
//     final trendingProductsModel = trendingProductsModelFromJson(jsonString);

import 'dart:convert';

List<List<TrendingProductsModel>> trendingProductsModelFromJson(String str) =>
    List<List<TrendingProductsModel>>.from(json.decode(str).map((x) =>
        List<TrendingProductsModel>.from(
            x.map((x) => TrendingProductsModel.fromJson(x)))));

String trendingProductsModelToJson(List<List<TrendingProductsModel>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class TrendingProductsModel {
  TrendingProductsModel({
    this.slNo,
    this.productName,
    this.shortDetails,
    this.productDescription,
    this.availableStock,
    this.orderQty,
    this.salesQty,
    this.orderAmount,
    this.salesAmount,
    this.discountPercent,
    this.discountAmount,
    this.unitPrice,
    this.productImage,
    this.sellerName,
    this.sellerProfilePhoto,
    this.sellerCoverPhoto,
    this.ezShopName,
    this.defaultPushScore,
    this.myProductVarId,
  });

  String slNo;
  String productName;
  String shortDetails;
  String productDescription;
  int availableStock;
  int orderQty;
  int salesQty;
  double orderAmount;
  double salesAmount;
  double discountPercent;
  double discountAmount;
  double unitPrice;
  String productImage;
  String sellerName;
  String sellerProfilePhoto;
  String sellerCoverPhoto;
  String ezShopName;
  int defaultPushScore;
  String myProductVarId;

  factory TrendingProductsModel.fromJson(Map<String, dynamic> json) =>
      TrendingProductsModel(
        slNo: json["slNo"],
        productName: json["productName"],
        shortDetails: json["shortDetails"],
        productDescription: json["productDescription"],
        availableStock: json["availableStock"],
        orderQty: json["orderQty"],
        salesQty: json["salesQty"],
        orderAmount: double.parse('${json["orderAmount"] ?? 0.0}'),
        salesAmount: double.parse('${json["salesAmount"] ?? 0.0}'),
        discountPercent: double.parse('${json["discountPercent"] ?? 0.0}'),
        discountAmount: double.parse('${json["discountAmount"] ?? 0.0}'),
        unitPrice: double.parse('${json["unitPrice"] ?? 0.0}'),
        productImage: json["productImage"],
        sellerName: json["sellerName"],
        sellerProfilePhoto: json["sellerProfilePhoto"],
        sellerCoverPhoto: json["sellerCoverPhoto"],
        ezShopName: json["ezShopName"],
        // defaultPushScore: json["defaultPushScore"],
        myProductVarId: json["myProductVarId"],
      );

  Map<String, dynamic> toJson() => {
        "slNo": slNo,
        "productName": productName,
        "shortDetails": shortDetails,
        "productDescription": productDescription,
        "availableStock": availableStock,
        "orderQty": orderQty,
        "salesQty": salesQty,
        "orderAmount": orderAmount,
        "salesAmount": salesAmount,
        "discountPercent": discountPercent,
        "discountAmount": discountAmount,
        "unitPrice": unitPrice,
        "productImage": productImage,
        "sellerName": sellerName,
        "sellerProfilePhoto": sellerProfilePhoto,
        "sellerCoverPhoto": sellerCoverPhoto,
        "ezShopName": ezShopName,
        "defaultPushScore": defaultPushScore,
        "myProductVarId": myProductVarId,
      };
}
