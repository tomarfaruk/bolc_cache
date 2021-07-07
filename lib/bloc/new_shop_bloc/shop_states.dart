import 'package:equatable/equatable.dart';
import 'package:flutter_demos/model/seller_model.dart';

abstract class ShopState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShopInitState extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<SellerModel> shopList;
  ShopLoaded({this.shopList});
}

class ShopListError extends ShopState {
  final error;
  ShopListError({this.error});
}
