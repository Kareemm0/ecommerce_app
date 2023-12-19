import 'package:ecommerce_app/core/cubit/app_cubit.dart';
import 'package:ecommerce_app/core/cubit/app_state.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<AppCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              AppImages.logo,
              height: 100,
              width: 100,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomNavigationCureentIndex,
              onTap: (index) {
                cubit.changeBottomNavIndex(index: index);
              },
              elevation: 0.0,
              selectedItemColor: AppColor.mainColor,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: "Categories",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                )
              ]),
          body: cubit.screens[cubit.bottomNavigationCureentIndex],
        );
      },
    );
  }
}
