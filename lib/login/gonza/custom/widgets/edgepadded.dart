import 'package:flutter/material.dart';

class EdgePaddedWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets edgeInsets;

  const EdgePaddedWidget(Key key, this.child, this.edgeInsets)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: edgeInsets, child: child);
  }
}

class HorizontalSymmetricEdgePaddedWidget extends EdgePaddedWidget {
  HorizontalSymmetricEdgePaddedWidget(
      {Key key, Widget child, double paddingValue})
      : super(key, child, EdgeInsets.symmetric(horizontal: paddingValue));
}

class VerticalSymmetricEdgePaddedWidget extends EdgePaddedWidget {
  VerticalSymmetricEdgePaddedWidget(
      {Key key, Widget child, double paddingValue})
      : super(key, child, EdgeInsets.symmetric(vertical: paddingValue));
}

class TopOnlyEdgePaddedWidget extends EdgePaddedWidget {
  TopOnlyEdgePaddedWidget({Key key, Widget child, double padding})
      : super(key, child, EdgeInsets.only(top: padding));
}
