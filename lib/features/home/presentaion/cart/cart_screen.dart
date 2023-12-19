import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_cubit.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              children: [
                Expanded(
                    child: cubit.carts.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 12.5,
                              );
                            },
                            itemCount: cubit.carts.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: AppColor.fourthColor,
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      cubit.carts[index].image!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(width: 12.5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.carts[index].name!,
                                            style: const TextStyle(
                                              color: AppColor.mainColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "${cubit.carts[index].price}"),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              if (cubit.carts[index].price !=
                                                  cubit.carts[index].oldPrice)
                                                Text(
                                                  "${cubit.carts[index].oldPrice}",
                                                  style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              OutlinedButton(
                                                  onPressed: () {
                                                    cubit
                                                        .addOrRemoveFromFavorites(
                                                            productId: cubit
                                                                .carts[index].id
                                                                .toString());
                                                  },
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: cubit.favoritesId
                                                            .contains(cubit
                                                                .carts[index].id
                                                                .toString())
                                                        ? Colors.red
                                                        : Colors.grey,
                                                  )),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  cubit
                                                      .addOrRemoveProductFromCart(
                                                          id: cubit
                                                              .carts[index].id
                                                              .toString());
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              "Loading....",
                              style: TextStyle(
                                color: AppColor.mainColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                Container(
                  child: Text(
                    "Total Price : ${cubit.totalPrice}\$",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColor.mainColor,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
