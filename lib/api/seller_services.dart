import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter_demos/model/seller_model.dart';
import 'package:flutter_demos/utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class SellerRepo {
  Future<List<SellerModel>> getSellerList();
}

class SellerServices implements SellerRepo {
  //

  @override
  Future<List<SellerModel>> getSellerList() async {
    String jsonStr = '';
    List<SellerModel> sellers = [];

    try {
      Response response = await http.get(Strings.sellerUrl);
      jsonStr = response.body;

      sellers = sellerModelFromJson(jsonStr)[0];
      updateCash(jsonStr);
    } on SocketException {
      final isExist =
          await APICacheManager().isAPICacheKeyExist(Strings.sellerKey);
      if (isExist) {
        var cashData = await APICacheManager().getCacheData(Strings.sellerKey);
        sellers = sellerModelFromJson(cashData.syncData)[0];
      } else {
        rethrow;
      }
    }

    return sellers;
  }

  Future<void> updateCash(String jsonStr) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: Strings.sellerKey,
      syncData: jsonStr,
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }
}
