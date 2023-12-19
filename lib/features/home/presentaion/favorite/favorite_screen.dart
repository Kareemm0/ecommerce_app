import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_cubit.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.favotites.isEmpty
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.5, vertical: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: "Search",
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.5,
                                vertical: 15,
                              ),
                              color: AppColor.fourthColor,
                              child: Row(
                                children: [
                                  Image.network(
                                    cubit.favotites[index].image!,
                                    width: 120,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        cubit.favotites[index].name!,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.mainColor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "${cubit.favotites[index].price!}\$"),
                                      MaterialButton(
                                        onPressed: () {
                                          cubit.addOrRemoveFromFavorites(
                                              productId: cubit
                                                  .favotites[index].id
                                                  .toString());
                                        },
                                        color: AppColor.mainColor,
                                        textColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: const Text(
                                          "Remove",
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            );
                          },
                          itemCount: cubit.favotites.length,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    ));
  }
}
