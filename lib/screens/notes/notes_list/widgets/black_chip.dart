import 'package:flutter/material.dart';
import 'package:mindmemo_app/theme/colors.dart';

class BlackChip extends StatelessWidget {
  final String text;
  const BlackChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.black,
          border: Border.all(color: AppColors.black10, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Text(text, style: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),),
    );
  }
}
