import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/api/exceptions.dart';
import 'package:flutter_demos/api/seller_services.dart';
import 'package:flutter_demos/bloc/seller_bloc/seller_events.dart';
import 'package:flutter_demos/bloc/seller_bloc/seller_states.dart';
import 'package:flutter_demos/model/seller_model.dart';

class SellerBloc extends Bloc<SellerEvents, SellerState> {
  //
  final SellerRepo sellerRepo;
  List<SellerModel> sellers;

  SellerBloc({this.sellerRepo}) : super(SellerInitState());

  @override
  Stream<SellerState> mapEventToState(SellerEvents event) async* {
    switch (event) {
      case SellerEvents.fetchSeller:
        yield SellerLoading();
        try {
          sellers = await sellerRepo.getSellerList();
          yield SellerLoaded(sellers: sellers);
        } on SocketException {
          yield SellerListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield SellerListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield SellerListError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          yield SellerListError(
            error: UnknownException('Unknown Error'),
          );
        }

        break;
    }
  }
}
