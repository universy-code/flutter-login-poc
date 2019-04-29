import 'package:flutter/material.dart';

class RoundedRectangleRaisedButton extends RaisedButton {
  RoundedRectangleRaisedButton({double radius, VoidCallback onPressed, String text, Color color})
      : super(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          onPressed: onPressed,
          child: Text(text),
          color: color,
        );
}
