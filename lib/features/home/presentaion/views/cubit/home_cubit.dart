import 'dart:convert';
import 'package:ecommerce_app/core/functions/shared_pref.dart';
import 'package:ecommerce_app/core/utils/app_constans.dart';
import 'package:ecommerce_app/features/Auth/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/features/home/data/models/banners_model.dart';
import 'package:ecommerce_app/features/home/data/models/category_model.dart';
import 'package:ecommerce_app/features/home/data/models/product_model.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  List<BannersModel> banners = [];
  void getBannersData() async {
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/banners"),
    );
    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']) {
        banners.add(BannersModel.fromJson(json: item));
      }
      emit(GetBannersSuccessState());
    } else {
      emit(GetBannersFailureState());
    }
  }

  List<CategoriesModel> categories = [];
  void getCategoriesData() async {
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/categories"),
        headers: {'lang': "en"});

    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        categories.add(CategoriesModel.fromJson(json: item));
      }
      emit(GetCategoriesSuccessState());
    } else {
      emit(GetCategoriesFailureState());
    }
  }

  List<ProductModel> products = [];
  void getProducts() async {
    Response response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/home'),
        headers: {'Authorization': token!, 'lang': 'en'});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['products']) {
        products.add(ProductModel.fromJsom(json: item));
      }
      emit(GetProductsSuccessState());
    } else {
      emit(GetProductsFailureState());
    }
  }

  List<ProductModel> searchProduct = [];

  void fingBySearch({required String searchName}) {
    searchProduct = products
        .where((element) =>
            element.name!.toLowerCase().startsWith(searchName.toLowerCase()))
        .toList();
    emit(SearchProductsSucessState());
  }

  List<ProductModel> favotites = [];

  Set<String> favoritesId = {};
  Future<void> getFavotites() async {
    favotites.clear();
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers: {'lang': 'en', 'Authorization': token!});
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        favotites.add(ProductModel.fromJsom(json: item['product']));
        favoritesId.add(item['product']['id'].toString());
      }
      emit(GetFavotitesSucessState());
    } else {
      emit(GetFavotitesFailureState());
    }
  }

  void addOrRemoveFromFavorites({required String productId}) async {
    Response response = await http.post(
        Uri.parse(
          "https://student.valuxapps.com/api/favorites",
        ),
        headers: {
          'lan': 'en',
          'Authorization': token!,
        },
        body: {
          'product_id': productId
        });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      if (favoritesId.contains(productId) == true) {
        favoritesId.remove(productId);
      } else {
        favoritesId.add(productId);
      }
      await getFavotites();
      emit(AddOrRemoveItemFromFavoriteSuccessState());
    } else {
      emit(AddOrRemoveItemFromFavoriteFailureState());
    }
  }

  List<ProductModel> carts = [];
  Set<String> cartsId = {};
  int totalPrice = 0;
  Future<void> getCarts() async {
    carts.clear();
    Response response = await http
        .get(Uri.parse("https://student.valuxapps.com/api/carts"), headers: {
      'Authorization': token!,
      'lang': 'en',
    });
    var respponseBody = jsonDecode(response.body);
    if (respponseBody['status'] == true) {
      for (var item in respponseBody['data']['cart_items']) {
        cartsId.add(item['product']['id'].toString());
        carts.add(
          ProductModel.fromJsom(
            json: item['product'],
          ),
        );
      }
      totalPrice = respponseBody['data']['total'];
      emit(GetCartsSuccessState());
    } else {
      emit(GetCartsFailureState());
    }
  }

  void addOrRemoveProductFromCart({required String id}) async {
    Response response = await http
        .post(Uri.parse("https://student.valuxapps.com/api/carts"), headers: {
      'Authorization': token!,
      'lang': 'en',
    }, body: {
      " product_id": id,
    });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      cartsId.contains(id) == true ? cartsId.remove(id) : cartsId.add(id);
      await getCarts();
      emit(AddOrRemoveItemFromCartSuccessState());
    } else {
      emit(AddOrRemoveItemFromCartFailureState());
    }
  }

  void changePassword(
      {required String userCurrentPassword,
      required String newPassword}) async {
    emit(ChangePasswordLoadingState());
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/change-password"),
        body: {
          'current_password': userCurrentPassword,
          'new_password': newPassword,
        },
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
          'Authorization': token!
        });
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['status'] == true) {
        await LocalStorage.insertToCache(key: 'password', value: newPassword);
        currentPassword = LocalStorage.getCacheData(key: 'password');
        emit(ChangePasswordSuccessState());
      } else {
        emit(ChangePasswordtFailureState(message: responseBody['message']));
      }
    } else {
      emit(ChangePasswordtFailureState(message: "Something Went Wrong"));
    }
  }

  void updateUserData(
      {required String name,
      required String phone,
      required String email,
      required BuildContext context}) async {
    emit(UpdateUserDataLoadingState());
    try {
      Response response = await http.put(
          Uri.parse("ttps://student.valuxapps.com/api/update-proile"),
          headers: {
            'lang': 'en',
            'Authorization': token!,
          },
          body: {
            'name': name,
            'email': email,
            'phone': phone,
          });
      var responseBody = jsonDecode(response.body);

      if (responseBody['status'] == true) {
        await BlocProvider.of<UserCubit>(context).getUserData();
        emit(UpdateUserDataSuccessState());
      } else {
        emit(
          UpdateUserDataFailureState(
            message: responseBody['message'],
          ),
        );
      }
    } catch (e) {
      emit(UpdateUserDataFailureState(message: e.toString()));
    }
  }
}
