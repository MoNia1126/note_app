import 'package:flutter/material.dart';

class ColorIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 70,
      color: Theme.of(context).primaryColor,
    );
  }
}
