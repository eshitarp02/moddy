import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/palette.dart';
import 'package:toastification/toastification.dart';

class UiExtension {
  static ToastificationItem showToastError({
    required String message,
    int? duration,
  }) =>
      toastification.show(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
        title: Text(message),
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topCenter,
        type: ToastificationType.error,
        backgroundColor: Palette.errorColor,
        foregroundColor: Colors.white,
        showProgressBar: false,
        showIcon: false,
        style: ToastificationStyle.simple,
      );

  static ToastificationItem showToastSuccess({
    required String message,
    BuildContext? context,
    int? duration,
  }) =>
      toastification.show(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
        title: Text(message),
        context: context,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topCenter,
        type: ToastificationType.success,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        showProgressBar: false,
        showIcon: false,
        style: ToastificationStyle.simple,
      );
}
