import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_images.dart';
import 'package:ecommerce_app/features/Auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/Auth/cubit/auth_cubit/auth_state.dart';
import 'package:ecommerce_app/features/Auth/views/login/views/widgets/custom_row_text_auth.dart';
import 'package:ecommerce_app/features/home/presentaion/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AppImages.auhtBackground,
              ),
              fit: BoxFit.fill),
        ),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            }
            if (state is LoginFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(state.message),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 50),
                  child: const Text(
                    "Login to Your Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: AppColor.thirdColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        )),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (emailController.text.isNotEmpty) {
                                return null;
                              } else {
                                return " Email Must Not be Empaty";
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Email",
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            validator: (value) {
                              if (passwordController.text.isNotEmpty) {
                                return null;
                              } else {
                                return " Password Must Not be Empaty";
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Password",
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate() == true) {
                                BlocProvider.of<AuthCubit>(context).login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            minWidth: double.infinity,
                            color: AppColor.mainColor,
                            textColor: Colors.white,
                            child: state is LoginLoadingState
                                ? const Text("Loading...")
                                : const Text("Login"),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const CustomTextRowAuth()
                        ],
                      ),
                    ),
                  ))
            ]);
          },
        ),
      ),
    );
  }
}
