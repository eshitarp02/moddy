import 'package:flutter/material.dart';
import 'package:to_do_app/core/consts/strings.dart';
import 'package:to_do_app/core/utils/validation.dart';

extension KeyBoardType on String {
  TextInputType get getTextInput {
    switch (this) {
      case Strings.number:
        return TextInputType.number;
      case Strings.text:
        return TextInputType.text;
      case Strings.email:
        return TextInputType.emailAddress;
      case Strings.date:
        return TextInputType.datetime;
      case Strings.phone:
        return TextInputType.phone;
      case Strings.url:
        return TextInputType.url;
      case Strings.password:
        return TextInputType.visiblePassword;
    }
    return TextInputType.text;
  }

  String? getValidation(String? type) {
    switch (this) {
      case Strings.number:
        return CommonValidation.isValidElement(type);
      case Strings.text:
        return CommonValidation.isValidElement(type);
      case Strings.email:
        return CommonValidation.isValidEmailId(type);
      case Strings.date:
        return CommonValidation.isValidElement(type);
      case Strings.phone:
        return CommonValidation.isValidElement(type);
      case Strings.url:
        return CommonValidation.isValidElement(type);
      case Strings.password:
        return CommonValidation.isValidElement(type);
    }
    return null;
  }
}
