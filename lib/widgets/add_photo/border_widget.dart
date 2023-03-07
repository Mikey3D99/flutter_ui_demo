import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/constants/constants.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;


  const BorderContainer({super.key, required this.child});


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.all(10.0),
      width: screenHeight / 2,
      height: screenHeight / 2,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.white70,
        ),
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: child
          );
        },
      ),
    );
  }
}