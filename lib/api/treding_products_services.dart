import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter_demos/model/trading_products_model.dart';
import 'package:flutter_demos/utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class TredingProductRepo {
  Future<List<TrendingProductsModel>> getDataList();
}

class TredingProductServices implements TredingProductRepo {
  @override
  Future<List<TrendingProductsModel>> getDataList() async {
    String jsonStr = '';
    List<TrendingProductsModel> tredingSeller = [];

    try {
      Response response = await http.get(Strings.tredingUrl);
      jsonStr = response.body;

      tredingSeller = trendingProductsModelFromJson(jsonStr)[0];
      updateCash(jsonStr);
    } on SocketException {
      final isExist =
          await APICacheManager().isAPICacheKeyExist(Strings.tredingKey);
      if (isExist) {
        var cashData = await APICacheManager().getCacheData(Strings.tredingKey);
        tredingSeller = trendingProductsModelFromJson(cashData.syncData)[0];
      } else {
        rethrow;
      }
    }
    return tredingSeller;
  }

  Future<void> updateCash(String jsonStr) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: Strings.tredingKey,
      syncData: jsonStr,
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }
}
