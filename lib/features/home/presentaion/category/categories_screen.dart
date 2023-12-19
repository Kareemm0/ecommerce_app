import 'package:ecommerce_app/features/home/data/models/category_model.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoriesModel> categoryData =
        BlocProvider.of<HomeCubit>(context).categories;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Expanded(
                      child: Image.network(
                    categoryData[index].imageUrl!,
                    fit: BoxFit.fill,
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(categoryData[index].title!)
                ],
              ),
            );
          },
          itemCount: categoryData.length,
        ),
      ),
    );
  }
}
