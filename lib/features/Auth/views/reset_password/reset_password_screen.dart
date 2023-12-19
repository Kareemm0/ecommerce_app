import 'package:ecommerce_app/core/functions/show_snack_bar_function.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_constans.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_cubit.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.thirdColor,
        title: const Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: currentPasswordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: "Current Password"),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: newPasswordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: "New Password"),
            ),
            const SizedBox(
              height: 24,
            ),
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is ChangePasswordSuccessState) {
                  showSnakBarItem(
                      context, "password Updated Successfully", true);
                  Navigator.pop(context);
                }
                if (state is ChangePasswordtFailureState) {
                  showSnakBarItem(context, state.message, false);
                }
              },
              builder: (context, state) {
                return MaterialButton(
                  color: AppColor.mainColor,
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  onPressed: () {
                    if (currentPasswordController.text.trim() ==
                        currentPassword) {
                      if (newPasswordController.text.length >= 6) {
                        cubit.changePassword(
                            userCurrentPassword: currentPassword!,
                            newPassword: newPasswordController.text.trim());
                      } else {
                        showSnakBarItem(
                          context,
                          "password must be at least 6 Chrachters",
                          false,
                        );
                      }
                    } else {
                      showSnakBarItem(
                        context,
                        "please verify current password , try again later ",
                        false,
                      );
                    }
                  },
                  child: Text(state is ChangePasswordLoadingState
                      ? "Loading..."
                      : "Confirm"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
