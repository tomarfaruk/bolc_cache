import 'package:equatable/equatable.dart';
import 'package:flutter_demos/model/trading_products_model.dart';

abstract class NewArrivalState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewArrivalInitState extends NewArrivalState {}

class NewArrivalLoading extends NewArrivalState {}

class NewArrivalLoaded extends NewArrivalState {
  final List<TrendingProductsModel> sellers;
  NewArrivalLoaded({this.sellers});
}

class NewArrivalListError extends NewArrivalState {
  final error;
  NewArrivalListError({this.error});
}
