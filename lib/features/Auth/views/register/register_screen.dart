import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/Auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/Auth/cubit/auth_cubit/auth_state.dart';
import 'package:ecommerce_app/features/home/presentaion/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textFiledItem(
                        controller: nameController, hintText: "UserName"),
                    const SizedBox(
                      height: 20,
                    ),
                    textFiledItem(
                        controller: emailController, hintText: "Email"),
                    const SizedBox(
                      height: 20,
                    ),
                    textFiledItem(
                        controller: phoneController, hintText: "Phone Number"),
                    const SizedBox(
                      height: 20,
                    ),
                    textFiledItem(
                        isObsecure: true,
                        controller: passwordController,
                        hintText: "Password"),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).register(
                              email: emailController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                              password: passwordController.text);
                        }
                      },
                      color: AppColor.mainColor,
                      textColor: Colors.white,
                      minWidth: double.infinity,
                      child: Text(
                        state is RegisterLoadingState
                            ? "Loading....."
                            : "Register",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is RegisterSuccessState) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (state is RegisterFailureState) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ));
      }
    });
  }
}

Widget textFiledItem({
  required TextEditingController controller,
  required String hintText,
  bool? isObsecure,
}) {
  return TextFormField(
    obscureText: isObsecure ?? false,
    controller: controller,
    validator: (input) {
      if (controller.text.isEmpty) {
        return "$hintText Must Not be Emprt";
      } else {
        return null;
      }
    },
    decoration:
        InputDecoration(border: const OutlineInputBorder(), hintText: hintText),
  );
}
