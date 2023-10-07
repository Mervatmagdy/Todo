import 'package:flutter/material.dart';
import 'package:todo/MyTheme.dart';

class dialogUtils {
  static void showLoading(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [CircularProgressIndicator(), Text(message)],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context, String title, String message,
      {String? posActionName, VoidCallback? posAction,
      String?negActionName,VoidCallback?negAction
      }) {
    List<Widget> action = [];

    if (posActionName != null) {
      action.add(ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName)));
    }
    if (negActionName != null) {
      action.add(ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName)));
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titleTextStyle:Theme.of(context).textTheme.titleMedium!.copyWith(color:title=='Error'?MyTheme.redColor:MyTheme.primaryColor ),
            title: Text(title), content: Text(message), actions: action);
      },
    );
  }
}
