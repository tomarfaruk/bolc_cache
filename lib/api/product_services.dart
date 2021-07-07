import 'dart:io';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter_demos/model/propduct_model.dart';
import 'package:flutter_demos/utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ProductRepo {
  Future<List<ProductsModel>> getList();
}

class ProductServices implements ProductRepo {
  //

  @override
  Future<List<ProductsModel>> getList() async {
    String jsonStr = '';
    List<ProductsModel> products = [];

    try {
      Response response = await http.get(Strings.productUrl);
      jsonStr = response.body;

      products = productsModelFromJson(jsonStr)[0];
      updateCash(jsonStr);
    } on SocketException {
      final isExist =
          await APICacheManager().isAPICacheKeyExist(Strings.productKey);
      if (isExist) {
        var cashData = await APICacheManager().getCacheData(Strings.productKey);
        products = productsModelFromJson(cashData.syncData)[0];
      } else {
        rethrow;
      }
    }
    return products;
  }

  Future<void> updateCash(String jsonStr) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: Strings.productKey,
      syncData: jsonStr,
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }
}
