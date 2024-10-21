import 'package:flutter/material.dart';
import 'package:flutter_trips_and_tricks/utils/color_manager.dart';

// ignore: must_be_immutable
class AppListTile extends StatelessWidget {
  final String btnTitle;
  final VoidCallback btnOnTap;
  Color? bgColor;
  AppListTile(
      {super.key,
      required this.btnTitle,
      required this.btnOnTap,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
          title: Center(
            child: Text(
              btnTitle,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleAlignment: ListTileTitleAlignment.center,
          tileColor: bgColor ?? ColorManager.appTheme,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          onTap: btnOnTap),
    );
  }
}
