import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_seller_app/bloc/login/login_bloc.dart';
import 'package:flutter_seller_app/bloc/logout/logout_bloc.dart';
import 'package:flutter_seller_app/bloc/register/register_bloc.dart';
import 'package:flutter_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_seller_app/pages/auth/auth_page.dart';
import 'package:flutter_seller_app/pages/dashboard/seller_dashboard_page.dart';

import 'bloc/categories/categories_bloc.dart';
import 'bloc/products/products_bloc.dart';
import 'utils/light_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {   
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: light,
          home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!) {
                return const SellerDashboardPage();
              } else {
                return const AuthPage();
              }
            },
          )),
    );
  }
}
