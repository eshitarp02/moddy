import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonValidation {
  static String? isValidElement(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field required';
    }
    return null;
  }

  static String? isValidEmailId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field required';
    } else if (!isValidEmail(value)) {
      return 'Requires valid email address';
    }
    return null;
  }

  static String changeFormatMonthDateString({
    required String type,
    required String timeZoneName,
  }) {
    if (type != '') {
      final dateTime = DateTime.tryParse(type);
      if (dateTime != null) {
        final formattedDate =
            DateFormat('MMM dd, yyyy hh:mm a').format(dateTime);
        final timeZone = timeZoneName.isNotEmpty == true
            ? timeZoneName
            : dateTime.timeZoneName;
        return '$formattedDate $timeZone';
      }
    }
    {
      return type;
    }
  }

  static Color hexToColor({
    required String hexColor,
  }) {
    hexColor = hexColor.replaceAll('#', '');
    return Color(
      int.parse('0xFF$hexColor'),
    );
  }
}

bool isValidUrl({
  required String url,
}) {
  // Regular expression for a simple URL validation
  final urlRegExp = RegExp(
    r'^(https?|ftp)://[^\s/$.?#].[^\s]*$',
    caseSensitive: false,
    multiLine: false,
  );

  return urlRegExp.hasMatch(url);
}

bool isValidEmail(String? email) {
  return RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  ).hasMatch(email!);
}

void openLink(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}
