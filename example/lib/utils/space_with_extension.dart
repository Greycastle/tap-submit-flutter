import 'package:flutter/material.dart';

extension SpaceWithExtension on List<Widget> {
  List<Widget> spaceWith(double space) {
    if (isEmpty) return this;

    final result = <Widget>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(SizedBox(height: space));
      }
    }
    return result;
  }
}
