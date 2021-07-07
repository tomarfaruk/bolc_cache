import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter_demos/model/seller_model.dart';
import 'package:flutter_demos/utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ShopRepo {
  Future<List<SellerModel>> getList();
}

class ShopServices implements ShopRepo {
  //

  @override
  Future<List<SellerModel>> getList() async {
    String jsonStr = '';
    List<SellerModel> shopList = [];

    try {
      Response response = await http.get(Strings.shopUrl);
      jsonStr = response.body;

      shopList = sellerModelFromJson(jsonStr)[0];
      updateCash(jsonStr);
    } on SocketException {
      final isExist =
          await APICacheManager().isAPICacheKeyExist(Strings.shopKey);
      if (isExist) {
        var cashData = await APICacheManager().getCacheData(Strings.shopKey);
        shopList = sellerModelFromJson(cashData.syncData)[0];
      } else {
        rethrow;
      }
    }

    return shopList;
  }

  Future<void> updateCash(String jsonStr) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: Strings.shopKey,
      syncData: jsonStr,
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }
}
