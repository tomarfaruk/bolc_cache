import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/api/exceptions.dart';
import 'package:flutter_demos/api/treding_products_services.dart';
import 'package:flutter_demos/model/trading_products_model.dart';
import 'treding_seller_events.dart';
import 'treding_seller_states.dart';

class TrendingProductsBloc
    extends Bloc<TrendingProductsEvents, TrendingProductsState> {
  //
  final TredingProductRepo repo;
  List<TrendingProductsModel> tredingSellers;

  TrendingProductsBloc({this.repo}) : super(TrendingProductsInitState());

  @override
  Stream<TrendingProductsState> mapEventToState(
      TrendingProductsEvents event) async* {
    switch (event) {
      case TrendingProductsEvents.fetchData:
        yield TrendingProductsLoading();
        try {
          tredingSellers = await repo.getDataList();
          yield TrendingProductsLoaded(tredingSellers: tredingSellers);
        } on SocketException {
          yield TrendingProductsListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield TrendingProductsListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield TrendingProductsListError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          yield TrendingProductsListError(
            error: UnknownException('Unknown Error'),
          );
        }

        break;
    }
  }
}
