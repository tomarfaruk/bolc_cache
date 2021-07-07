import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/api/exceptions.dart';
import 'package:flutter_demos/api/new_arrivals_services.dart';
import 'package:flutter_demos/model/seller_model.dart';
import 'package:flutter_demos/model/trading_products_model.dart';

import 'new_arrival_events.dart';
import 'new_arrival_states.dart';

class NewArrivalBloc extends Bloc<NewArrivalEvents, NewArrivalState> {
  //
  final NewArrivalsRepo newArrivalsRepo;
  List<TrendingProductsModel> arrivals;

  NewArrivalBloc({this.newArrivalsRepo}) : super(NewArrivalInitState());

  @override
  Stream<NewArrivalState> mapEventToState(NewArrivalEvents event) async* {
    switch (event) {
      case NewArrivalEvents.fetchData:
        yield NewArrivalLoading();
        try {
          arrivals = await newArrivalsRepo.getDataList();
          yield NewArrivalLoaded(sellers: arrivals);
        } on SocketException {
          yield NewArrivalListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield NewArrivalListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield NewArrivalListError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          yield NewArrivalListError(
            error: UnknownException('Unknown Error'),
          );
        }

        break;
    }
  }
}
