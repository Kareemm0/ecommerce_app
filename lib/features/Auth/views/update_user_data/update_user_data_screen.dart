import 'package:ecommerce_app/core/functions/show_snack_bar_function.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/Auth/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_cubit.dart';
import 'package:ecommerce_app/features/home/presentaion/views/cubit/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserDataScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  UpdateUserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UserCubit>(context);
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    nameController.text = cubit.userModel!.name!;
    emailController.text = cubit.userModel!.email!;
    phoneController.text = cubit.userModel!.phone!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Your Profile"),
        backgroundColor: AppColor.thirdColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: "name "),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: "email"),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: "phone"),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is UpdateUserDataSuccessState) {
                  showSnakBarItem(context, "Data Update Successflly", true);
                }
                if (state is UpdateUserDataFailureState) {
                  showSnakBarItem(context, state.message, false);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return MaterialButton(
                  color: AppColor.mainColor,
                  textColor: Colors.white,
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty) {
                      homeCubit.updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          context: context);
                    } else {
                      showSnakBarItem(context, "please enter your data", false);
                    }
                  },
                  child: state is UpdateUserDataLoadingState
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : const Text("Update"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
