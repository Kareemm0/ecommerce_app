import 'package:ecommerce_app/core/cubit/app_state.dart';
import 'package:ecommerce_app/features/home/presentaion/cart/cart_screen.dart';
import 'package:ecommerce_app/features/home/presentaion/category/categories_screen.dart';
import 'package:ecommerce_app/features/home/presentaion/favorite/favorite_screen.dart';
import 'package:ecommerce_app/features/home/presentaion/views/home_screen.dart';
import 'package:ecommerce_app/features/home/presentaion/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  int bottomNavigationCureentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  void changeBottomNavIndex({required int index}) {
    bottomNavigationCureentIndex = index;
    emit(ChangeBottomNavigationIndexState());
  }
}
