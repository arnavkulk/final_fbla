import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String btnText = "";
  void Function() onClick;

  ButtonWidget({required this.btnText, required this.onClick});

  @override
  Widget build(BuildContext context) {
    Color orangeColors = Color(0xffF5591F);
    Color orangeLightColors = Color(0xffF2861E);
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orangeColors, orangeLightColors],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
