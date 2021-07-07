import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter_demos/model/trading_products_model.dart';
import 'package:flutter_demos/utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class NewArrivalsRepo {
  Future<List<TrendingProductsModel>> getDataList();
}

class NewArrivalsServices implements NewArrivalsRepo {
  @override
  Future<List<TrendingProductsModel>> getDataList() async {
    String jsonStr = '';
    List<TrendingProductsModel> arrivals = [];
    try {
      Response response = await http.get(Strings.newArrivalUrl);
      jsonStr = response.body;

      arrivals = trendingProductsModelFromJson(jsonStr)[0];
      updateCash(jsonStr);
    } on SocketException {
      final isExist =
          await APICacheManager().isAPICacheKeyExist(Strings.newArrivalKey);
      if (isExist) {
        var cashData =
            await APICacheManager().getCacheData(Strings.newArrivalKey);
        arrivals = trendingProductsModelFromJson(cashData.syncData)[0];
      } else
        rethrow;
    }
    return arrivals;
  }

  Future<void> updateCash(String jsonStr) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: Strings.newArrivalKey,
      syncData: jsonStr,
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }
}
