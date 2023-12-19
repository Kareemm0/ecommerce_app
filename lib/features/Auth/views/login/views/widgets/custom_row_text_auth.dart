import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/Auth/views/register/register_screen.dart';
import 'package:flutter/material.dart';

class CustomTextRowAuth extends StatelessWidget {
  const CustomTextRowAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Don't Have an Account ??"),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
            child: const Text(
              "Click Here",
              style: TextStyle(
                color: AppColor.mainColor,
              ),
            ))
      ],
    );
  }
}
