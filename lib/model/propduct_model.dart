// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

List<List<ProductsModel>> productsModelFromJson(String str) =>
    List<List<ProductsModel>>.from(json.decode(str).map((x) =>
        List<ProductsModel>.from(x.map((x) => ProductsModel.fromJson(x)))));

String productsModelToJson(List<List<ProductsModel>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class ProductsModel {
  ProductsModel({
    this.storyTime,
    this.story,
    this.storyType,
    this.storyImage,
    this.promoImage,
    this.orderQty,
    this.lastAddToCart,
    this.availableStock,
    this.myId,
    this.ezShopName,
    this.companyName,
    this.companyLogo,
    this.companyEmail,
    this.currencyCode,
    this.unitPrice,
    this.discountAmount,
    this.discountPercent,
    this.iMyId,
    this.shopName,
    this.shopLogo,
    this.shopLink,
    this.friendlyTimeDiff,
    this.slNo,
  });

  DateTime storyTime;
  String story;
  String storyType;
  String storyImage;
  String promoImage;
  int orderQty;
  DateTime lastAddToCart;
  int availableStock;
  String myId;
  String ezShopName;
  String companyName;
  String companyLogo;
  String companyEmail;
  String currencyCode;
  double unitPrice;
  int discountAmount;
  int discountPercent;
  String iMyId;
  String shopName;
  String shopLogo;
  String shopLink;
  String friendlyTimeDiff;
  String slNo;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        storyTime: DateTime.parse(json["storyTime"]),
        story: json["story"],
        storyType: json["storyType"],
        storyImage: json["storyImage"],
        promoImage: json["promoImage"],
        orderQty: json["orderQty"],
        lastAddToCart: DateTime.parse(json["lastAddToCart"]),
        availableStock: json["availableStock"],
        myId: json["myId"],
        ezShopName: json["ezShopName"],
        companyName: json["companyName"],
        companyLogo: json["companyLogo"],
        companyEmail: json["companyEmail"],
        currencyCode: json["currencyCode"],
        unitPrice: double.parse('${json["unitPrice"] ?? 0.0}'),
        discountAmount: json["discountAmount"],
        discountPercent: json["discountPercent"],
        iMyId: json["iMyID"],
        shopName: json["shopName"],
        shopLogo: json["shopLogo"],
        shopLink: json["shopLink"],
        friendlyTimeDiff: json["friendlyTimeDiff"],
        slNo: json["slNo"],
      );

  Map<String, dynamic> toJson() => {
        "storyTime": storyTime.toIso8601String(),
        "story": story,
        "storyType": storyType,
        "storyImage": storyImage,
        "promoImage": promoImage,
        "orderQty": orderQty,
        "lastAddToCart": lastAddToCart.toIso8601String(),
        "availableStock": availableStock,
        "myId": myId,
        "ezShopName": ezShopName,
        "companyName": companyName,
        "companyLogo": companyLogo,
        "companyEmail": companyEmail,
        "currencyCode": currencyCode,
        "unitPrice": unitPrice,
        "discountAmount": discountAmount,
        "discountPercent": discountPercent,
        "iMyID": iMyId,
        "shopName": shopName,
        "shopLogo": shopLogo,
        "shopLink": shopLink,
        "friendlyTimeDiff": friendlyTimeDiff,
        "slNo": slNo,
      };
}
