import 'package:ecommerce_app/core/cubit/app_cubit.dart';
import 'package:ecommerce_app/core/functions/shared_pref.dart';
import 'package:ecommerce_app/core/utils/app_constans.dart';
import 'package:ecommerce_app/core/utils/app_routes.dart';
import 'package:ecommerce_app/features/Auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/Auth/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/features/Auth/views/login/views/login_screen.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_cubit.dart';
import 'package:ecommerce_app/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.cacheInitialization();
  token = LocalStorage.getCacheData(key: 'token');
  currentPassword = LocalStorage.getCacheData(key: 'password');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getBannersData()
              ..getCategoriesData()
              ..getProducts()
              ..getFavotites()
              ..getCarts()),
      ],
      child: MaterialApp(
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: token != null ? const RootScreen() : LoginScreen(),
      ),
    );
  }
}
