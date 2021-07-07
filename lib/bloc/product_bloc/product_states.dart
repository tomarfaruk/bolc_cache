import 'package:equatable/equatable.dart';
import 'package:flutter_demos/model/propduct_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitState extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductsModel> products;
  ProductLoaded({this.products});
}

class ProductListError extends ProductState {
  final error;
  ProductListError({this.error});
}
