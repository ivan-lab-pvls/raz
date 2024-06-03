import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindmemo_app/theme/colors.dart';

class CustomIconButton extends StatelessWidget {
  final String iconPath;
  final void Function()? onTap;
  const CustomIconButton({super.key, required this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 28),
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.black10, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
