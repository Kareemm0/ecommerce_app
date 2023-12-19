import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_cubit.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  static const routName = "HomeScreen";
  final pageController = PageController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                TextFormField(
                  onChanged: (input) {
                    cubit.fingBySearch(searchName: input);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Seatch",
                    suffixIcon: const Icon(Icons.clear),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.grey.withOpacity(0.3),
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                cubit.banners.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : SizedBox(
                        height: 125,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: pageController,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 12.5),
                              child: Image.network(
                                cubit.banners[index].imageUrl!,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                          itemCount: cubit.banners.length,
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: cubit.banners.length,
                    axisDirection: Axis.horizontal,
                    effect: const SlideEffect(
                      spacing: 8.0,
                      radius: 25.0,
                      dotWidth: 16,
                      dotHeight: 16,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: AppColor.secondColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                        color: AppColor.secondColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                cubit.categories.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 15,
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  cubit.categories[index].imageUrl!),
                            );
                          },
                          itemCount: cubit.categories.length,
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Products",
                      style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                        color: AppColor.secondColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                cubit.products.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.6,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 12),
                        itemBuilder: (context, index) {
                          return productItem(
                              cubit: cubit,
                              productModel: cubit.searchProduct.isEmpty
                                  ? cubit.products[index]
                                  : cubit.searchProduct[index]);
                        },
                        itemCount: cubit.searchProduct.isEmpty
                            ? cubit.products.length
                            : cubit.searchProduct.length,
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget productItem(
    {required ProductModel productModel, required HomeCubit cubit}) {
  return Stack(alignment: Alignment.bottomCenter, children: [
    Container(
      color: Colors.grey.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              productModel.image!,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            productModel.name!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Text(
                    "${productModel.price!}\$",
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${productModel.oldPrice!}\$",
                    style: const TextStyle(
                        fontSize: 12.5,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  )
                ],
              )),
              GestureDetector(
                child: Icon(
                  Icons.favorite,
                  size: 20,
                  color: cubit.favoritesId.contains(productModel.id.toString())
                      ? Colors.red
                      : Colors.grey,
                ),
                onTap: () {
                  cubit.addOrRemoveFromFavorites(
                      productId: productModel.id.toString());
                },
              )
            ],
          )
        ],
      ),
    ),
    CircleAvatar(
      backgroundColor: Colors.black,
      child: GestureDetector(
        onTap: () {
          cubit.addOrRemoveProductFromCart(id: productModel.id.toString());
        },
        child: Icon(Icons.shopping_cart,
            color: cubit.cartsId.contains(productModel.id.toString())
                ? Colors.red
                : Colors.white),
      ),
    )
  ]);
}
