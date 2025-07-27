import 'package:flutter/material.dart';

class TextViewMedium extends StatelessWidget {
  final String? name;
  const TextViewMedium({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Text(
      name ?? '',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
