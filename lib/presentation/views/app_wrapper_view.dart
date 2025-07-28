import 'package:flutter/material.dart';
import 'package:to_do_app/core/consts/asset_images.dart';

class AppWrapperView extends StatelessWidget {
  final Widget child;
  static const keyPrefix = 'AppWrapperView';

  const AppWrapperView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AssetPNGImages.appBackGround,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
