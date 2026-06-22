import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/AuthenticationScreen.dart';
import 'package:zodo_dr/Screens/AuthenticationScreen/VerificationScreen.dart';
import 'package:zodo_dr/Screens/Dashbaord/DashboardScreen.dart';
import 'package:zodo_dr/Utils/Colors.dart';
import 'package:zodo_dr/Utils/UtilsController.dart';

String login = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences pref = await SharedPreferences.getInstance();
  login = pref.getString('STATUS') ?? "";
  log("AUTH TOKEN -->${pref.getString("AUTHKEY") ?? ""}");

  Get.put(Utilscontroller());

  runApp(ZodoDoctorApp());
}
class ZodoDoctorApp extends StatelessWidget {
  ZodoDoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      child: ToastificationWrapper(
        child: GetMaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              titleSpacing: 5,
              titleTextStyle: TextStyle(
                fontFamily: "Roboto",
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(Size(double.infinity, 48)),
                backgroundColor: WidgetStateProperty.all(
                  AppColors.PrimaryColor,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                textStyle: WidgetStateProperty.all(
                  TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: InputBorder.none,
              filled: true,

              // isDense: true,
              // isCollapsed: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),

              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              fillColor: Colors.transparent,
            ),
            primaryColor: AppColors.PrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            primaryColorDark: AppColors.PrimaryColor,
            fontFamily: "Roboto",
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          home:
              (login == "IN")
                  ? DashBoardScreen()
                  : (login == "pending")
                  ? VerificationScreen()
                  : AuthenticationScreen(),
        ),
      ),
    );
  }
}
