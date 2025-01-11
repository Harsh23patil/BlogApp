import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryBox extends StatelessWidget {
  String boxName;
  CategoryBox({super.key, required this.boxName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12,8,12,8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppPallete.borderColor,
            width: 0.9,
          )),
      child: Text(
        boxName,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
