import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/api/exceptions.dart';
import 'package:flutter_demos/api/seller_services.dart';
import 'package:flutter_demos/api/shop_services.dart';
import 'shop_events.dart';
import 'package:flutter_demos/model/seller_model.dart';

import 'shop_states.dart';

class ShopBloc extends Bloc<ShopEvents, ShopState> {
  final ShopRepo sellerRepo;
  List<SellerModel> shopList;

  ShopBloc({this.sellerRepo}) : super(ShopInitState());

  @override
  Stream<ShopState> mapEventToState(ShopEvents event) async* {
    switch (event) {
      case ShopEvents.fetchData:
        yield ShopLoading();
        try {
          shopList = await sellerRepo.getList();
          yield ShopLoaded(shopList: shopList);
        } on SocketException {
          yield ShopListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield ShopListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield ShopListError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          yield ShopListError(
            error: UnknownException('Unknown Error'),
          );
        }

        break;
    }
  }
}
