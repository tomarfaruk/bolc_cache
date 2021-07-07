import 'package:equatable/equatable.dart';
import 'package:flutter_demos/model/seller_model.dart';

abstract class SellerState extends Equatable {
  @override
  List<Object> get props => [];
}

class SellerInitState extends SellerState {}

class SellerLoading extends SellerState {}

class SellerLoaded extends SellerState {
  final List<SellerModel> sellers;
  SellerLoaded({this.sellers});
}

class SellerListError extends SellerState {
  final error;
  SellerListError({this.error});
}
