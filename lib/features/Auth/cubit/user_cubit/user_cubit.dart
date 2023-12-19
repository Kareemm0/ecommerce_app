import 'dart:convert';

import 'package:ecommerce_app/core/utils/app_constans.dart';
import 'package:ecommerce_app/features/Auth/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_app/features/Auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

  UserModel? userModel;
  Future<void> getUserData() async {
    emit(UserLoadingState());
    Response response = await http
        .get(Uri.parse("https://student.valuxapps.com/api/profile"), headers: {
      'Authorization': token!,
      'lang': 'en',
    });
    var responseData = jsonDecode(response.body);

    if (responseData['status'] == true) {
      userModel = UserModel.fromJson(json: responseData['data']);
      emit(UserGetDataSuccessState());
    } else {
      emit(UserFailureToGetDataState(error: responseData['message']));
    }
  }
}
