import 'package:flutter/material.dart';

void showSnakBarItem(BuildContext context, String message, bool status) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: status ? Colors.green : Colors.red,
  ));
}
