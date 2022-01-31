import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.textColor,
    required this.borderColor,
    required this.text,
    required this.backgroundColor,
    this.func,
  }) : super(key: key);
  final Color textColor;
  final Color borderColor;
  final String text;
  final Function()? func;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: TextButton(
        onPressed: func,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5),
            color: backgroundColor,
          ),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          height: 30,
        ),
      ),
      // width: MediaQuery.of(context).size.width * 0.9,
      // height: 30,
      // decoration: BoxDecoration(
      //   color: backgroundColor,
      //   border: Border.all(
      //     color: borderColor,
      //   ),
      //   borderRadius: BorderRadius.circular(5),
      // ),
      // child: Text(
      //   text,
      //   style: TextStyle(
      //     color: textColor,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      // alignment: Alignment.center,
    );
  }
}
