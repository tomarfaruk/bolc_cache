class Strings {
  static const String baseUrl = 'https://bd.ezassist.me/ws/mpFeed';

  static const String newArrivalUrl =
      baseUrl + '?instanceName=bd.ezassist.me&opt=newArrivals';

  static const String productUrl =
      baseUrl + '?instanceName=bd.ezassist.me&opt=stories';

  static const String sellerUrl =
      baseUrl + '?instanceName=bd.ezassist.me&opt=trending_seller';

  static const String shopUrl =
      baseUrl + '?instanceName=bd.ezassist.me&opt=newShops';

  static const String tredingUrl =
      baseUrl + '?instanceName=bd.ezassist.me&opt=trendingProducts';

  static const String productKey = 'productKey';
  static const String newArrivalKey = 'arrivalKey';
  static const String sellerKey = 'sellerKey';
  static const String shopKey = 'shopKey';
  static const String tredingKey = 'tredingKey';
}
