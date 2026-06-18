import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget tBox({
  TextEditingController? controller,
  String? hint,
  String? prefixText,
  bool? isEnable,
  TextInputType? keyType,
  Widget? suffixIcon,
}) => Container(
  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
  decoration: BoxDecoration(
    border: Border.all(color: Color(0xffC7C7C7)),
    borderRadius: BorderRadius.circular(8),
  ),
  child: TextField(
    controller: controller,
    style: TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: Color(0xFF262626),
    ),
    keyboardType: keyType,
    textAlignVertical: TextAlignVertical.center,
    textAlign: TextAlign.start,
    enabled: isEnable,
    decoration: InputDecoration(
      prefixText: prefixText,
      suffixIcon: suffixIcon,
      hintStyle: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontSize: 13.sp,
        color: Color(0xFF262626).withOpacity(.5),
      ),
      border: InputBorder.none,
      isDense: true,

      hintText: hint,
    ),
  ),
);
