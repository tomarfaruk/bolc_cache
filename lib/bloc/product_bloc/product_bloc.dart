import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/api/exceptions.dart';
import 'package:flutter_demos/api/product_services.dart';
import 'package:flutter_demos/model/propduct_model.dart';

import 'product_events.dart';
import 'product_states.dart';

class ProductBloc extends Bloc<ProductEvents, ProductState> {
  //
  final ProductRepo productRepo;
  List<ProductsModel> products;

  ProductBloc({this.productRepo}) : super(ProductInitState());

  @override
  Stream<ProductState> mapEventToState(ProductEvents event) async* {
    switch (event) {
      case ProductEvents.fetchData:
        yield ProductLoading();
        try {
          products = await productRepo.getList();
          yield ProductLoaded(products: products);
        } on SocketException {
          yield ProductListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield ProductListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield ProductListError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          yield ProductListError(
            error: UnknownException('Unknown Error'),
          );
        }

        break;
    }
  }
}
