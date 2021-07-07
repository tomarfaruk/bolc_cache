import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demos/api/new_arrivals_services.dart';
import 'package:flutter_demos/api/product_services.dart';
import 'package:flutter_demos/api/seller_services.dart';
import 'package:flutter_demos/api/treding_products_services.dart';
import 'package:flutter_demos/bloc/treding_products_bloc/treding_seller_bloc.dart';
import 'api/shop_services.dart';
import 'bloc/new_arrival_bloc/new_arrival_bloc.dart';
import 'bloc/new_shop_bloc/shop_bloc.dart';
import 'bloc/product_bloc/product_bloc.dart';
import 'bloc/seller_bloc/seller_bloc.dart';
import 'screens/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc',
      debugShowCheckedModeBanner: true,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SellerBloc>(
            create: (context) => SellerBloc(sellerRepo: SellerServices()),
          ),
          BlocProvider<TrendingProductsBloc>(
            create: (context) =>
                TrendingProductsBloc(repo: TredingProductServices()),
          ),
          BlocProvider<NewArrivalBloc>(
            create: (context) =>
                NewArrivalBloc(newArrivalsRepo: NewArrivalsServices()),
          ),
          BlocProvider<ShopBloc>(
            create: (context) => ShopBloc(sellerRepo: ShopServices()),
          ),
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(productRepo: ProductServices()),
          ),
        ],
        child: HomePage(),
      ),
    );
    ;
  }
}
