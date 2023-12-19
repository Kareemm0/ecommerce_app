import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/functions/shared_pref.dart';
import 'package:ecommerce_app/core/utils/app_constans.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/features/Auth/cubit/auth_cubit/auth_state.dart';
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  //Register
  void register(
      {required String email,
      required String name,
      required String phone,
      required String password}) async {
    emit(RegisterLoadingState());
    Response response = await http
        .post(Uri.parse("https://student.valuxapps.com/api/register"), body: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }, headers: {
      'lang': "en"
    });
    var reponsebody = jsonDecode(response.body);
    if (reponsebody['status'] == true) {
      emit(RegisterSuccessState());
    } else {
      emit(RegisterFailureState(message: reponsebody['message']));
    }
  }

// login
  void login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      Response response = await http.post(
          Uri.parse(
            "https://student.valuxapps.com/api/login",
          ),
          body: {
            'email': email,
            'password': password,
          },
          headers: {
            'lang': 'en'
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          await LocalStorage.insertToCache(
              key: 'token', value: data['data']['token']);
          await LocalStorage.insertToCache(key: 'password', value: password);
          currentPassword = LocalStorage.getCacheData(key: 'password');
          token = LocalStorage.getCacheData(key: 'token');

          emit(LoginSuccessState());
        } else {
          emit(
            LoginFailureState(
              message: data['message'],
            ),
          );
        }
      }
    } catch (e) {
      emit(LoginFailureState(
        message: e.toString(),
      ));
    }
  }
}
