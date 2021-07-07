import 'package:equatable/equatable.dart';
import 'package:flutter_demos/model/trading_products_model.dart';

abstract class TrendingProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

class TrendingProductsInitState extends TrendingProductsState {}

class TrendingProductsLoading extends TrendingProductsState {}

class TrendingProductsLoaded extends TrendingProductsState {
  final List<TrendingProductsModel> tredingSellers;
  TrendingProductsLoaded({this.tredingSellers});
}

class TrendingProductsListError extends TrendingProductsState {
  final error;
  TrendingProductsListError({this.error});
}
