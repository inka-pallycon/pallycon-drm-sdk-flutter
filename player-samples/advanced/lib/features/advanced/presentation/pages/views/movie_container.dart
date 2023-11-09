import 'package:flutter/material.dart';

class MovieContainer extends StatelessWidget {
  const MovieContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 3,
            color: Colors.orange.withAlpha(80),
          ),
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withAlpha(230),
              blurRadius: 4.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: const Offset(
                2.0, // Move to right 10  horizontally
                2.0, // Move to bottom 10 Vertically
              ),
            ),
          ]),
      child: child,
    );
  }
}
