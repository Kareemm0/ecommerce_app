import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/Auth/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/features/Auth/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_app/features/Auth/views/reset_password/reset_password_screen.dart';
import 'package:ecommerce_app/features/Auth/views/update_user_data/update_user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<UserCubit>(context);
        if (cubit.userModel == null) cubit.getUserData();
        return Scaffold(
            body: cubit.userModel != null
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    width: double.infinity,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            cubit.userModel!.image!,
                          ),
                          radius: 45,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(cubit.userModel!.name!),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(cubit.userModel!.email!),
                        const SizedBox(
                          height: 15,
                        ),
                        MaterialButton(
                          color: AppColor.mainColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text("Update Your Password "),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MaterialButton(
                          color: AppColor.mainColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateUserDataScreen(),
                              ),
                            );
                          },
                          child: const Text("Update Your Profile "),
                        )
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
      },
    );
  }
}
