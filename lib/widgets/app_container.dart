import 'package:flutter/material.dart';
import 'package:mindmemo_app/theme/colors.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  const AppContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.black10, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: child,
    );
  }
}
