import 'package:ecommerce_app/features/home/presentaion/views/home_screen.dart';
import 'package:ecommerce_app/features/splash/splsh_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routName: (context) => HomeScreen(),
  SplashScreen.routeName: (context) => const SplashScreen()
};
